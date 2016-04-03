package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.location.Location;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.support.v4.app.FragmentManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.ui.fragments.MapViewFragment;
import com.sybus.android.userapp.util.LocationManagerLocationProvider;
import com.sybus.android.userapp.util.VehicleDataCacheManager;

import org.mapsforge.map.layer.Layers;

import java.text.DecimalFormat;

public class view_walking_route_on_map extends AppCompatActivity implements MapViewFragment.OnFragmentInteractionListener{

    public String TAG = this.getClass().getName();

    private LocationManagerLocationProvider locationManagerLocationProvider;
    private Location location;

    private MapViewFragment mapViewFragment;

    private int userLocationRetriveCount = 0;
    private int mapInitializationCount = 0;

    private LngLat stopLocation;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    private TextView statusDistance;
    private TextView statusTime;

    private Layers userLocationLayer;
    private Layers stopLocationLayer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_walking_route_on_map);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        statusDistance = (TextView) findViewById(R.id.walking_route_map_view_distance);
        statusTime = (TextView) findViewById(R.id.walking_route_map_view_time);

        //Initializing map view
        FragmentManager fragmentManager = getSupportFragmentManager();
        android.support.v4.app.FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        mapViewFragment = new MapViewFragment();
        fragmentTransaction.add(R.id.walkingRouteMapView, mapViewFragment);
        fragmentTransaction.commit();

        //Instantiating GPS location provider
        locationManagerLocationProvider = new LocationManagerLocationProvider(this);

        //getting vehicle cache details.
        try {
            DetailVehicleDto vehicleDetails = VehicleDataCacheManager.getVehicle(getApplicationContext());
            stopLocation = new LngLat();
            stopLocation.setLatitude(vehicleDetails.getUserStopLocation().getLatitude());
            stopLocation.setLongitude(vehicleDetails.getUserStopLocation().getLongitude());

            //now getting user location and displaying in map
            showProgressBar("Loading...");
            getUserLocation();

        } catch (NullPointerException e) {
            e.printStackTrace();
        }
    }


    //This function sets the user location on Map.
    private void prepareToDisplayMap(final Location loc) {
        //Location loc = getUserLocation();
        if (mapViewFragment.isMapReady() == true) {

            try {
                userLocationLayer.remove(1);
                stopLocationLayer.remove(1);
            }
            catch (NullPointerException e){}

            //SettingActivity user location
            userLocationLayer = mapViewFragment.setMarkerOnMap(loc.getLatitude(), loc.getLongitude(), R.drawable.marker_icon);
            stopLocationLayer = mapViewFragment.setMarkerOnMap(stopLocation.getLatitude(), stopLocation.getLongitude(), R.drawable.marker_bus_stop);

            mapViewFragment.displayShortestDistance(loc.getLatitude(), loc.getLongitude(), stopLocation.getLatitude(), stopLocation.getLongitude());

            mapViewFragment.setMapPosition(loc.getLatitude(), loc.getLongitude(), 14);

            //setting the header value.
            DecimalFormat df = new DecimalFormat("#.##");
            DecimalFormat df1 = new DecimalFormat("#");
            double dist = (mapViewFragment.getShortestDistanceLength()/100)/10f;
            statusDistance.setText(df.format(dist) + " Km");
            statusTime.setText(df1.format(dist*10)+ " mins of walking");


            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    hideProgressBar();
                    //auto start auto update map.
                    autoUpdateMap();
                }
            }, 1000);
        } else {
            Log.d(TAG, "Map is not ready. Waiting for sometime and retrying again.");
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    //trying for only 10 times
                    if (mapInitializationCount < 10) {
                        Log.d(TAG, "Location is still loading, retrieving again.");
                        mapInitializationCount = mapInitializationCount + 1;

                        //calling to display map again/ incase if map is ready after the handler delayed time.
                        prepareToDisplayMap(loc);
                    } else {
                        Toast.makeText(getApplicationContext(), "Map is not initialized correctly.", Toast.LENGTH_LONG).show();
                        hideProgressBar();
                    }
                }
            }, 1000);
        }
    }


    public void getUserLocation() {
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
                            getUserLocation();
                        } else {
                            Toast.makeText(getApplicationContext(), "Unable to location your location.", Toast.LENGTH_LONG).show();
                        }
                    } else {
                        Log.d(TAG, "Location acquired. Lng: "+location.getLatitude()+" and lng: "+location.getLongitude());
                        prepareToDisplayMap(location);
                    }
                    Log.d(TAG, Environment.getDataDirectory().toURI().toString());
                }
            }, 800);
        } else {
            locationManagerLocationProvider.displayGpsSettingAlert();
            Toast.makeText(this, "GPS not available.", Toast.LENGTH_LONG).show();
        }
    }



    //Start displaying map and information on regular interval. i.e. every 20 seconds.
    public void autoUpdateMap(){
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                //auto start auto update map.
                getUserLocation();
            }
        }, 20000);
    }

    //##############################################################################################

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_view_walking_route_on_map, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onFragmentInteraction(Uri uri) {

    }



    //This message shows progress bar
    public void showProgressBar(String loadingMessage) {
        //Loading progressbar instantiation
        Log.d(TAG, "Displaying the progress bar.");
        progressBar = new ProgressDialog(this);
        progressBar.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressBar.setMessage(loadingMessage);
        progressBar.setIndeterminate(true);
        progressBar.setCanceledOnTouchOutside(false);
        progressBar.show();
    }

    public void displayAlertMessage(String alertMessage) {
        //status message dialog box
        statusMessageDialog = new AlertDialog.Builder(this);
        statusMessageDialog.setMessage(alertMessage);
        statusMessageDialog.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        statusMessageDialog.show();
    }

    //THis method hides the progressbar
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        //progressBar.hide();
        progressBar.dismiss();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mapViewFragment.destroyMapObject();
    }
}
