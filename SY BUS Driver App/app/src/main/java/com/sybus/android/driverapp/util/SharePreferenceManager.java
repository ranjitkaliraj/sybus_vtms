package com.sybus.android.driverapp.util;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 */
public class SharePreferenceManager {

    private final static String TAG = SharePreferenceManager.class.getName();

    public static SharePreferenceManager getInstance(){
        SharePreferenceManager spm = new SharePreferenceManager();
        return spm;
    }

    //this method save to preference.
    //must pass applicationContext here
    public static void saveToPreference(Context context, String preference_Name, String preference_value,String PREF_FILE_NAME) {
        Log.d(TAG, "Saving data in shared preference : "+preference_Name+" : "+preference_value);
        SharedPreferences sharedPreference = context.getSharedPreferences(PREF_FILE_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreference.edit();
        editor.putString(preference_Name, String.valueOf(preference_value));
        editor.apply();
    }

    //this method read the preference.
    public static String readFromPreference(Context context, String preference_Name, String defaultValue, String PREF_FILE_NAME) {
        try {
            SharedPreferences sharedPreference = context.getSharedPreferences(PREF_FILE_NAME, Context.MODE_PRIVATE);
            String value =  sharedPreference.getString(preference_Name, defaultValue);
            Log.d(TAG, "Getting data from shared preference for : "+preference_Name +" : "+value);
            return value;
        }
        catch (NullPointerException e){
            return defaultValue;
        }
    }
}
