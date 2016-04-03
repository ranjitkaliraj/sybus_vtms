package com.sybus.android.driverapp.service;

import android.annotation.TargetApi;
import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.sybus.android.driverapp.activityinterface.MainActivityInterface;
import com.sybus.android.driverapp.model.Vehicle;
import com.sybus.android.driverapp.util.URLConfig;
import com.sybus.android.driverapp.util.VolleySingleton;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class DataService extends Service {
    private final IBinder dataServiceBinder = new DataServiceBinder();

    private final String TAG = this.getClass().getName();

    private MainActivityInterface mainActivityInterface;
    private Vehicle vehicle = new Vehicle();

    public DataService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return dataServiceBinder;
    }

    //This function set the interfaced class object to use for this class.
    public void createInterface(MainActivityInterface i) {
        mainActivityInterface = i;
    }


    //Android volly code here to download route list from web service.
    public void getRouteList() {
        String URL = new URLConfig(getApplicationContext()).getInstance().GET_ROUTES_LIST_URL;
        RequestQueue queue = VolleySingleton.getInstance(this.getApplicationContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        parseJsonResponse(response);

                        //after getting route list, now getting vehicle list.
                        getVehicleList();
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting route list: " + error.getMessage());

                mainActivityInterface.displayScheduleSearchAlert(null);
            }
        });
        //setting the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    //Android volly code here to download vehicle list from web service.
    public void getVehicleList() {
        String URL = new URLConfig(getApplicationContext()).getInstance().GET_VEHICLE_LIST_URL;

        RequestQueue queue = VolleySingleton.getInstance(this.getApplicationContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        parseJsonResponse(response);

                        //set vehicle null if route or vehicle list is not available.
                        if (response == null || response.length() == 0) {
                            vehicle = null;
                        }
                        //Calling method in mainActivity class to display schedule search alert box.
                        mainActivityInterface.displayScheduleSearchAlert(vehicle);
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting vehicle list: " + error.getMessage());

                mainActivityInterface.displayScheduleSearchAlert(null);
            }
        });
        //setting the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    //This function parse the json object that contain vehicle and route data from response.
    @TargetApi(Build.VERSION_CODES.KITKAT)
    private void parseJsonResponse(JSONObject response) {
        if (response == null || response.length() == 0) {
            return;
        } else {
            try {
                if (!response.isNull("routes")) {
                    JSONArray jArray = response.getJSONArray("routes");
                    ArrayList<String> listdata = new ArrayList<>();
                    listdata.add("-- Select Route --");
                    if (jArray != null) {
                        for (int i = jArray.length() - 1; i > -1; i--) {
                            listdata.add(jArray.get(i).toString());
                        }
                    }
                    vehicle.setRoutes(listdata);
                }
                if (!response.isNull("vehicles")) {
                    JSONArray jArray = response.getJSONArray("vehicles");
                    ArrayList<String> listdata = new ArrayList<>();
                    listdata.add("-- Select Vehicle --");
                    if (jArray != null) {
                        for (int i = jArray.length() - 1; i > -1; i--) {
                            listdata.add(jArray.get(i).toString());
                        }
                    }
                    vehicle.setVehicles(listdata);

                    Log.d(TAG, "JSON object in form of vehicle array: " + listdata.toString() + "Single:" + listdata.get(0));
                    //vehicle.setVehicles((ArrayList<String>) response.get("vehicles"));
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

    //this function find schedule for required vehicle and route.
    public void findSchedule(final String vehicle, final String route) {
        Log.d(TAG, "To find schedule for : " + vehicle + ", " + route);

        String URL = new URLConfig(getApplicationContext()).getInstance().GET_SCHEDULE_URL;

        RequestQueue queue = VolleySingleton.getInstance(this.getApplicationContext()).
                getRequestQueue();
        StringRequest request = new StringRequest(Request.Method.GET,
                URL,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        Log.d(TAG, "Apple : "+response+" : Apple");
                        if(response.isEmpty()) {
                            mainActivityInterface.startLocationUpdate(null);
                        }
                        else{
                            mainActivityInterface.startLocationUpdate(response);
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while loading schedule: " + error.getMessage());
                mainActivityInterface.startLocationUpdate(null);
            }
        }) {
            @Override
            //setting headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("Vehicle-Name", vehicle);
                params.put("Route-Name", route);
                return params;
            }
        };
        //setting the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(30000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    //Data service binder class
    public class DataServiceBinder extends Binder {
        public DataService getService() {
            return DataService.this;
        }
    }

}
