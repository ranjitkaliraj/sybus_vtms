package com.sybus.android.driverapp.views;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Handler;
import android.os.IBinder;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.sybus.android.driverapp.R;
import com.sybus.android.driverapp.model.Vehicle;
import com.sybus.android.driverapp.service.DataService;
import com.sybus.android.driverapp.activityinterface.MainActivityInterface;
import com.sybus.android.driverapp.util.NetworkConnection;
import com.sybus.android.driverapp.util.SharePreferenceManager;
import com.sybus.android.driverapp.views.components.AlertManager;

public class MainActivity extends AppCompatActivity implements MainActivityInterface {

    private String TAG = this.getClass().getName();
    private Button findScheduleButton;
    private DataService dataService;
    private boolean isBound;
    private NetworkConnection connection;

    private String vehicleName;
    private String routeName;
    private String schedule;

    private ProgressDialog vehicleDataLoadingAnimation;
    private ProgressDialog findScheduleLoadingAnimation;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Binding to data service class.
        bindService(new Intent(this, DataService.class), dataServiceConnection, Context.BIND_AUTO_CREATE);

        //getting the network status/
        Log.d(TAG, "Getting network connection status report.");
        connection = new NetworkConnection(this);

        if(connection.isNetworkConnected()==false){
            Toast.makeText(this, "Not connected to Internet.",Toast.LENGTH_LONG).show();
        }

        //adding listener to the find schedule button
        findScheduleButton = (Button) findViewById(R.id.find_schedule);
        findScheduleButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(connection.isNetworkConnected()==false){
                    Toast.makeText(getApplicationContext(), "Not connected to Internet.",Toast.LENGTH_LONG).show();
                }
                else {
                    Log.d(TAG, "Getting data and opening route find form.");
                    getVehicleData();
                }
            }
        });
    }


    //THis function get the vehicle data (route and vehicle list) by calling data service method.
    private void getVehicleData(){
        vehicleDataLoadingAnimation = AlertManager.getProgressDialog(this, "Getting Vehicle and Route list...");

        //Calling the service method to get vehicle data.
        vehicleDataLoadingAnimation.show();
        dataService.getRouteList();
    }

    //This method  display the schedule search alert box and set the vehicle and route list in the dropdown.
    @Override
    public void displayScheduleSearchAlert(final Vehicle vehicle) {
        if (vehicle==null){
            Log.d(TAG, "Vehicle is null.");
            vehicleDataLoadingAnimation.dismiss();
            Toast.makeText(this,"Error while retrieving Data list or Data not available.",Toast.LENGTH_LONG).show();
            AlertDialog.Builder errorAlert = AlertManager.getAlertDialog(this, "Error while retrieving Data list or Data not available.");
            errorAlert.show();
        }
        else{
            Log.d(TAG, "Data are downloaded and now displaying the form.");
            vehicleDataLoadingAnimation.dismiss();
            final AlertManager alertManager = new AlertManager( this, vehicle.getVehicles(), vehicle.getRoutes());
            findScheduleLoadingAnimation = AlertManager.getProgressDialog(this, "Getting Schedule...");

            AlertDialog.Builder findDialog = alertManager.displayScheduleFindAlertDialog();
            findDialog.setPositiveButton("SEARCH", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {

                    //getting user selected vehicle name and route name.
                    vehicleName = alertManager.getVehicleDropdown().getSelectedItem().toString();
                    routeName = alertManager.getRouteDropdown().getSelectedItem().toString();

                    //checking if user has selected route and vehicle from drop down.
                    if (vehicleName == "-- Select Vehicle --" || routeName == "-- Select Route --") {
                        Toast.makeText(getApplicationContext(), "Please, select Vehicle and Route from dropdown.", Toast.LENGTH_LONG).show();
                        displayScheduleSearchAlert(vehicle);
                    } else {
                        Log.d(TAG, "Find button clicked.");
                        findScheduleLoadingAnimation.show();
                        dialog.dismiss();

                        Log.d(TAG, "Calling method from service to get the schedule data.");
                        dataService.findSchedule(vehicleName, routeName);
                    }
                }
            });
            findDialog.show();
        }
    }

    //This function display location update page.
    @Override
    public void startLocationUpdate(String schedule) {
        //schedule = dataService.getSchedule();
        findScheduleLoadingAnimation.dismiss();
        if(schedule == "" || schedule == null){
            Log.d(TAG, "Schedule not available.");
            AlertDialog.Builder noScheduleErrorAlert = AlertManager.getAlertDialog(this, "Currently, schedule is not available. Cannot start updating vehicle location.");
            noScheduleErrorAlert.show();
        }
        else{
            Log.d(TAG, "now, redirecting to location activity.");
            Intent locationActivity = new Intent(getApplicationContext(), LocationActivity.class);
            //Bundle bundle = new Bundle();
            locationActivity.putExtra("vehicleName", vehicleName);
            locationActivity.putExtra("routeName", routeName);
            locationActivity.putExtra("schedule", schedule);
            //locationActivity.putExtra("data", bundle);

            unbindService(dataServiceConnection);       //unbinding the service connection to avoid serviceConnection leaked error.

            startActivity(locationActivity);
            MainActivity.this.finish();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
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
            Log.d(TAG, "Add new URL selected.");
            final AlertManager dialogClass = new AlertManager(this);
            AlertDialog.Builder urlAlert = dialogClass.displayUrlSaveAlert();
            final ProgressDialog animation = AlertManager.getProgressDialog(this, "Saving...");

            urlAlert.setPositiveButton("SAVE", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    Log.d(TAG, "Save button clicked.");
                    final String url = "http://"+dialogClass.urlText.getText().toString()+":9090/webservice";
                    SharePreferenceManager.saveToPreference(getApplicationContext(),"URL", url, "WEB_SERVICE_API_URL");

                    dialog.dismiss();
                    animation.show();

                    new Handler().postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            animation.dismiss();
                            Log.d(TAG, "Displaying toast.");
                            String value = SharePreferenceManager.readFromPreference(getApplicationContext(),"URL","http://localhost","WEB_SERVICE_API_URL");
                            Toast.makeText(getApplicationContext(), "URL successfully saved: "+value,Toast.LENGTH_LONG).show();
                        }
                    }, 1000);
                }
            });
            urlAlert.show();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    //Binding to data service.
    private ServiceConnection dataServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            DataService.DataServiceBinder binder = (DataService.DataServiceBinder) service;
            dataService = binder.getService();

            //Providing this class instance to the data service class.
            dataService.createInterface(MainActivity.this);

            isBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            isBound = false;
        }
    };
}
