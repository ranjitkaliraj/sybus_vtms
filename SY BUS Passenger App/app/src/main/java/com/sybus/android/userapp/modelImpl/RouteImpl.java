package com.sybus.android.userapp.modelImpl;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.support.annotation.Nullable;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.sybus.android.userapp.model.Route;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.presenterListener.RouteViewPresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.ui.view_traffic;
import com.sybus.android.userapp.util.URLConfig;
import com.sybus.android.userapp.util.VolleySingleton;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ranjit Kaliraj on 1/3/2016.
 */
public class RouteImpl extends Service implements Route {

    public String TAG = this.getClass().getName();

    private final IBinder serviceBinder = new ServiceBinder();

    //Initializing empty constructor
    public RouteImpl() {
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return serviceBinder;
    }

    //Getting route list from web service.
    public void getRouteList(final RouteViewPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().GET_ROUTES_LIST_URL;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<String> routes = new ArrayList<>();
                        try {
                            JSONArray arr = response.getJSONArray("routes");
                            for (int i = 0; i < arr.length(); i++) {
                                routes.add(arr.getString(i));
                            }
                            listener.onRouteListAvailable(routes);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Route list not available.");
                            listener.onRouteListNotAvailable();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting route list: " + error.getMessage());
                listener.onRouteListNotAvailable();

                //mainActivityInterface.displayScheduleSearchAlert(null);
            }
        });

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void getLatLng(final String routeName, final RouteViewPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().GET_ROUTE_CO_ORDINATES;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<LngLat> data = new ArrayList<>();
                        try {
                            JSONArray jArray = response.getJSONArray("routeWay");
                            for (int i = 0; i < jArray.length(); i++) {
                                LngLat ll = new LngLat();
                                double latitude = jArray.getJSONObject(i).getDouble("latitude");
                                double longitude = jArray.getJSONObject(i).getDouble("longitude");
                                ll.setLatitude(latitude);
                                ll.setLongitude(longitude);
                                data.add(ll);
                            }
                            listener.onRouteCoordinatesFound(data);
                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Route list not available.");
                            listener.onRouteCoordinatesNotFound();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting route list: " + error.getMessage());
                listener.onRouteCoordinatesNotFound();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("routeName", routeName);
                return params;
            }
        };

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //Getting route list from web service.
    @Override
    public void getRouteList(final SearchPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().GET_ROUTES_LIST_URL;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<String> routes = new ArrayList<>();
                        try {
                            JSONArray arr = response.getJSONArray("routes");
                            for (int i = 0; i < arr.length(); i++) {
                                routes.add(arr.getString(i));
                            }
                            listener.onRouteListFound(routes);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Route list not available.");
                            listener.onRouteListNotFound();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting route list: " + error.getMessage());
                listener.onRouteListNotFound();

                //mainActivityInterface.displayScheduleSearchAlert(null);
            }
        });

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //Getting route list from web service.
    public void getRouteListForTraffic(final view_traffic listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().GET_ROUTES_LIST_URL;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<String> routes = new ArrayList<>();
                        try {
                            JSONArray arr = response.getJSONArray("routes");
                            for (int i = 0; i < arr.length(); i++) {
                                routes.add(arr.getString(i));
                            }
                            listener.displayRouteList(routes);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Route list not available.");
                            listener.displayAlertMessage("Route list not available for traffic view.");

                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting route list: " + error.getMessage());
                //listener.onRouteListNotFound();
                listener.displayAlertMessage("Route list not available for traffic view.");

                //mainActivityInterface.displayScheduleSearchAlert(null);
            }
        });

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //Data service binder class
    public class ServiceBinder extends Binder {
        public RouteImpl getService() {
            return RouteImpl.this;
        }
    }
}
