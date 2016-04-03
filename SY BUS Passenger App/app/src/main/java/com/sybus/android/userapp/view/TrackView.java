package com.sybus.android.userapp.view;

import com.sybus.android.userapp.pojo.DetailVehicleDto;

/**
 * Created by Ranjit Kaliraj on 1/6/2016.
 */
public interface TrackView {
    public void setVehicleData(DetailVehicleDto vehicle);
    public void resetDashboard();
    public void showProgressBar(String value);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
}
