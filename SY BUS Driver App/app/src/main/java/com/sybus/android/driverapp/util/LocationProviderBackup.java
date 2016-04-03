package com.sybus.android.driverapp.util;

import android.app.Service;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.provider.Settings;
import android.support.v7.app.AlertDialog;
import android.support.v7.internal.view.ContextThemeWrapper;
import android.util.Log;
import android.widget.Toast;

import com.sybus.android.driverapp.R;

/**
 * Created by Ranjit Kaliraj on 12/17/2015.
 */
public class LocationProviderBackup extends Service implements LocationListener {

    private final String TAG = this.getClass().getName() + "::";

    private Context mContext;
    private boolean isGpsEnabled = false;
    private boolean canGetLocation = false;

    private Location mLocation;
    private double mLatitude;
    private double mLongitude;

    private static final long MIN_DISTANCE_CHANGE_FOR_UPDATE = 0;
    private static final long MIN_TIME_FOR_UPDATE = 15000;

    private LocationManager mLocationManager;

    //Initializing constructor
    public LocationProviderBackup(Context mContext) {
        Log.d(TAG, "Initializing GPS device for Location.");
        this.mContext = mContext;
    }


    //This function get the user location and return the location object
    public Location getLocation() {
        Log.d(TAG, "Getting user location");
        try {
            Log.d(TAG, "Initializing location manager.");
            mLocationManager = (LocationManager) mContext.getSystemService(LOCATION_SERVICE);

            Log.d(TAG, "Checking the status of GPS service.");
            isGpsEnabled = mLocationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);

            if (!isGpsEnabled) {
                Log.d(TAG, "GPS is not enabled.");
                canGetLocation = false;
                Toast.makeText(mContext, "GPS is not enabled", Toast.LENGTH_LONG).show();
            } else {
                Log.d(TAG, "GPS Service is active so setting 'can-get-location' to true.");
                this.canGetLocation = true;
                if (mLocation == null) {
                    mLocationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, MIN_TIME_FOR_UPDATE, MIN_DISTANCE_CHANGE_FOR_UPDATE, this);

                    if (mLocationManager != null) {
                        mLocation = mLocationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
                        if (mLocation != null) {
                            Log.d(TAG, "Getting and setting latitude and longitude from GPS provider.");
                            mLatitude = mLocation.getLatitude();
                            mLongitude = mLocation.getLongitude();
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mLocation;
    }

    //This function stops getting vehicle location.
    public void stopLocationUpdate() {
        if (mLocationManager != null) {
            try {
                Log.d(TAG, "Stopping location co-ordinate update service.");
                mLocationManager.removeUpdates(LocationProviderBackup.this);
            } catch (Exception e) {
                Log.d(TAG, "Error while stopping location service.");
            }
        }
    }



    //Get latitude value of user current location.
    public double getLatitude() {
        if (mLocation != null) {
            Log.d(TAG, "Getting latitude.");
            mLatitude = mLocation.getLatitude();
        }
        return mLatitude;
    }

    //Return longitude value of user current location.
    public double getLongitude() {
        if (mLocation != null) {
            Log.d(TAG, "Getting longitude.");
            mLongitude = mLocation.getLongitude();
        }
        return mLongitude;
    }

    //Return if the location co-ordinates can be get or not.
    public boolean canGetLocation() {
        boolean gpsStatus = mLocationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        Log.d(TAG, "Checking if the location can be get or not. status is: " + gpsStatus);
        return gpsStatus;
    }

    //This function display alert message, and give the option to enable gps if the gps is disabled.
    public void displayGpsSettingAlert() {
        Log.d(TAG, "Displaying alert message to enable GPS.");
        AlertDialog.Builder mAlertDialog = new AlertDialog.Builder(new ContextThemeWrapper(mContext, R.style.AppTheme));
        mAlertDialog.setTitle("GPS Service Unavailable");
        mAlertDialog.setMessage("Currently, GPS is not enabled. Do you want to enable it?");
        mAlertDialog.setPositiveButton("ENABLE", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                Intent mIntent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                mContext.startActivity(mIntent);
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

    public void onLocationChanged(Location location) {
        mLongitude = location.getLongitude();
        mLatitude = location.getLatitude();
    }

    public void onProviderDisabled(String provider) {
        // TODO Auto-generated method stub
    }

    public void onProviderEnabled(String provider) {
        // TODO Auto-generated method stub
    }

    public void onStatusChanged(String provider, int status, Bundle extras) {
        // TODO Auto-generated method stub
    }

}
