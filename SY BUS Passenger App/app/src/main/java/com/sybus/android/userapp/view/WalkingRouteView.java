package com.sybus.android.userapp.view;

import com.sybus.android.userapp.pojo.DetailVehicleDto;

/**
 * Created by Ranjit Kaliraj on 1/18/2016.
 */
public interface WalkingRouteView {
    public void displayWalkingRouteDetail(String stopName);
    public void resetDashboard();
    public void showProgressBar(String value);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
}
