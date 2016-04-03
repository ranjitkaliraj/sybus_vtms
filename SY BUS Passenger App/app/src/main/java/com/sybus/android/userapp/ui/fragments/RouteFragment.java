package com.sybus.android.userapp.ui.fragments;


import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Path;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.model.LatLng;
import com.graphhopper.GHRequest;
import com.graphhopper.GHResponse;
import com.graphhopper.GraphHopper;
import com.graphhopper.PathWrapper;
import com.graphhopper.routing.AlgorithmOptions;
import com.graphhopper.util.StopWatch;
import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.ui.pinned_map_view;
import com.sybus.android.userapp.ui.view_walking_route_on_map;
import com.sybus.android.userapp.util.GHAsyncTask;
import com.sybus.android.userapp.util.LocationManagerLocationProvider;
import com.sybus.android.userapp.util.VehicleDataCacheManager;
import com.sybus.android.userapp.view.WalkingRouteView;

import java.io.File;
import java.text.DecimalFormat;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link RouteFragment#newInstance} factory method to
 * create an instance of this fragment.
 */

public class RouteFragment extends Fragment implements WalkingRouteView {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public String TAG = this.getClass().getName();

    private String userNearStop;
    private LngLat stopLatLng;

    private TextView stopName;
    private TextView distance;
    private TextView time;

    private Button viewMapButton;

    private ProgressDialog progressBar;

    private FrameLayout pinUnavailable;
    private LinearLayout displayLayout;


    private LocationManagerLocationProvider locationManagerLocationProvider;
    private Location location;

    private int userLocationRetriveCount = 0;
    private int mapReadyCount = 0;

    //used to calculate distance
    private GraphHopper hopper = null;

    private File mapDirectory;

    private boolean isUserStopped;

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment RouteFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static android.support.v4.app.Fragment newInstance(String param1, String param2) {
        RouteFragment fragment = new RouteFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    public RouteFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_route, container, false);

        isUserStopped = false;

        stopName = (TextView) view.findViewById(R.id.walking_activity_user_stop);
        distance = (TextView) view.findViewById(R.id.walking_activity_distance);
        time = (TextView) view.findViewById(R.id.walking_activity_time);

        distance.setText("Calculating...");
        time.setText("Calculating...");

        viewMapButton = (Button) view.findViewById(R.id.walking_route_map_view);

        displayLayout = (LinearLayout) view.findViewById(R.id.walking_activity_content);
        pinUnavailable = (FrameLayout) view.findViewById(R.id.walking_activity_not_available);


        //Instantiating GPS location provider
        locationManagerLocationProvider = new LocationManagerLocationProvider(getContext());

        //Now, checking if any vehicle is pinned or not if yes then displaying in dashboard.
        try {
            DetailVehicleDto dto = VehicleDataCacheManager.getVehicle(getContext());
            userNearStop = dto.getVehicle().getUserNearStop();
            stopLatLng = dto.getUserStopLocation();

            //SettingActivity stopname
            stopName.setText(userNearStop);

            loadMapFileDirectory(dto.getUserStopLocation().getLatitude(), dto.getUserStopLocation().getLongitude());

            Log.d(TAG, "Reseting dashboard of walking route to display details.");
            displayLayout.setVisibility(View.VISIBLE);
            pinUnavailable.setVisibility(View.GONE);

        } catch (NullPointerException e) {
            e.printStackTrace();
            Log.d(TAG, "no vehicle is bookmarked.");
            resetDashboard();
        }

        viewMapButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //display walking route on map
                Log.d(TAG, "Starting to display walking route on map.");
                Intent intent = new Intent(getContext(), view_walking_route_on_map.class);
                startActivity(intent);
            }
        });

        return view;
    }


    @Override
    public void displayWalkingRouteDetail(String stopName) {

    }

    @Override
    public void resetDashboard() {
        Log.d(TAG, "Reseting dashboard of walking route");
        try {
            displayLayout.setVisibility(View.GONE);
            pinUnavailable.setVisibility(View.VISIBLE);
        }
        catch (Exception e){}
        if (hopper != null){
            hopper.close();
            hopper = null;
        }
        //mapReadyCount = 10;
        isUserStopped = true;
    }


    //This message shows progress bar
    @Override
    public void showProgressBar(String loadingMessage) {
        //Loading progressbar instantiation
        Log.d(TAG, "Displaying the progress bar.");
        progressBar = new ProgressDialog(getContext());
        progressBar.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressBar.setMessage(loadingMessage);
        progressBar.setIndeterminate(true);
        progressBar.setCanceledOnTouchOutside(false);
        progressBar.show();
    }

    //THis method hides the progressbar
    @Override
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");

        progressBar.dismiss();
    }

    @Override
    public void displayAlertMessage(String alertMessage) {
        Log.d(TAG, "Displaying alert message: " + alertMessage);
        //status message dialog box
        AlertDialog.Builder statusMessageDialog = new AlertDialog.Builder(getContext());
        statusMessageDialog.setMessage(alertMessage);
        statusMessageDialog.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        statusMessageDialog.show();
    }



    public void setDetailInformation(final double stop_lat, final double stop_lng) {
        Log.d(TAG, "Getting user location");

        if (locationManagerLocationProvider.canGetLocation() == true) {
            Log.d(TAG, "calling locationmanager funciton to get location.");
            location = locationManagerLocationProvider.getLocation();

            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    if (location == null) {

                        if (userLocationRetriveCount < 10) {
                            Log.d(TAG, "Unable to acquire your location. Re-trying again...");
                            userLocationRetriveCount = userLocationRetriveCount + 1;
                            setDetailInformation(stop_lat, stop_lng);
                        } else {
                            Toast.makeText(getContext(), "Unable to get your location.", Toast.LENGTH_LONG).show();
                            userLocationRetriveCount = 0;
                        }
                    } else {
                        Log.d(TAG, "Location acquired. Lng: " + location.getLatitude() + " and lng: " +location.getLongitude());
                        //prepareToDisplayMap(location);

                        //first checking hopper is ready or not.
                        if(hopper!=null) {
                            setUserToStopDistanceValue(location.getLatitude(), location.getLongitude(), stop_lat, stop_lng);
                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    //relooping to update every 20 seconds.
                                    setDetailInformation(stop_lat, stop_lng);
                                }
                            },20000);
                        }
                        else{
                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    Log.d(TAG, "Hopper is not ready, again calling setDetailInformation() method.");
                                    if(mapReadyCount>6){
                                        if(isUserStopped==false){
                                            displayAlertMessage("Unable to identify distance and estimated time.");
                                            distance.setText("Not Available");
                                            time.setText("Not Available");
                                            mapReadyCount = 0;
                                        }
                                    }
                                    else{
                                        setDetailInformation(stop_lat, stop_lng);
                                        mapReadyCount = mapReadyCount+1;
                                    }
                                }
                            },2000);
                        }
                    }
                    Log.d(TAG, Environment.getDataDirectory().toURI().toString());
                }
            }, 800);
        } else {
            locationManagerLocationProvider.displayGpsSettingAlert();
            Toast.makeText(getContext(), "GPS not available.", Toast.LENGTH_LONG).show();
        }
    }




    //in order to refresh value. everytime the fragment/activity displayed this method should be called.
    //This function calculate the shortest path between two points
    public void setUserToStopDistanceValue(final double fromLat, final double fromLon,
                                           final double toLat, final double toLon) {
        Log.d(TAG, "calculating distance value...");
        new AsyncTask<Void, Void, PathWrapper>() {
            float time1;

            protected PathWrapper doInBackground(Void... v) {
                StopWatch sw = new StopWatch().start();
                GHRequest req = new GHRequest(fromLat, fromLon, toLat, toLon).
                        setAlgorithm(AlgorithmOptions.DIJKSTRA_BI);
                req.getHints().
                        put("instructions", "false");
                GHResponse resp = hopper.route(req);
                time1 = sw.stop().getSeconds();
                return resp.getBest();
            }

            protected void onPostExecute(PathWrapper resp) {
                if (!resp.hasErrors()) {
                    Log.d(TAG, "from:" + fromLat + "," + fromLon + " to:" + toLat + ","
                            + toLon + " found path with distance:" + resp.getDistance()
                            / 1000f + ", nodes:" + resp.getPoints().getSize() + ", time:"
                            + time + " " + resp.getDebugInfo());
                    Log.d(TAG, "the route is " + (int) (resp.getDistance() / 100) / 10f
                            + "km long, time:" + resp.getTime() / 60000f + "min, debug:" + time);

                    //SettingActivity distance
                    DecimalFormat df = new DecimalFormat("#.##");
                    DecimalFormat df1 = new DecimalFormat("#");

                    double ddistance = (resp.getDistance() / 100) / 10f;
                    int dtime = (int)(resp.getTime() / 60000f);

                    //setUserToStopDistance(resp.getDistance() + "");
                    distance.setText(df.format(ddistance) + " Km");
                    time.setText(df1.format(ddistance*10)+ " mins of walking");
                    //mapView.redraw();
                } else {
                    Log.d(TAG, "Error:" + resp.getErrors());
                }
            }
        }.execute();
    }



    //This function loads map from the storage
    private void loadMapFileDirectory(double lat, double lng) {
        //Loading offline map data.
        if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
            Log.d(TAG, "Cannot read the storage at the moment. Please, try again later.");
            //displayAlertMessage("Cannot read media storage.");
            return;
        }
        try {
            mapDirectory = new File(Environment.getExternalStorageDirectory(), "/sybus_data/map");
        } catch (Exception e) {
            //displayAlertMessage("Cannot read the map data.");
        }

        loadGraphStorage(lat, lng);
    }


    void loadGraphStorage(final double lat, final double lng) {
        new GHAsyncTask<Void, Void, Path>() {
            protected Path saveDoInBackground(Void... v) throws Exception {
                GraphHopper tmpHopp = new GraphHopper().forMobile();
                //tmpHopp.load(mapRootDirectory);
                Log.d(TAG, "Apple" + mapDirectory.getAbsolutePath().toString());
                tmpHopp.load(mapDirectory.getAbsolutePath());
                //Log.d(TAG, "found graph " + tmpHopp.getGraphHopperStorage().toString() + ", nodes:" + tmpHopp.getGraphHopperStorage().getNodes());
                hopper = tmpHopp;
                return null;
            }

            protected void onPostExecute(Path o) {
                if (hasError()) {
                    Log.d(TAG, "An error occured while displaying Map:" + mapDirectory.getAbsolutePath().toString());
                    Log.d(TAG, "An error happend while creating graph:"
                            + getErrorMessage());
                } else {
                    Log.d(TAG, "Map loaded successfully.");
                    //SettingActivity detail information of distance and time
                    setDetailInformation(lat, lng);
                }
            }
        }.execute();
    }
}
