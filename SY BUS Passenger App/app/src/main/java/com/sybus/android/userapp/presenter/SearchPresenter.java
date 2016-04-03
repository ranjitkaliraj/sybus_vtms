package com.sybus.android.userapp.presenter;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface SearchPresenter {
    public void setContext(Context context);
    public void findVehicle(String destination, Double lng, Double lat, int range);
    public void findVehicleForRoute(String route);
    public void findVehicleForBusStop(String route);
    public void getVehicleDetailForDestination(long vehicleID, String userStop, String destStop, String destination);

    public void getRouteNames();
    public void getBusstopNames();
}
