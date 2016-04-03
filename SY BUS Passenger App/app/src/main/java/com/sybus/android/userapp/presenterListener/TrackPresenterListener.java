package com.sybus.android.userapp.presenterListener;

import android.content.Context;

import com.sybus.android.userapp.pojo.DetailVehicleDto;

/**
 * Created by Ranjit Kaliraj on 1/6/2016.
 */
public interface TrackPresenterListener {
    public void onCacheSuccess();
    public Context getContext();
    public void onCacheRemoved();
    public void onCacheRetrieved(DetailVehicleDto vehicle);
}
