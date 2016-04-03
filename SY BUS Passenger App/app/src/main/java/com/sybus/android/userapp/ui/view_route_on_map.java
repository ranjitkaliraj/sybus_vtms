package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
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
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.presenter.RouteViewPresenter;
import com.sybus.android.userapp.presenterImpl.RouteViewPresenterImpl;
import com.sybus.android.userapp.ui.fragments.MapViewFragment;

import java.util.ArrayList;

public class view_route_on_map extends AppCompatActivity implements MapViewFragment.OnFragmentInteractionListener{

    public String TAG = this.getClass().getName();

    private MapViewFragment mapViewFragment;
    private int mapInitializationCount = 0;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_route_on_map);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        showProgressBar("Initializing Map...");

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        FragmentManager fragmentManager = getSupportFragmentManager();
        android.support.v4.app.FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        mapViewFragment = new MapViewFragment();
        fragmentTransaction.add(R.id.view_route_on_map_container, mapViewFragment);
        fragmentTransaction.commit();

        //getting co-ordinates for given selected route.
        Intent i = getIntent();
        ArrayList<LngLat> data = (ArrayList<LngLat>) i.getSerializableExtra("data");
        prepareToDisplayMap(data);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_view_route_on_map, menu);
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
    private void prepareToDisplayMap(final ArrayList<LngLat> way) {
        //Location loc = getUserLocation();
        if (mapViewFragment.isMapReady() == true) {
            mapViewFragment.setLineOnMap(way);
            mapViewFragment.setMapPosition(way.get(0).getLatitude(), way.get(0).getLongitude(), 14);
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
                        prepareToDisplayMap(way);
                    } else {
                        //Toast.makeText(getApplicationContext(), "Unable to display Route.", Toast.LENGTH_LONG).show();
                        hideProgressBar();
                        displayAlertMessage("Unable to display Route.");
                    }
                }
            }, 1000);
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
    public void onFragmentInteraction(Uri uri) {

    }
}
