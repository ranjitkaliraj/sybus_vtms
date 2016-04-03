package com.sybus.android.driverapp.model;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 12/16/2015.
 */
public class Vehicle {
    private ArrayList<String> vehicles;
    private ArrayList<String> routes;

    public Vehicle(ArrayList<String> vehicles, ArrayList<String> routes) {
        this.vehicles = vehicles;
        this.routes = routes;
    }

    //no arg constructor
    public Vehicle() {}

    public ArrayList<String> getRoutes() {
        return routes;
    }

    public void setRoutes(ArrayList<String> routes) {
        this.routes = routes;
    }

    public ArrayList<String> getVehicles() {
        return vehicles;
    }

    public void setVehicles(ArrayList<String> vehicles) {
        this.vehicles = vehicles;
    }
}

