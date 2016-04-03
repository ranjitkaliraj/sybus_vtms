package com.sybus.android.userapp.util;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 * This method manages various application cache data such as application SettingActivity data, user cache LoginView data etc.
 */
public class UserDataCacheManager {
    //Shared preference file to store userlogin data for cache
    public static final String userDataPref = "USER_ACCOUNT_DATA_FILE";

    //this function store the user data to the shared preference file
    public static void storeUserDataCache(Context context, String username, String email, String auth_key){
        SharePreferenceManager.saveToPreference(context, "username",username, userDataPref);
        SharePreferenceManager.saveToPreference(context, "email",email, userDataPref);
        SharePreferenceManager.saveToPreference(context, "auth-key",auth_key, userDataPref);
    }

    //this function clear the userdata from the shared preference file
    public static void emptyUserDataCache(Context context){
        SharePreferenceManager.saveToPreference(context, "username","", userDataPref);
        SharePreferenceManager.saveToPreference(context, "email","", userDataPref);
        SharePreferenceManager.saveToPreference(context, "auth-key","", userDataPref);
    }

    //this function get the userData information in the form of array stored in shared perference
    public static String[] getUserDataFromCache(Context context){
        String name = SharePreferenceManager.readFromPreference(context, "username","", userDataPref);
        String email = SharePreferenceManager.readFromPreference(context, "email","", userDataPref);
        String auth_key = SharePreferenceManager.readFromPreference(context, "auth-key","", userDataPref);
        String[] data = new String[]{name, email, auth_key};
        return data;
    }

    //this function store the user data to the shared preference file
    public static void storeUserEmailCache(Context context, String email){
        SharePreferenceManager.saveToPreference(context, "email_for_activation",email, userDataPref);
    }

    //this function get the userData information in the form of array stored in shared perference
    public static String getUserEmailFromCache(Context context){
        String email = SharePreferenceManager.readFromPreference(context, "email_for_activation","", userDataPref);
        return email;
    }
    //this function store the user data to the shared preference file
    public static void storeUserEmailForResetPassword(Context context, String email){
        SharePreferenceManager.saveToPreference(context, "email_for_reset_password",email, userDataPref);
    }

    //this function get the userData information in the form of array stored in shared perference
    public static String getUserEmailForResetPassword(Context context){
        String email = SharePreferenceManager.readFromPreference(context, "email_for_reset_password","", userDataPref);
        return email;
    }


    //this function store the user data to the shared preference file
    public static void storeUserLoginInfoForFirstLogin(Context context, String username, String password){
        SharePreferenceManager.saveToPreference(context, "username_first_login",username, userDataPref);
        SharePreferenceManager.saveToPreference(context, "password_first_login",password, userDataPref);
    }

    //this function store the user data to the shared preference file
    public static void emptyUserLoginInfoForFirstLogin(Context context){
        SharePreferenceManager.saveToPreference(context, "username_first_login","", userDataPref);
        SharePreferenceManager.saveToPreference(context, "password_first_login","", userDataPref);
    }

    //this function get the userData information in the form of array stored in shared perference
    public static String[] getUserLoginInfoForFirstLogin(Context context){
        String username = SharePreferenceManager.readFromPreference(context, "username_first_login","", userDataPref);
        String password = SharePreferenceManager.readFromPreference(context, "password_first_login","", userDataPref);
        String[] data = new String[]{username,password};
        return data;
    }
}
