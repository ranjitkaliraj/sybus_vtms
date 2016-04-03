package com.sybus.android.userapp.pojo;

import java.io.Serializable;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
@SuppressWarnings("serial")
public class SearchVehicleDto implements Serializable{
    private long vehicleID;
    private String vehicleName;
    private String currentLocation;
    private String nextStop;
    private String ETA;
    private String routeName;
    private String destinationStop;
    private String userNearStop;

    public long getVehicleID() {
        return vehicleID;
    }

    public void setVehicleID(long vehicleID) {
        this.vehicleID = vehicleID;
    }

    public String getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(String vehicleName) {
        this.vehicleName = vehicleName;
    }

    public String getCurrentLocation() {
        return currentLocation;
    }

    public void setCurrentLocation(String currentLocation) {
        this.currentLocation = currentLocation;
    }

    public String getNextStop() {
        return nextStop;
    }

    public void setNextStop(String nextStop) {
        this.nextStop = nextStop;
    }

    public String getETA() {
        return ETA;
    }

    public void setETA(String ETA) {
        this.ETA = ETA;
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getDestinationStop() {
        return destinationStop;
    }

    public void setDestinationStop(String destinationStop) {
        this.destinationStop = destinationStop;
    }

    public String getUserNearStop() {
        return userNearStop;
    }

    public void setUserNearStop(String userNearStop) {
        this.userNearStop = userNearStop;
    }
}
