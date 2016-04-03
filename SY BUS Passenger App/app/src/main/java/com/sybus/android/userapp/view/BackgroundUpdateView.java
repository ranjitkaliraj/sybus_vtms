package com.sybus.android.userapp.view;

/**
 * Created by Ranjit Kaliraj on 2/29/2016.
 */
public interface BackgroundUpdateView {
    public void startVehicleDetailsAutoUpdate();
    public void stopVehicleDetailsAutoUpdate();
    public void suspendVehicleDetailsAutoUpdate();
    public void showProgressBar(String value);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
}
