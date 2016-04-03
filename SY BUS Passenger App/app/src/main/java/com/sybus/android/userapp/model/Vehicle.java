package com.sybus.android.userapp.model;

import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.presenter.BackgroundVehicleUpdatePresenter;
import com.sybus.android.userapp.presenter.TrackPresenter;
import com.sybus.android.userapp.presenterListener.BackgroundVehicleUpdatePresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.presenterListener.TrackPresenterListener;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface Vehicle {
    public void searchAvailableVehicles(String destination, Double lng, Double lat, int range, SearchPresenterListener listener);
    public void getVehicleDetail(long vehicleID, String userStop, String destStop, String destination, SearchPresenterListener listener);
    public void searchVehicleForRoute(String routeName, SearchPresenterListener listener);
    public void searchVehicleForStop(String stopName, SearchPresenterListener listener);

    public void cacheVehicle(DetailVehicleDto vehicle, TrackPresenterListener listener);
    public void removeVehicleCache(TrackPresenterListener listener);
    public void getVehicleCache(TrackPresenterListener listener);
    public String getCachedETA(TrackPresenterListener listener);
    public void getVehicleUpdate(final long vehicleID, final String userStop,final BackgroundVehicleUpdatePresenterListener listener);
}
