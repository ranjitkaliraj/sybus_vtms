package com.sybus.android.userapp.util;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 12/18/2015.
 */
public class URLConfig {
    private Context context;

    private String URL;
    public String GET_DESTINATION_SUGGESTION;
    public String VALIDATE_DESTINATION;
    public String GET_ROUTES_LIST_URL;
    public String GET_STOP_LIST_URL;
    public String GET_ROUTE_CO_ORDINATES;
    public String GET_TRAFFIC;
    public String GET_SCHEDULE;
    public String USER;
    public String USER_LOGIN;
    public String USER_LOGOUT;
    public String CHECK_ACCOUNT_ACTIVATION;
    public String ACTIVATE_ACCOUNT;
    public String RESEND_ACTIVATION_CODE;
    public String FORGET_PASSWORD;
    public String VALIDATE_RESET_CODE;
    public String VALIDATE_EMAIL;
    public String SUBMIT_QUERY;
    public String VEHICLE;
    public String SEARCH_VEHICLE_DESTINATION;
    public String SEARCH_VEHICLE_ROUTE;
    public String SEARCH_VEHICLE_STOP;
    public String GET_VEHICLE_DETAIL;
    public String UPDATE_VEHICLE_LOCATION;

    public URLConfig(Context context){
        this.context = context;
        URL = SharePreferenceManager.readFromPreference(context, "URL", "http://192.168.0.105:8181/SYBusAPIApp/api", "WEB_SERVICE_API_URL");

        GET_DESTINATION_SUGGESTION = URL+"/destination/suggestion";
        VALIDATE_DESTINATION = URL+"/destination/validate";
        GET_ROUTES_LIST_URL = URL+"/route";
        GET_STOP_LIST_URL = URL+"/stop/list";
        GET_ROUTE_CO_ORDINATES = URL+"/route/latlng";
        GET_TRAFFIC = URL+"/route/traffic";
        GET_SCHEDULE = URL+"/schedule";
        USER = URL+"/user";
        USER_LOGIN = URL+"/user/login";
        USER_LOGOUT = URL+"/user/logout";
        CHECK_ACCOUNT_ACTIVATION = URL+"/user/check_account_activation";
        ACTIVATE_ACCOUNT = URL+"/user/activate_account";
        RESEND_ACTIVATION_CODE = URL+"/user/send_activation_code";
        FORGET_PASSWORD = URL+"/user/forget_password";
        VALIDATE_RESET_CODE = URL+"/user/validate_reset_code";
        VALIDATE_EMAIL = URL+"/user/validate_email";
        SUBMIT_QUERY = URL+"/user/query";
        VEHICLE = URL+"/vehicle";
        SEARCH_VEHICLE_DESTINATION = URL+"/vehicle/search";
        SEARCH_VEHICLE_ROUTE = URL+"/vehicle/search/route";
        SEARCH_VEHICLE_STOP = URL+"/vehicle/search/stop";
        GET_VEHICLE_DETAIL = URL+"/vehicle/detail";
        UPDATE_VEHICLE_LOCATION = URL+"/vehicle/location_update";
    }


    //THis function return the URL config object
    public URLConfig getInstance(){
        URLConfig urlConfig = new URLConfig(context);
        return urlConfig;
    }
}