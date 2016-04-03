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
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.util.VehicleDataCacheManager;

import org.mapsforge.map.layer.Layers;

import java.util.ArrayList;

public class pinned_map_view extends AppCompatActivity implements MapViewFragment.OnFragmentInteractionListener{

    public String TAG = this.getClass().getName();

    private LocationManagerLocationProvider locationManagerLocationProvider;
    private Location location;

    private MapViewFragment mapViewFragment;

    private DetailVehicleDto vehicleDetails;
    private LngLat destination = new LngLat();
    private LngLat destStop = new LngLat();
    private LngLat userStop = new LngLat();
    private LngLat vehicle = new LngLat();
    private ArrayList<LngLat> way;

    private int userLocationRetriveCount = 0;
    private int mapInitializationCount = 0;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    //used this to remove/update location of vehicle and user location on map.
    private Layers vehicleLocationLayer;
    private Layers userLocationLayer;

    private boolean isVehicleLocationAlreadyDisplayed = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pinned_map_view);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Log.d(TAG, "Initializing and adding mapview.");
        //FragmentManager fragmentManager = getFragmentManager();
        //FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        //mapViewFragment = new MapViewFragment();
        //fragmentTransaction.add(R.id.userLocationMapView, mapViewFragment);
        //fragmentTransaction.commit();

        FragmentManager fragmentManager = getSupportFragmentManager();
        android.support.v4.app.FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        mapViewFragment = new MapViewFragment();
        fragmentTransaction.add(R.id.pinnedMapView, mapViewFragment);
        fragmentTransaction.commit();

        //Instantiating GPS location provider
        locationManagerLocationProvider = new LocationManagerLocationProvider(this);

        //getting vehicle cache details.
        try {
            vehicleDetails = VehicleDataCacheManager.getVehicle(getApplicationContext());

            destination.setLatitude(vehicleDetails.getDestinationLocation().getLatitude());
            destination.setLongitude(vehicleDetails.getDestinationLocation().getLongitude());

            destStop.setLatitude(vehicleDetails.getDestStopLocation().getLatitude());
            destStop.setLongitude(vehicleDetails.getDestStopLocation().getLongitude());

            userStop.setLatitude(vehicleDetails.getUserStopLocation().getLatitude());
            userStop.setLongitude(vehicleDetails.getUserStopLocation().getLongitude());

            vehicle.setLatitude(vehicleDetails.getVehicleLocation().getLatitude());
            vehicle.setLongitude(vehicleDetails.getVehicleLocation().getLongitude());

            way = vehicleDetails.getWay();

            //now getting user location and displaying in map
            showProgressBar("Loading...");
            updateVehicleLocation();

        } catch (NullPointerException e) {
            e.printStackTrace();
        }
    }



    //This function sets the user location on Map.
    private void prepareToDisplayMap(final Location loc) {
        //Location loc = getUserLocation();
        if (mapViewFragment.isMapReady() == true) {

            //SettingActivity user location

            if(isVehicleLocationAlreadyDisplayed){
                //removing old user and vehicle location position
                userLocationLayer.remove(1);
                vehicleLocationLayer.remove(1);

                //these are variable unlike others below, that need dynamic update. so instance is saved in order to change its location later.
                userLocationLayer = mapViewFragment.setMarkerOnMap(loc.getLatitude(), loc.getLongitude(), R.drawable.marker_icon);
                vehicleLocationLayer = mapViewFragment.setMarkerOnMap(vehicle.getLatitude(), vehicle.getLongitude(), R.drawable.marker_bus);
                isVehicleLocationAlreadyDisplayed = true;
            }
            else{
                //these are variable unlike others below, that need dynamic update. so instance is saved in order to change its location later.
                userLocationLayer = mapViewFragment.setMarkerOnMap(loc.getLatitude(), loc.getLongitude(), R.drawable.marker_icon);
                vehicleLocationLayer = mapViewFragment.setMarkerOnMap(vehicle.getLatitude(), vehicle.getLongitude(), R.drawable.marker_bus);
                isVehicleLocationAlreadyDisplayed = true;
            }

            //destination
            mapViewFragment.setMarkerOnMap(destination.getLatitude(), destination.getLongitude(), R.drawable.marker_user_location);
            //destination stop
            mapViewFragment.setMarkerOnMap(destStop.getLatitude(), destStop.getLongitude(), R.drawable.marker_dest);
            //user stop
            mapViewFragment.setMarkerOnMap(userStop.getLatitude(), userStop.getLongitude(), R.drawable.marker_bus_stop);
            //route way
            mapViewFragment.setLineOnMap(way);

            mapViewFragment.setMapPosition(vehicle.getLatitude(), vehicle.getLongitude(), 14);
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    try {
                        hideProgressBar();
                    }catch(Exception e){}
                }
            }, 1000);
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    updateVehicleLocation();
                }
            }, 20000);
        }
        else {
            Log.d(TAG, "Map is not ready. Waiting for sometime and retrying again.");
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    //trying for only 10 times
                    if (mapInitializationCount < 10) {
                        Log.d(TAG, "Map is still loading, retrieving again.");
                        mapInitializationCount = mapInitializationCount + 1;

                        //calling to display map again/ incase if map is ready after the handler delayed time.
                        prepareToDisplayMap(loc);
                    } else {
                        Toast.makeText(getApplicationContext(), "Unable to initialize map correctly.", Toast.LENGTH_LONG).show();
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



    //This function regularly update the status board for distance and route.
    public void updateVehicleLocation(){
        if(new NetworkConnection(getApplicationContext()).isNetworkConnected()){
            getUserLocation();
        }
        else {
            displayAlertMessage("Cannot update vehicle location. Please, connect to the Internet.");
        }
    }


    //##############################################################################################

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_pinned_map_view, menu);
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
