package com.sybus.android.userapp.pojo;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
@SuppressWarnings("serial")
public class DetailVehicleDto implements Serializable{
    private SearchVehicleDto vehicle;
    private LngLat destinationLocation;
    private LngLat destStopLocation;
    private LngLat vehicleLocation;
    private LngLat userStopLocation;
    private ArrayList<LngLat> way;
    private int fare;
    private boolean isVehicleExpired;

    public SearchVehicleDto getVehicle() {
        return vehicle;
    }

    public void setVehicle(SearchVehicleDto vehicle) {
        this.vehicle = vehicle;
    }

    public LngLat getDestinationLocation() {
        return destinationLocation;
    }

    public void setDestinationLocation(LngLat destinationLocation) {
        this.destinationLocation = destinationLocation;
    }

    public LngLat getDestStopLocation() {
        return destStopLocation;
    }

    public void setDestStopLocation(LngLat destStopLocation) {
        this.destStopLocation = destStopLocation;
    }

    public LngLat getVehicleLocation() {
        return vehicleLocation;
    }

    public void setVehicleLocation(LngLat vehicleLocation) {
        this.vehicleLocation = vehicleLocation;
    }

    public LngLat getUserStopLocation() {
        return userStopLocation;
    }

    public void setUserStopLocation(LngLat userStopLocation) {
        this.userStopLocation = userStopLocation;
    }

    public ArrayList<LngLat> getWay() {
        return way;
    }

    public void setWay(ArrayList<LngLat> way) {
        this.way = way;
    }

    public int getFare() {
        return fare;
    }

    public void setFare(int fare) {
        this.fare = fare;
    }

    public boolean isVehicleExpired() {
        return isVehicleExpired;
    }

    public void setIsVehicleExpired(boolean isVehicleExpired) {
        this.isVehicleExpired = isVehicleExpired;
    }
}
