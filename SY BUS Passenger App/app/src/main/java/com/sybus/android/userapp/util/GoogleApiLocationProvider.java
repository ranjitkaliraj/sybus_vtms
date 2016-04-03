package com.sybus.android.userapp.util;

import android.Manifest;
import android.app.Activity;
import android.app.Service;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.provider.Settings;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.view.ContextThemeWrapper;
import android.util.Log;
import android.widget.Toast;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.sybus.android.userapp.R;

/**
 * Created by Ranjit Kaliraj on 12/17/2015.
 */
public class GoogleApiLocationProvider extends Service implements GoogleApiClient.ConnectionCallbacks,
        GoogleApiClient.OnConnectionFailedListener, com.google.android.gms.location.LocationListener {

    private final String TAG = this.getClass().getName();

    private Activity activity;

    // Google client to interact with Google API
    private GoogleApiClient googleApiClient;
    private LocationRequest locationRequest;
    private Location location;

    // Location updates intervals in sec
    private static int UPDATE_INTERVAL = 15000; // 10 sec
    private static int FATEST_INTERVAL = 5000; // 5 sec
    private static int DISPLACEMENT = 0; // 0 meters


    //Initializing constructor
    public GoogleApiLocationProvider(Activity activity) {
        Log.d(TAG, "Initializing Google api Location provider class.");
        this.activity = activity;
        //Checking google service available or not and then creating new googleapi object and location request object.
        if (isGoogleServiceAvailable()) {
            this.getGoogleApiClient();
            this.getLocationRequest();
            if (googleApiClient != null) {
                googleApiClient.connect();
            }
        }
    }

    //This functionr return the location object.
    public Location getLocation() {
        //Connecting googleAPi client if not connected
        if (!googleApiClient.isConnected()) {
            googleApiClient.connect();
        }
        Log.d(TAG, "Getting location object.");
        if (googleApiClient.isConnected()) {
            this.startLocationUpdate();
            if (location == null && googleApiClient.isConnected()) {
                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return null;
                }
                location = LocationServices.FusedLocationApi.getLastLocation(googleApiClient);
            }
            return location;
        } else {
            return null;
        }
    }

    //Creating new google api client object.
    protected void getGoogleApiClient() {
        Log.d(TAG, "Instantiating google api object.");
        googleApiClient = new GoogleApiClient.Builder(activity)
                .addConnectionCallbacks(this)
                .addOnConnectionFailedListener(this)
                .addApi(LocationServices.API).build();
    }

    //Creating new location request object.
    protected void getLocationRequest() {
        Log.d(TAG, "Instantiating location request object.");
        locationRequest = new LocationRequest();
        locationRequest.setInterval(UPDATE_INTERVAL);
        locationRequest.setFastestInterval(FATEST_INTERVAL);
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        locationRequest.setSmallestDisplacement(DISPLACEMENT);
    }

    //This method checks if google service is available on device or not
    public boolean isGoogleServiceAvailable() {
        int resultCode = GooglePlayServicesUtil.isGooglePlayServicesAvailable(activity.getApplicationContext());
        if (resultCode != ConnectionResult.SUCCESS) {
            if (GooglePlayServicesUtil.isUserRecoverableError(resultCode)) {
                GooglePlayServicesUtil.getErrorDialog(resultCode, activity, 100).show();
            } else {
                Toast.makeText(getApplicationContext(), "This device doesn't have Google Play Service.", Toast.LENGTH_LONG).show();
            }
            return false;
        }
        return true;
    }

    //This method start the location updates.
    public void startLocationUpdate() {
        if (googleApiClient.isConnected()) {//to avoid google api is not connected yet.
            Log.d(TAG, "updating location");
            try {
                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
                LocationServices.FusedLocationApi.requestLocationUpdates(googleApiClient, locationRequest, (com.google.android.gms.location.LocationListener) this);
            }catch(Exception e){}
        } else {
            Log.d(TAG, "Error while requesting to location update. googleAPI client is not ready.");
        }
    }

    //This method stops location update.
    public void stopLocationUpdate() {
        Log.d(TAG, "Stopping updating location");
        if (googleApiClient != null) {
            try {
                LocationServices.FusedLocationApi.removeLocationUpdates(googleApiClient, (com.google.android.gms.location.LocationListener) this);
            }catch(Exception e){}
        }
    }


    //This function display alert message, and give the option to enable gps if the gps is disabled.
    public void displayGpsSettingAlert() {
        Log.d(TAG, "Displaying alert message to enable GPS.");
        AlertDialog.Builder mAlertDialog = new AlertDialog.Builder(new ContextThemeWrapper(activity, R.style.AppTheme));
        mAlertDialog.setTitle("GPS Service Unavailable");
        mAlertDialog.setMessage("Currently, GPS is not enabled. Do you want to enable it?");
        mAlertDialog.setPositiveButton("ENABLE", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                Intent mIntent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                activity.startActivity(mIntent);
            }
        });

        mAlertDialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });

        final AlertDialog mcreateDialog = mAlertDialog.create();
        mcreateDialog.show();
    }


    public boolean canGetLocation() {
        LocationManager lm = (LocationManager) activity.getApplicationContext().getSystemService(LOCATION_SERVICE);
        boolean gpsStatus = lm.isProviderEnabled(LocationManager.GPS_PROVIDER);
        Log.d(TAG, "Checking if the location can be get or not. status is: " + gpsStatus);
        return gpsStatus;
    }


    @Override
    public void onLocationChanged(Location location) {
        this.location = location;
    }


    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onConnected(Bundle bundle) {

    }

    @Override
    public void onConnectionSuspended(int i) {

    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {

    }
}
