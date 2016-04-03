package com.sybus.android.userapp.ui;

import android.app.ProgressDialog;
import android.content.Intent;
import android.location.Location;
import android.net.Uri;
import android.os.Handler;
import android.support.v4.app.FragmentManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.presenter.TrackPresenter;
import com.sybus.android.userapp.presenterImpl.TrackPresenterImpl;
import com.sybus.android.userapp.ui.fragments.MapViewFragment;
import com.sybus.android.userapp.view.DetailDisplayView;

public class DetailActivity extends AppCompatActivity implements DetailDisplayView, MapViewFragment.OnFragmentInteractionListener{

    public String TAG = this.getClass().getName();

    private TextView vehicleName;
    private TextView currentLocation;
    private TextView routeName;
    private TextView nextStop;
    private TextView userStop;
    private TextView eta;

    private DetailVehicleDto vehicleDetail;

    private MapViewFragment mapViewFragment;

    private LinearLayout bookmarkButton;

    private ProgressDialog progressBar;
    private TrackPresenter trackPresenter;

    private int mapInitializationCount;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        //Initializing presenter
        Log.d(TAG, "Initialiazing Track Presenter.");
        trackPresenter = new TrackPresenterImpl(this);
        trackPresenter.setContext(this);


        //Initializing map
        FragmentManager fragmentManager = getSupportFragmentManager();
        android.support.v4.app.FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        mapViewFragment = new MapViewFragment();
        fragmentTransaction.add(R.id.detail_activity_mapView, mapViewFragment);
        fragmentTransaction.commit();

        Log.d(TAG, "Initializing layout");
        vehicleName = (TextView) findViewById(R.id.detail_activity_vehicle_name);
        currentLocation =(TextView) findViewById(R.id.detail_activity_current_road);
        routeName = (TextView) findViewById(R.id.detail_activity_route_name);
        nextStop = (TextView) findViewById(R.id.detail_activity_next_stop);
        userStop = (TextView) findViewById(R.id.detail_activity_nearest_stop);
        eta = (TextView) findViewById(R.id.detail_activity_ETA);

        bookmarkButton = (LinearLayout) findViewById(R.id.detail_activity_pin);
        bookmarkButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                trackPresenter.cacheVehicleDetail(vehicleDetail);
            }
        });


        Log.d(TAG,"De-serializing the vehicle object." );
        Intent i = getIntent();
        vehicleDetail = (DetailVehicleDto) i.getSerializableExtra("vehicleDetail");
        if(vehicleDetail==null){
            Log.d(TAG, "Null apple");
        }

        Log.d(TAG, "vehicle:");
        displayDetails(vehicleDetail);
    }


    private void displayDetails(DetailVehicleDto vehicle){
        Log.d(TAG, "Displaying details.");
        vehicleName.setText(vehicle.getVehicle().getVehicleName());
        currentLocation.setText(vehicle.getVehicle().getCurrentLocation());
        routeName.setText(vehicle.getVehicle().getRouteName());
        nextStop.setText(vehicle.getVehicle().getNextStop());
        userStop.setText(vehicle.getVehicle().getUserNearStop());
        eta.setText(vehicle.getVehicle().getETA());

        //SettingActivity vehicle marker and route way
        //mapViewFragment.setMarkerOnMap(vehicle.getVehicleLocation().getLatitude(), vehicle.getVehicleLocation().getLongitude(), R.drawable.marker_bus);
        //mapViewFragment.setLineOnMap(vehicle.getWay());
        //mapViewFragment.setMapPosition(vehicle.getVehicleLocation().getLatitude(), vehicle.getVehicleLocation().getLongitude(), 14);
        prepareToDisplayMap(vehicle);
    }

    //This function sets the vehicle location on Map.
    private void prepareToDisplayMap(final DetailVehicleDto vehicle) {
        //Location loc = getUserLocation();
        try{
            hideProgressBar();
        }
        catch(Exception e){}
        showProgressBar("Initializing Map...");
        if (mapViewFragment.isMapReady() == true) {
            //mapViewFragment.setMarkerOnMap(loc.getLatitude(), loc.getLongitude(), R.drawable.marker_user_location);
            //mapViewFragment.setMapPosition(loc.getLatitude(), loc.getLongitude(), 16);
            //SettingActivity vehicle marker and route way
            mapViewFragment.setMarkerOnMap(vehicle.getVehicleLocation().getLatitude(), vehicle.getVehicleLocation().getLongitude(), R.drawable.marker_bus);
            mapViewFragment.setLineOnMap(vehicle.getWay());
            mapViewFragment.setMapPosition(vehicle.getVehicleLocation().getLatitude(), vehicle.getVehicleLocation().getLongitude(), 14);


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
                        prepareToDisplayMap(vehicle);
                    } else {
                        Toast.makeText(getApplicationContext(), "Unable to display map.", Toast.LENGTH_LONG).show();
                        hideProgressBar();
                    }
                }
            }, 4000);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_detail, menu);
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
            //NavUtils.navigateUpFromSameTask(this);

            this.finish();
            this.dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
            //this.dispatchKeyEvent(new KeyEvent(KeyEvent.KEYCODE_NAVIGATE_PREVIOUS, KeyEvent.KEYCODE_BACK));
            //new KeyEvent(KeyEvent.KEYCODE_NAVIGATE_PREVIOUS)
            super.onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void displayDashBoard() {
        Log.d(TAG, "Redirecting to the dashboard.");

        //showProgressBar("Pinning...");

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);        //remove all previous intents/activities
                hideProgressBar();
                startActivity(intent);
                finish();
            }
        }, 1500);
    }

    //This message shows progress bar
    @Override
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

    //THis method hides the progressbar
    @Override
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        progressBar.dismiss();
    }

    @Override
    public void onFragmentInteraction(Uri uri) {

    }
}
