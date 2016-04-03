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
import com.android.volley.toolbox.StringRequest;
import com.sybus.android.userapp.model.Destination;
import com.sybus.android.userapp.presenterListener.DestinationPresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.util.BooleanRequest;
import com.sybus.android.userapp.util.URLConfig;
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
public class DestinationImpl extends Service implements Destination {

    public String TAG = this.getClass().getName();

    private final IBinder serviceBinder = new ServiceBinder();

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void validateDestination(final String destination, final DestinationPresenterListener listener) {
        Log.d(TAG, "Validating destination : " + destination);

        String URL = new URLConfig(listener.getContext()).getInstance().VALIDATE_DESTINATION;

        //First removing any previous pending operation of suggestion to remove much traffic.
        VolleySingleton.getInstance(listener.getContext()).cancelPendingRequest();

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        BooleanRequest request = new BooleanRequest(Request.Method.POST,
                URL, null,
                new Response.Listener<Boolean>() {
                    @Override
                    public void onResponse(Boolean response) {
                        Log.d(TAG, "Validation status : "+response);
                        if(response == false) {
                            listener.onValidationFailed();
                        }
                        else{
                            Log.d(TAG, "Validation successful.");
                            listener.onValidationSuccess();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while validating destination: " + error.getMessage());
                listener.onValidationFailed();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
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
    public void getDestinationSuggestion(final String criteria, final DestinationPresenterListener listener) {
        Log.d(TAG, "Getting suggestion for criteria : " + criteria);

        String URL = new URLConfig(listener.getContext()).getInstance().GET_DESTINATION_SUGGESTION;

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
                            JSONArray jArray = response.getJSONArray("destinations");
                            ArrayList<String> listdata = new ArrayList<>();
                            if (jArray != null) {
                                for (int i = jArray.length() - 1; i > -1; i--) {
                                    listdata.add(jArray.get(i).toString());
                                }
                                //returning the data.
                                listener.returnSuggestionList(listdata);
                            } else {
                                listener.onSuggestionNotFound();

                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onErrorOccured();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while getting suggestions: " + error.getMessage());
                listener.onErrorOccured();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("value", criteria);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(30000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //Data service binder class
    public class ServiceBinder extends Binder {
        public DestinationImpl getService() {
            return DestinationImpl.this;
        }
    }
}
