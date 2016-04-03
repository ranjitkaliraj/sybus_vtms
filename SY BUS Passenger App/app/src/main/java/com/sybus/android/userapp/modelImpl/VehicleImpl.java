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
import com.sybus.android.userapp.model.Vehicle;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.pojo.SearchVehicleDto;
import com.sybus.android.userapp.presenterListener.BackgroundVehicleUpdatePresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.presenterListener.TrackPresenterListener;
import com.sybus.android.userapp.util.URLConfig;
import com.sybus.android.userapp.util.VehicleDataCacheManager;
import com.sybus.android.userapp.util.VolleySingleton;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public class VehicleImpl extends Service implements Vehicle {

    public String TAG = this.getClass().getName();

    private final IBinder serviceBinder = new ServiceBinder();
    private SearchPresenterListener searchListener;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return serviceBinder;
    }

    //This function finds vehicles for given destination.
    public void searchAvailableVehicles(final String destination, final Double lng, final Double lat, final int range, final SearchPresenterListener listener) {
        Log.d(TAG, "Getting vehicles for : " + destination);

        //final Double lat = 27.712387;
        //final Double lng = 85.320688;
        String URL = new URLConfig(listener.getContext()).getInstance().SEARCH_VEHICLE_DESTINATION;

        //First removing any previous pending operation of suggestion to remove much traffic.
        VolleySingleton.getInstance(listener.getContext()).cancelPendingRequest();

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            JSONArray jArray = response.getJSONArray("result");
                            int status = response.getInt("statusError");
                            if (jArray.length() == 0) {
                                if (status == 1) {
                                    listener.onSearchResultNotFound("Routes are not available in given range. Please, adjust range in Settings.");
                                } else if (status == 2) {
                                    listener.onSearchResultNotFound("Bus stations are not available in given range. Please, adjust range in Settings.");
                                } else if (status == 3) {
                                    listener.onSearchResultNotFound("Vehicles are not available in given range. Please, adjust range in Settings.");
                                } else if (status == 4) {
                                    listener.onSearchResultNotFound("Cannot find the vehicles at the moment. Please, try again later.");
                                }
                            } else {
                                Log.d(TAG, "No error");
                                ArrayList<SearchVehicleDto> data = new ArrayList<>();
                                for (int i = 0; i < jArray.length(); i++) {
                                    String destinationBusstop = jArray.getJSONObject(i).get("destinationBusStop").toString();
                                    String routeName = jArray.getJSONObject(i).get("routeName").toString();
                                    String userBusstop = jArray.getJSONObject(i).get("userBusStop").toString();
                                    JSONArray vehicles = jArray.getJSONObject(i).getJSONArray("vehicles");
                                    for (int j = 0; j < vehicles.length(); j++) {
                                        SearchVehicleDto vehicle = new SearchVehicleDto();
                                        vehicle.setVehicleID(vehicles.getJSONObject(j).getLong("sessionId"));
                                        vehicle.setVehicleName(vehicles.getJSONObject(j).get("vehicleName").toString());
                                        vehicle.setCurrentLocation(vehicles.getJSONObject(j).get("currentLocation").toString());
                                        vehicle.setNextStop(vehicles.getJSONObject(j).get("nextStop").toString());

                                        /*if(vehicles.getJSONObject(j).get("eta").toString().equals(null) || vehicles.getJSONObject(j).get("eta").toString().equals("")){
                                            vehicle.setETA("N/A");
                                        }else {*/
                                        vehicle.setETA(vehicles.getJSONObject(j).get("eta").toString() + " mins");
                                        /*}*/
                                        vehicle.setDestinationStop(destinationBusstop);
                                        vehicle.setRouteName(routeName);
                                        vehicle.setUserNearStop(userBusstop);
                                        data.add(vehicle);
                                    }
                                }

                                //now returning the data.
                                //Log.d(TAG, data.get(0).getVehicleName()+"");
                                //Log.d(TAG, data.get(1).getVehicleName()+"");
                                listener.onSearchResultFound(data);
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onSearchResultNotFound("Cannot find the vehicles at the moment. Try again later.");
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                error.printStackTrace();
                Log.d(TAG, "Error while getting vehicles: " + error.getMessage());
                listener.onSearchResultNotFound("Cannot find the vehicles at the moment. Please, try again later.");
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("destination", destination);
                params.put("longitude", lng + "");
                params.put("latitude", lat + "");
                params.put("range", range + "");
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(30000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);

    }

    @Override
    public void getVehicleDetail(final long vehicleID, final String userStop, final String destStop, final String destination, final SearchPresenterListener listener) {
        Log.d(TAG, "Getting vehicles detail.");

        String URL = new URLConfig(listener.getContext()).getInstance().GET_VEHICLE_DETAIL;

        //First removing any previous pending operation of suggestion to remove much traffic.
        //VolleySingleton.getInstance(listener.getContext()).cancelPendingRequest();

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        if (response == null || response.isNull("routeWay")) {
                            Log.d(TAG, "Response is null.");
                            listener.onVehicleDetailNotFound();
                        } else {
                            try {
                                DetailVehicleDto dto = new DetailVehicleDto();

                                LngLat dl = new LngLat();
                                dl.setLatitude(response.getJSONObject("destination").getDouble("latitude"));
                                dl.setLongitude(response.getJSONObject("destination").getDouble("longitude"));
                                dto.setDestinationLocation(dl);

                                LngLat dStop = new LngLat();
                                dStop.setLatitude(response.getJSONObject("destinationStop").getDouble("latitude"));
                                dStop.setLongitude(response.getJSONObject("destinationStop").getDouble("longitude"));
                                dto.setDestStopLocation(dStop);

                                Log.d(TAG, dto.getDestStopLocation().getLatitude() + ": destination stop");

                                LngLat vehicleLocation = new LngLat();
                                vehicleLocation.setLatitude(response.getJSONObject("vehicle").getDouble("latitude"));
                                vehicleLocation.setLongitude(response.getJSONObject("vehicle").getDouble("longitude"));
                                dto.setVehicleLocation(vehicleLocation);

                                Log.d(TAG, dto.getVehicleLocation().getLatitude()+": vehicle location");

                                LngLat userNearStopLocation = new LngLat();
                                userNearStopLocation.setLatitude(response.getJSONObject("userStop").getDouble("latitude"));
                                userNearStopLocation.setLongitude(response.getJSONObject("userStop").getDouble("longitude"));
                                dto.setUserStopLocation(userNearStopLocation);


                                Log.d(TAG, dto.getUserStopLocation().getLatitude() + ": User stop location");

                                dto.setFare(response.getInt("fare"));

                                ArrayList<LngLat> way = new ArrayList<>();
                                JSONArray arr = response.getJSONArray("routeWay");

                                for (int i = 0; i < arr.length(); i++) {
                                    LngLat lnglat = new LngLat();
                                    lnglat.setLatitude(arr.getJSONObject(i).getDouble("latitude"));
                                    lnglat.setLongitude(arr.getJSONObject(i).getDouble("longitude"));
                                    way.add(lnglat);
                                }
                                dto.setWay(way);

                                Log.d(TAG, "Now, returning data.");
                                listener.onVehicleDetailFound(dto);


                            } catch (JSONException e) {
                                e.printStackTrace();
                                listener.onVehicleDetailNotFound();
                            }
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                error.printStackTrace();
                Log.d(TAG, "Error while getting vehicles detail: " + error.getMessage());
                listener.onVehicleDetailNotFound();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("vehicle_sessionID", vehicleID+"");
                params.put("userStop", userStop);
                params.put("destStop", destStop);
                params.put("destination", destination);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(30000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }






    @Override
    public void getVehicleUpdate(final long vehicleID, final String userStop,final BackgroundVehicleUpdatePresenterListener listener) {
        Log.d(TAG, "Getting vehicles update.");

        String URL = new URLConfig(listener.getContext()).getInstance().UPDATE_VEHICLE_LOCATION;

        //First removing any previous pending operation of suggestion to remove much traffic.
        //VolleySingleton.getInstance(listener.getContext()).cancelPendingRequest();

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        if (response == null) {
                            Log.d(TAG, "Response is null.");
                            listener.onGetUpdateFailed();
                        } else {
                            try {
                                //getting the original cached data and updating its content partially
                                //i.e. only needed data is updated, rest remains the same.

                                DetailVehicleDto dto = VehicleDataCacheManager.getVehicle(listener.getContext());

                                boolean vehicleExpiredStatus = response.getBoolean("isVehicleExpired");
                                if(vehicleExpiredStatus==true){
                                    dto.setIsVehicleExpired(true);
                                }
                                else{
                                    dto.setIsVehicleExpired(false);
                                    LngLat dl = new LngLat();
                                    dl.setLatitude(response.getJSONObject("latlng").getDouble("latitude"));
                                    dl.setLongitude(response.getJSONObject("latlng").getDouble("longitude"));
                                    dto.setVehicleLocation(dl);

                                    dto.getVehicle().setCurrentLocation(response.getString("currentLocation"));
                                    dto.getVehicle().setVehicleID(response.getLong("sessionId"));
                                    dto.getVehicle().setETA(response.get("eta").toString() + " mins");
                                }

                                Log.d(TAG, "Now, returning data.");
                                listener.onGetUpdateSuccess(dto);

                            } catch (JSONException e) {
                                e.printStackTrace();
                                listener.onGetUpdateFailed();
                            }
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                error.printStackTrace();
                Log.d(TAG, "Error while getting vehicles update: " + error.getMessage());
                listener.onGetUpdateFailed();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("vehicle_sessionID", vehicleID+"");
                params.put("userStop", userStop);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }












    @Override
    public void searchVehicleForRoute(final String routeName, final SearchPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().SEARCH_VEHICLE_ROUTE;
        final RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        final JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<SearchVehicleDto> result = new ArrayList<>();
                        try {

                            JSONArray arr = response.getJSONArray("vehicles");
                            for (int i = 0; i < arr.length(); i++) {
                                SearchVehicleDto dto = new SearchVehicleDto();
                                dto.setRouteName(routeName);
                                dto.setCurrentLocation(arr.getJSONObject(i).getString("currentLocation"));
                                dto.setNextStop(arr.getJSONObject(i).getString("nextStop"));
                                dto.setVehicleID(arr.getJSONObject(i).getLong("sessionId"));
                                dto.setVehicleName(arr.getJSONObject(i).getString("vehicleName"));
                                dto.setETA(arr.getJSONObject(i).getString("eta")+" mins");
                                dto.setUserNearStop("N/A");
                                dto.setDestinationStop("N/A");
                                result.add(dto);
                            }
                            listener.onRouteSearchVehicleResultFound(result);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Error while downloading vehicle result.");
                            listener.onRouteSearchVehicleResultNotFound();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting vehicle result.: " + error.getMessage());
                listener.onRouteSearchVehicleResultNotFound();

                //mainActivityInterface.displayScheduleSearchAlert(null);
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


    @Override
    public void searchVehicleForStop(final String stopName, final SearchPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().SEARCH_VEHICLE_STOP;
        final RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        final JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        try {
                            JSONArray jArray = response.getJSONArray("result");
                            Log.d(TAG, "No error");
                            ArrayList<SearchVehicleDto> data = new ArrayList<>();
                            for (int i = 0; i < jArray.length(); i++) {
                               // String destinationBusstop = jArray.getJSONObject(i).get("destinationBusStop").toString();
                                String routeName = jArray.getJSONObject(i).get("routeName").toString();
                               // String userBusstop = jArray.getJSONObject(i).get("userBusStop").toString();
                                JSONArray vehicles = jArray.getJSONObject(i).getJSONArray("vehicles");
                                for (int j = 0; j < vehicles.length(); j++) {
                                    SearchVehicleDto vehicle = new SearchVehicleDto();
                                    vehicle.setVehicleID(vehicles.getJSONObject(j).getLong("sessionId"));
                                    vehicle.setVehicleName(vehicles.getJSONObject(j).get("vehicleName").toString());
                                    vehicle.setCurrentLocation(vehicles.getJSONObject(j).get("currentLocation").toString());
                                    vehicle.setNextStop(vehicles.getJSONObject(j).get("nextStop").toString());
                                    vehicle.setETA(vehicles.getJSONObject(j).get("eta").toString() + " mins");

                                    vehicle.setDestinationStop("N/A");
                                    vehicle.setRouteName(routeName);
                                    vehicle.setUserNearStop("N/A");
                                    data.add(vehicle);
                                }
                            }
                            //returning the data.
                            listener.onStopSearchVehicleResultFound(data);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Stops list not available.");
                            listener.onStopSearchVehicleResultNotFound();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting stops list: " + error.getMessage());
                listener.onStopSearchVehicleResultNotFound();

                //mainActivityInterface.displayScheduleSearchAlert(null);
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("stopName", stopName);
                return params;
            }
        };

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //This method cache vehicle detail.
    @Override
    public void cacheVehicle(DetailVehicleDto vehicle, TrackPresenterListener listener) {
        VehicleDataCacheManager.cacheVehicle(listener.getContext(), vehicle);
        listener.onCacheSuccess();
    }

    @Override
    public void removeVehicleCache(TrackPresenterListener listener) {
        VehicleDataCacheManager.clearVehicle(listener.getContext());
        listener.onCacheRemoved();
    }

    @Override
    public void getVehicleCache(TrackPresenterListener listener) {
        listener.onCacheRetrieved(VehicleDataCacheManager.getVehicle(listener.getContext()));
    }

    @Override
    public String getCachedETA(TrackPresenterListener listener){
        return VehicleDataCacheManager.getVehicle(listener.getContext()).getVehicle().getETA();
    }

//This function sort the vehicle according to eta.
    /*private ArrayList<SearchVehicleDto> sortData(ArrayList<SearchVehicleDto> data){
        ArrayList<SearchVehicleDto> newArray = new ArrayList<>();
        for (SearchVehicleDto dto : data){
            if(newArray.size()==0){
                newArray.add(dto);
            }else{
                for(SearchVehicleDto dto1 : newArray){
                    if(Double.parseDouble(dto.getETA()) > Double.parseDouble(dto1.getETA())){

                    }
                }
            }

        }
    }*/


//Data service binder class
public class ServiceBinder extends Binder {
    public VehicleImpl getService() {
        return VehicleImpl.this;
    }
}
}
