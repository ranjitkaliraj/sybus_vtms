package com.sybus.android.driverapp.views;

import android.app.ProgressDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.ServiceConnection;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.driverapp.R;
import com.sybus.android.driverapp.activityinterface.LocationActivityInterface;
import com.sybus.android.driverapp.service.LocationService;
import com.sybus.android.driverapp.util.LocationManagerLocationProvider;
import com.sybus.android.driverapp.util.NetworkConnection;
import com.sybus.android.driverapp.views.components.AlertManager;

import java.text.DecimalFormat;
import java.util.Timer;
import java.util.TimerTask;

public class LocationActivityV2 extends AppCompatActivity implements LocationActivityInterface {
    private LocationService locationService;
    private boolean isBound;

    private TextView vehicleName;
    private TextView routeName;
    private TextView schedule;
    private TextView latitude;
    private TextView longitude;

    private Button startButton;
    private Button cancelButton;
    private ProgressBar locationUpdateProgressBar;

    private Double latitudeValue;
    private Double longitudeValue;

    private LocationManagerLocationProvider locationManagerLocationProvider;
    private NetworkConnection connection;
    private Location location;

    private boolean isLocationUpdateStarted;
    private boolean isLocationAcquired;
    private boolean isLocationAcquiredForFirstTime;
    private boolean isLocationBeingAcquiredForFirstTime;
    private int locationAcquireCount;

    private Timer timer;
    private TimerTask timerTask;
    private Handler handler = new Handler();

    private ProgressDialog exitAnimation;

