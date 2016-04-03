package com.sybus.android.userapp.presenter;

import android.content.Context;

import com.sybus.android.userapp.pojo.DetailVehicleDto;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface TrackPresenter {
    public void cacheVehicleDetail(DetailVehicleDto vehicle);
    public String getCachedETA();
    public void setContext(Context c);

    public void removeBookmark();
    public void getCachedVehicle();
}
