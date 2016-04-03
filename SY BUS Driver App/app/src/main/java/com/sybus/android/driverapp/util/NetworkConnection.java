package com.sybus.android.driverapp.util;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

/**
 * Created by Ranjit Kaliraj on 12/17/2015.
 */
public class NetworkConnection {
    private Context mContext;
    public NetworkConnection(Context context){
        mContext = context;
    }

    public boolean isNetworkConnected(){
        ConnectivityManager cm = (ConnectivityManager) mContext.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if(netInfo != null){
            return true;
        }
        else{return false;}
    }
}
