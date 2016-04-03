package com.sybus.android.driverapp.activityinterface;

import com.sybus.android.driverapp.model.Vehicle;

/**
 * Created by Ranjit Kaliraj on 12/16/2015.
 */
public interface MainActivityInterface {
    public void displayScheduleSearchAlert(Vehicle vehicle);
    public void startLocationUpdate(String schedule);
}
