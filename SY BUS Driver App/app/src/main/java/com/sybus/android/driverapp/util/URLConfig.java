package com.sybus.android.driverapp.util;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 12/18/2015.
 */
public class URLConfig {
    private Context context;

    private String URL;
    public String GET_ROUTES_LIST_URL;
    public String GET_VEHICLE_LIST_URL;
    public String GET_SCHEDULE_URL;
    public String VEHICLE_LOCATION_UPDATE_URL;

    public URLConfig(Context context){
        this.context = context;
        URL = SharePreferenceManager.readFromPreference(context, "URL", "http://localhost/api", "WEB_SERVICE_API_URL");

        GET_ROUTES_LIST_URL = URL+"/api/route";
        GET_VEHICLE_LIST_URL = URL+"/api/vehicle";
        GET_SCHEDULE_URL = URL+"/api/schedule";
        VEHICLE_LOCATION_UPDATE_URL = URL+"/api/vehicle";
    }


    //THis function return the URL config object
    public URLConfig getInstance(){
        URLConfig urlConfig = new URLConfig(context);
        return urlConfig;
    }
}