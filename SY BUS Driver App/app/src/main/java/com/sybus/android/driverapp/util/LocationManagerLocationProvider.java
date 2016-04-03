package com.sybus.android.driverapp.util;

import android.Manifest;
import android.app.Service;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.provider.Settings;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.internal.view.ContextThemeWrapper;
import android.util.Log;
import android.widget.Toast;

import com.sybus.android.driverapp.R;

/**
 * Created by Ranjit Kaliraj on 12/17/2015.
 */
public class LocationManagerLocationProvider extends Service implements LocationListener {

    private final String TAG = this.getClass().getName();

    private Context context;

    private LocationManager locationManager;
    private Location location;

    private static final long MIN_DISTANCE_CHANGE_FOR_UPDATE = 0;
    private static final long MIN_TIME_FOR_UPDATE = 0;


    //Initializing constructor
    public LocationManagerLocationProvider(Context context) {
        Log.d(TAG, "Initializing GPS device for Location.");
        this.context = context;
        Log.d(TAG, "Initializing location manager.");
        locationManager = (LocationManager) context.getSystemService(LOCATION_SERVICE);
    }


    //This function get the user location and return the location object
    public Location getLocation() {
        Log.d(TAG, "Getting user location");
        try {
            Log.d(TAG, "Checking the status of GPS service.");
            if (!canGetLocation()) {
                Log.d(TAG, "GPS is not enabled.");
                Toast.makeText(context, "GPS is not enabled", Toast.LENGTH_LONG).show();
            } else {
                Log.d(TAG, "GPS Service is active so getting location.");
                if (locationManager != null) {
                    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                        // TODO: Consider calling
                        //    ActivityCompat#requestPermissions
                        // here to request the missing permissions, and then overriding
                        //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                        //                                          int[] grantResults)
                        // to handle the case where the user grants the permission. See the documentation
                        // for ActivityCompat#requestPermissions for more details.
                        //return TODO;
                    }
                    locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, MIN_TIME_FOR_UPDATE, MIN_DISTANCE_CHANGE_FOR_UPDATE, this);
                    if (locationManager != null) {
                        Log.d(TAG, "Location Manager is not null.");
                        location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
                        if (location == null) {
                            Log.d(TAG, "Location is null, reupdating.");
                            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, MIN_TIME_FOR_UPDATE, MIN_DISTANCE_CHANGE_FOR_UPDATE, this);
                        }
                    }
                }
                //location = new Location(LocationManager.GPS_PROVIDER);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return location;
    }

    //This function stops getting vehicle location.
    public void stopLocationUpdate() {
        if (locationManager != null) {
            try {
                Log.d(TAG, "Stopping location co-ordinate update service.");
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
                locationManager.removeUpdates(LocationManagerLocationProvider.this);
            } catch (Exception e) {
                Log.d(TAG, "Error while stopping location service.");
            }
        }
    }

    //Return if the location co-ordinates can be get or not.
    //no network check need to be done, since GPS must enabled, but network can be used to get location.
    public boolean canGetLocation() {
        boolean gpsStatus = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        Log.d(TAG, "Checking if the location can be get or not. status is: " + gpsStatus);
        return gpsStatus;
    }

    //This function display alert message, and give the option to enable gps if the gps is disabled.
    public void displayGpsSettingAlert() {
        Log.d(TAG, "Displaying alert message to enable GPS.");
        AlertDialog.Builder mAlertDialog = new AlertDialog.Builder(new ContextThemeWrapper(context, R.style.AppTheme));
        mAlertDialog.setTitle("GPS Service Unavailable");
        mAlertDialog.setMessage("Currently, GPS is not enabled. Do you want to enable it?");
        mAlertDialog.setPositiveButton("ENABLE", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                Intent mIntent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                context.startActivity(mIntent);
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

    @Override
    public IBinder onBind(Intent arg0) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void onLocationChanged(Location location) {
        //remove location callback:
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
            locationManager.removeUpdates(this);
        }catch(Exception e){}

        Log.d(TAG, "Getting location from onLocationChanged Event, since last location is null.");
        this.location = location;
        Log.d(TAG, "Returning location, Latitude: "+location.getLatitude()+ " , Longitude:"+location.getLongitude());
    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onProviderEnabled(String provider) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onProviderDisabled(String provider) {
        // TODO Auto-generated method stub
    }
}
