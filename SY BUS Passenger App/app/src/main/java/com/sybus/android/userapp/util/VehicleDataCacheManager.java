package com.sybus.android.userapp.util;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import com.google.gson.Gson;
import com.sybus.android.userapp.pojo.DetailVehicleDto;

/**
 * Created by Ranjit Kaliraj on 1/6/2016.
 */
public class VehicleDataCacheManager {
    //Shared preference file to store userlogin data for cache
    public static final String vehicleDetailPref = "VEHICLE_DETAIL_FILE";

    //this function store the user data to the shared preference file
    public static void cacheVehicle(Context context, DetailVehicleDto vehicle){
        SharedPreferences sharedPreference = context.getSharedPreferences(vehicleDetailPref, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreference.edit();
        Gson gson = new Gson();
        String json = gson.toJson(vehicle);
        editor.putString("vehicle", json);
        editor.apply();
    }

    //this function check if vehicle is cached or not.
    public static boolean isVehicleCached(Context context){
        SharedPreferences sharedPreference = context.getSharedPreferences(vehicleDetailPref, Context.MODE_PRIVATE);
        String data = sharedPreference.getString("vehicle", "");
        if(data.equals("")){
            return false;
        }
        else {
            return true;
        }
    }

    //this function clear the userdata from the shared preference file
    public static void clearVehicle(Context context){
        SharedPreferences sharedPreference = context.getSharedPreferences(vehicleDetailPref, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreference.edit();
        editor.putString("vehicle", "");
        editor.apply();
    }

    //this function get the userData information in the form of array stored in shared perference
    public static DetailVehicleDto getVehicle(Context context){
        SharedPreferences sharedPreference = context.getSharedPreferences(vehicleDetailPref, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreference.getString("vehicle", "");
        DetailVehicleDto obj = gson.fromJson(json, DetailVehicleDto.class);
        try {
            Log.d("VEHICLE CACHE", obj.getVehicle().getVehicleName());
        }catch (Exception e){}
        return obj;
    }
}
