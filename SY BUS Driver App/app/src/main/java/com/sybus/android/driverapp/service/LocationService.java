package com.sybus.android.driverapp.service;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.sybus.android.driverapp.activityinterface.LocationActivityInterface;
import com.sybus.android.driverapp.util.URLConfig;
import com.sybus.android.driverapp.util.VolleySingleton;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class LocationService extends Service {
    private final IBinder locationServiceBinder = new LocationServiceBinder();

    private LocationActivityInterface locationActivityInterface;

    private final String TAG = this.getClass().getName();

    public LocationService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return locationServiceBinder;
    }

    //This function set the interfaced class object to use for this class.
    public void createInterface(LocationActivityInterface i) {
        locationActivityInterface = i;
    }

    //Android volly code here to update vehicle location to the server.
    public void updateLocation(Double latitude, Double longitude, String vehicleName, String routeName) {
        JSONObject object = new JSONObject();
        try {
            object.put("vehicleName", vehicleName);
            object.put("routeName", routeName);
            object.put("longitude", longitude);
            object.put("latitude", latitude);

        } catch (JSONException e) {
            e.printStackTrace();
        }

        String URL = new URLConfig(getApplicationContext()).getInstance().VEHICLE_LOCATION_UPDATE_URL;

        RequestQueue queue = VolleySingleton.getInstance(this.getApplicationContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, object,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        //status = true;
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while updating location: " + error.getMessage());
                //status = false;
                locationActivityInterface.stopLocationUpdateByServerError();
            }
        });
        queue.add(request);
        request.setRetryPolicy(new DefaultRetryPolicy(15000, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
    }

    //This function stops and delete vehicle update session from the server
    public void stopLocationUpdate(final String vehicleName, final String routeName) {
        Log.d(TAG, "Info:" + vehicleName + " , " + routeName);

        String URL = new URLConfig(getApplicationContext()).getInstance().VEHICLE_LOCATION_UPDATE_URL;

        Log.d(TAG, "Stopping location update on server.");
        RequestQueue queue = VolleySingleton.getInstance(this.getApplicationContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.DELETE,
                URL,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, "Successful"+response.toString());
                        boolean status = false;
                        try {
                            status = response.getBoolean("vehicleUpdateStopStatus");
                            Log.d(TAG, "Vehicle Location Update cancel status: "+status);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        if(status){
                            Log.d(TAG, "Update:  Vehicle Location Update cancel status: "+status);
                            locationActivityInterface.redirectToMainActivity();
                        }
                        else{
                            Log.d(TAG, "No previous vehicle location record found so no need to delete it.");
                            locationActivityInterface.redirectToMainActivity();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while cancelling location update: " + error.getMessage());
                locationActivityInterface.stopLocationUpdateByServerError();
            }
        }) {
            @Override
            //setting headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("Vehicle-Name", vehicleName);
                params.put("Route-Name", routeName);
                return params;
            }
        };
        queue.add(request);
        request.setRetryPolicy(new DefaultRetryPolicy(10000, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
    }

    //Data service binder class
    public class LocationServiceBinder extends Binder {
        public LocationService getService() {
            return LocationService.this;
        }
    }
}
