package com.sybus.android.userapp.presenterListener;

import android.content.Context;

import com.sybus.android.userapp.pojo.DetailVehicleDto;


/**
 * Created by Ranjit Kaliraj on 2/29/2016.
 */
public interface BackgroundVehicleUpdatePresenterListener {
    public void onGetUpdateSuccess(DetailVehicleDto dto);
    public void onGetUpdateFailed();
    public void onVehicleExpired();
    public Context getContext();
}
