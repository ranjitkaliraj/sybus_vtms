package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.support.v4.app.FragmentManager;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.location.Location;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.ui.fragments.MapViewFragment;
import com.sybus.android.userapp.util.GoogleApiLocationProvider;
import com.sybus.android.userapp.util.LocationManagerLocationProvider;


public class UserLocationActivity extends AppCompatActivity implements MapViewFragment.OnFragmentInteractionListener {

    public String TAG = this.getClass().getName();

    private LocationManagerLocationProvider locationManagerLocationProvider;
    //private GoogleApiLocationProvider googleApiLocationProvider;
    private Location location;

    private MapViewFragment mapViewFragment;

    private int userLocationRetriveCount = 0;
    private int mapInitializationCount = 0;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_location);

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
        fragmentTransaction.add(R.id.userLocationMapView, mapViewFragment);
        fragmentTransaction.commit();

        //Instantiating GPS location provider
        locationManagerLocationProvider = new LocationManagerLocationProvider(this);
        //googleApiLocationProvider = new GoogleApiLocationProvider(this);

        //Now displaying user location map.
        showProgressBar("Loading...");
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                getUserLocation();
            }
        }, 2500);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_user_location, menu);
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

        if (id == R.id.home){
            this.dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
            super.onBackPressed();
            finish();
        }
        return super.onOptionsItemSelected(item);
    }


    //This function sets the user location on Map.
    private void prepareToDisplayUserLocationOnMap(final Location loc) {
        //Location loc = getUserLocation();
        if (mapViewFragment.isMapReady() == true) {
            mapViewFragment.setMarkerOnMap(loc.getLatitude(), loc.getLongitude(), R.drawable.marker_icon);
            mapViewFragment.setMapPosition(loc.getLatitude(), loc.getLongitude(), 16);
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    hideProgressBar();
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
                        prepareToDisplayUserLocationOnMap(loc);
                    } else {
                        Toast.makeText(getApplicationContext(), "Unable to display your location.", Toast.LENGTH_LONG).show();
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
            //location = googleApiLocationProvider.getLocation();

            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    if (location == null) {

                        if (userLocationRetriveCount < 10) {
                            Log.d(TAG, "Unable to acquire your location. Re-trying again...");
                            userLocationRetriveCount = userLocationRetriveCount + 1;
                            getUserLocation();
                        } else {
                            userLocationRetriveCount = 0;
                            //Toast.makeText(getApplicationContext(), "Unable to location your location.", Toast.LENGTH_LONG).show();
                            hideProgressBar();
                            displayAlertMessage("Unable to location your location.");
                        }
                    } else {
                        Log.d(TAG, "Location acquired. Lng: "+location.getLatitude()+" and lng: "+location.getLongitude());
                        prepareToDisplayUserLocationOnMap(location);
                    }
                    Log.d(TAG, Environment.getDataDirectory().toURI().toString());
                }
            }, 2000);
        } else {
            locationManagerLocationProvider.displayGpsSettingAlert();
            Toast.makeText(this, "GPS not available.", Toast.LENGTH_LONG).show();
        }
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


    @Override
    public void onBackPressed() {
        //super.onBackPressed();
        finish();
    }

    @Override
    public void onFragmentInteraction(Uri uri) {

    }
}
