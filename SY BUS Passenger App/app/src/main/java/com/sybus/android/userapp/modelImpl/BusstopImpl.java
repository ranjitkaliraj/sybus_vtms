package com.sybus.android.userapp.modelImpl;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.support.annotation.Nullable;
import android.util.Log;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.sybus.android.userapp.model.Busstop;
import com.sybus.android.userapp.model.Destination;
import com.sybus.android.userapp.presenterListener.DestinationPresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.util.URLConfig;
import com.sybus.android.userapp.util.VolleySingleton;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public class BusstopImpl extends Service implements Busstop {

    public String TAG = this.getClass().getName();

    private final IBinder serviceBinder = new ServiceBinder();
    private SearchPresenterListener listener;
    //Initializing empty constructor
    public BusstopImpl(){
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return serviceBinder;
    }

    @Override
    public void getStopList(final SearchPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().GET_STOP_LIST_URL;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        // parseJsonResponse(response);
                        ArrayList<String> stops = new ArrayList<>();
                        try {
                            JSONArray arr = response.getJSONArray("stops");
                            for(int i=0; i<arr.length(); i++){
                                stops.add(arr.getString(i));
                            }
                            listener.onRouteListFound(stops);

                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.d(TAG, "Stops list not available.");
                            listener.onRouteListNotFound();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting stops list: " + error.getMessage());
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


    //Data service binder class
    public class ServiceBinder extends Binder {
        public BusstopImpl getService() {
            return BusstopImpl.this;
        }
    }
}