    private final String TAG = this.getClass().getName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_location);

        //Binding to location service.
        bindService(new Intent(this, LocationService.class), locationServiceConnection, Context.BIND_AUTO_CREATE);

        //instantiating network connection
        connection = new NetworkConnection(this);

        Log.d(TAG, "Setting location update start status to false");
        isLocationAcquired = false;
        isLocationUpdateStarted = false;
        isLocationAcquiredForFirstTime = false;
        isLocationBeingAcquiredForFirstTime = true;  //location is being acquired for first time.
        locationAcquireCount = 0;

        vehicleName = (TextView) findViewById(R.id.vehicle_name);
        routeName = (TextView) findViewById(R.id.route_name);
        schedule = (TextView) findViewById(R.id.schedule_name);
        latitude = (TextView) findViewById(R.id.latitude);
        longitude = (TextView) findViewById(R.id.longitude);

        //Bundle bundle = savedInstanceState.getBundle("data");
        Intent i = getIntent();

        Log.d(TAG, "Setting vehicle name, routename, schedule in the page.");

        vehicleName.setText(i.getStringExtra("vehicleName"));
        routeName.setText(i.getStringExtra("routeName"));
        schedule.setText(i.getStringExtra("schedule"));
        latitude.setText("N/A");
        longitude.setText("N/A");

        //Instantiating LocationManagerLocationProvider object
        locationManagerLocationProvider = new LocationManagerLocationProvider(LocationActivityV2.this);

        locationUpdateProgressBar = (ProgressBar) findViewById(R.id.locationUpdateProgressBar);
        locationUpdateProgressBar.setVisibility(View.INVISIBLE);        //Setting progress bar initially hidden.

        startButton = (Button) findViewById(R.id.start);
        cancelButton = (Button) findViewById(R.id.cancel);

        setOnClickListenerToStartButton();

        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "Stop button clicked, now displaying confirmation alert.");
                displayCancelConfirmation();
            }
        });
        cancelButton.setEnabled(true);         //initially disabling the cancel button.
    }

    //This function start location update, get the longitude and latitude of the user location and send to server.
    private void startLocationUpdate() {

        //changing the button.
        changeStartToStopButton();
        Log.d(TAG, "Starting the location update from activity.");

        location = locationManagerLocationProvider.getLocation();

        //Checking if location is being acquired for first time. if so then displaying acquiring location toast.
        if (isLocationBeingAcquiredForFirstTime == true) {
            Log.d(TAG, "Location is being acquired for the first time. so displaying toast mesage for first acquired");
            Toast.makeText(LocationActivityV2.this, "Acquiring GPS location...", Toast.LENGTH_SHORT).show();

            latitude.setText("acquiring...");
            longitude.setText("acquiring...");

            startButton.setEnabled(false);
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    //just for delay of 4 seconds to display acquiring location toast message
                    isLocationBeingAcquiredForFirstTime = false;
                    startButton.setEnabled(true);
                    Log.d(TAG, "After initial GPS acquiring toast inside handler.");

                    //Setting location information
                    updateLocationInfo(location);

                }
            }, 3000);
            Log.d(TAG, "After initial GPS acquiring toast outside handler.");
        }
        else {
            updateLocationInfo(location);
        }
    }

    private void updateLocationInfo(Location location) {
        if (location == null) {
            //new timer instance for getting location object.
            Timer loadNewLocationTimer = new Timer();

            isLocationAcquiredForFirstTime = false;
            isLocationBeingAcquiredForFirstTime = false;
            locationAcquireCount = locationAcquireCount + 1;
            if (locationAcquireCount == 3) {
                Toast.makeText(LocationActivityV2.this, "Unable to acquire GPS Location. Stopping...", Toast.LENGTH_SHORT).show();
                locationAcquireCount = 0;  //resseting.

                //Stopping location gettin tiemr.
                loadNewLocationTimer.cancel();

                //Stopping the location button by clicking the stop button.
                startButton.performClick();
            }
            else {
                Toast.makeText(LocationActivityV2.this, "Unable to acquire GPS Co-ordinates. Retrying...", Toast.LENGTH_SHORT).show();
                Log.d(TAG, "device location returned null.");

                latitude.setText("acquiring...");
                longitude.setText("acquiring...");

                //Setting 10 second delay timer to get new location.
                loadNewLocationTimer.schedule(new TimerTask() {
                    @Override
                    public void run() {
                        Log.d(TAG, "Retrying to get device location again. count: " + locationAcquireCount);
                        startLocationUpdate();
                    }
                }, 10000);

                /*while (isLocationAcquired == false){
                    new Handler().postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            Log.d(TAG, "Retrying to get device location again.");
                            startLocationUpdate();
                        }
                    }, 10000);
                }*/
            }
        } else {
            //CHange location acquired to true
            isLocationAcquired = true;
            //IF the location is acquired for first time.
            if (isLocationAcquiredForFirstTime == false) {
                //this toast will show if location is previously not acquired.
                Toast.makeText(this, "Location Acquired.", Toast.LENGTH_LONG).show();
                isLocationAcquiredForFirstTime = true;
            }

            Log.d(TAG, "Setting longitude and latitude on local variable.");
            latitudeValue = location.getLatitude();
            longitudeValue = location.getLongitude();

            DecimalFormat df = new DecimalFormat("#.######");

            Log.d(TAG, "Setting and displaying GPS data to user.");
            latitude.setText(df.format(latitudeValue).toString());
            longitude.setText(df.format(longitudeValue).toString());

            Log.d(TAG, "Sending the GPS data to the server.");

            Log.d(TAG, "Checking network availability, before calling service method to send data to server.");
            //checking if the network is connected or not.
            if (connection.isNetworkConnected() == true) {
                Log.d(TAG, "Network is available, calling service method to send data to server.");
                sendGPSData(latitudeValue, longitudeValue);
            } else {
                Toast.makeText(this, "Network Unavailable", Toast.LENGTH_LONG).show();

                //Stopping the location button by clicking the stop button.
                startButton.performClick();
            }
        }
    }

    private void changeStartToStopButton() {
        Log.d(TAG, "changing start to stop button.");
        //Changing the Start button to stop button to stop updating lcation service.
        startButton.setText("STOP");
        startButton.setOnClickListener(null);  //removing previous listener

        //WindowManager$BadTokenException: Unable to add window -- token null is not for an application erro if put inside the listner block
        final ProgressDialog exitAnimation = AlertManager.getProgressDialog(this, "Stopping...");
        //Adding listener to stop location update.
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                exitAnimation.show();

                Log.d(TAG, "changing stop to start button.");
                //Again changing the button to Start.
                startButton.setText("START");

                //displaying the animation for 3 seconds and stopping.
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        exitAnimation.dismiss();

                        //stopping the location update first.
                        stopLocationUpdate();
                        //displaying toast.
                        Toast.makeText(getApplicationContext(), "Location update Stopped.", Toast.LENGTH_LONG).show();

                        latitude.setText("N/A");
                        longitude.setText("N/A");

                        cancelButton.setEnabled(true);  //disabling the cancel button
                        locationUpdateProgressBar.setVisibility(View.INVISIBLE);
                        isLocationBeingAcquiredForFirstTime = true;
                        isLocationAcquiredForFirstTime = false;

                        //now setting listener to the start button since the above click will change to stop button to start button and start button need to re-start location button on click
                        setOnClickListenerToStartButton();
                    }
                }, 1200);
            }
        });
    }

    private void setOnClickListenerToStartButton() {
        //Adding listener to start location update.
        startButton.setOnClickListener(null);  //removing previous listener
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Log.d(TAG, "Start button clicked, starting updating location.");
                cancelButton.setEnabled(false);
                locationUpdateProgressBar.setVisibility(View.VISIBLE);
                startLocationUpdateTimer();

            }
        });
    }


    //This function stops the location update.
    private void stopLocationUpdate() {
        Log.d(TAG, "Stopping the location update from activity.");

        //stopping regular intervalled update.
        stopLocationUpdatetimerTask();

        if(isLocationAcquiredForFirstTime == true) {
            //stopping getting data from device GPS.
            locationManagerLocationProvider.stopLocationUpdate();
        }


        //deleting the vehicle location update session in server
        //locationService.stopLocationUpdate(vehicleName.getText().toString(), routeName.getText().toString());
    }

    //This function send the GPS data to the server by calling service method.
    private void sendGPSData(Double latitudeValue, Double longitudeValue) {
        Log.d(TAG, "Sending GPS data to service.");

        if (connection.isNetworkConnected()) {
            locationService.updateLocation(latitudeValue, longitudeValue, vehicleName.getText().toString(), routeName.getText().toString());
        } else {
            Toast.makeText(this, "Network Unavailable, stopping location service update.", Toast.LENGTH_LONG).show();
            //stopping location update.
            stopLocationUpdate();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_location, menu);
        return true;
    }

    @Override
    public void onBackPressed() {
        displayCancelConfirmation();
    }

    //This function display confirmation alert when user click cancel or back button.
    private void displayCancelConfirmation() {
        //first showing confirmation message
        Log.d(TAG, "Displaying cancel confirmation alert.");
        AlertDialog.Builder mAlertDialog = new AlertDialog.Builder(this);
        mAlertDialog.setTitle("ALERT");
        mAlertDialog.setMessage("Are you sure want to exit updating location co-ordinates?");


        exitAnimation = new ProgressDialog(this);

        mAlertDialog.setPositiveButton("EXIT", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                exitAnimation.setProgressStyle(ProgressDialog.STYLE_SPINNER);
                exitAnimation.setMessage("Cancelling...");
                exitAnimation.setIndeterminate(true);
                exitAnimation.setCanceledOnTouchOutside(false);

                exitAnimation.show();

                //displaying the animation for 2 seconds and exiting.
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {

                        //stopping vehicle update and removing the session from server.
                        locationService.stopLocationUpdate(vehicleName.getText().toString(), routeName.getText().toString());

                        //exitAnimation.dismiss();
                        //dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
                    }
                }, 2000);
            }
        });
        mAlertDialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });
        mAlertDialog.show();
    }


    @Override
    //this function is triggred if error occured while updating vehicle lcoation in server.
    public void stopLocationUpdateByServerError() {
        Toast.makeText(this, "Error while stopping updating location in Server.", Toast.LENGTH_LONG).show();
        stopLocationUpdate();

        unbindService(locationServiceConnection);

        Log.d(TAG, "now, redirecting to Main activity.");
        Intent i = new Intent(getApplicationContext(), MainActivity.class);
        startActivity(i);
        finish();       //avoid re displaying location updating page on back button click.

        exitAnimation.dismiss();
    }


    @Override
    public void redirectToMainActivity() {
        //Toast.makeText(this, "Exit location update without starting.", Toast.LENGTH_LONG).show();
        Log.d(TAG, "now, redirecting to Main activity.");
        Intent i = new Intent(getApplicationContext(), MainActivity.class);
        startActivity(i);
        //cancelling location update
        stopLocationUpdate();

        unbindService(locationServiceConnection);
        finish();

        exitAnimation.dismiss();

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

    //Binding to Location service.
    private ServiceConnection locationServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            LocationService.LocationServiceBinder binder = (LocationService.LocationServiceBinder) service;
            locationService = binder.getService();

            //Providing this class instance to the location service class.
            locationService.createInterface(LocationActivityV2.this);

            isBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            isBound = false;
        }
    };

    //This function start the location getting timer.
    public void startLocationUpdateTimer() {
        Log.d(TAG, "Starting location update timer.");
        timer = new Timer();
        //initialize the timer task.
        initializeTimerTask();
        //schedule the timer, after the first 15000ms the TimerTask will run every 15000ms
        timer.schedule(timerTask, 500, 15000); //
    }

    //This function stop the timer to get location
    public void stopLocationUpdatetimerTask() {
        Log.d(TAG, "Stopping location update timer.");
        if (timer != null) {
            timer.cancel();
            timer = null;
        }
    }

    //This function initialize timer task to get user location in regular time interval.
    public void initializeTimerTask() {
        Log.d(TAG, "Initializing location update timer.");
        timerTask = new TimerTask() {
            public void run() {
                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        //checking if GPS is enabled or not.
                        //GPS may be disabled during application running.

                        boolean status = locationManagerLocationProvider.canGetLocation();

                        if (status) {
                            Log.d(TAG, "GPS is enabled. Calling start location update from timer.");

                            Log.d(TAG, "Checking if Internet is available.");
                            if (new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                Log.d(TAG, "Internet is available.");

                                Log.d(TAG, "Setting location update start status to true");
                                isLocationUpdateStarted = true;

                                Log.d(TAG, "Everything works fine, now starting location update");
                                startLocationUpdate();
                            } else {

                                Log.d(TAG, "Internet not is available.");
                                Toast.makeText(getApplicationContext(), "Network unavailable", Toast.LENGTH_LONG).show();
                                //trigerring start button function only if location update is active. this is to avoid to trigger button work ever after once the button is clicked.
                                if (isLocationUpdateStarted == true) {
                                    Log.d(TAG, "Currently, start location update is active, stopping it.");
                                    //Stopping the location button by clicking the stop button.
                                    startButton.performClick();

                                    Log.d(TAG, "Setting location update start status to false");
                                    isLocationUpdateStarted = false;
                                } else {
                                    Log.d(TAG, "Setting location update start status to false");
                                    isLocationUpdateStarted = false;
                                    Log.d(TAG, "Stopping timer task.");
                                    stopLocationUpdatetimerTask();
                                }
                            }
                        } else {
                            Log.d(TAG, "GPS is not available.");
                            Toast.makeText(getApplicationContext(), "GPS is disabled.", Toast.LENGTH_LONG).show();
                            locationManagerLocationProvider.displayGpsSettingAlert();
                            //trigerring start button function only if location update is active. this is to avoid to trigger button work ever after once the button is clicked.
                            if (isLocationUpdateStarted == true) {
                                Log.d(TAG, "Currently, start location update is active, stopping it.");
                                //Stopping the location button by clicking the stop button.
                                startButton.performClick();

                                Log.d(TAG, "Setting location update start status to false");
                                isLocationUpdateStarted = false;
                            } else {
                                Log.d(TAG, "Setting location update start status to false");
                                isLocationUpdateStarted = false;
                                Log.d(TAG, "Stopping timer task.");
                                stopLocationUpdatetimerTask();
                            }
                        }
                    }
                });
            }
        };
    }
}
