package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class VehicleResult {

	@JsonView(Views.Location.class)
	ArrayList<VehicleModel> activeVehicles;
	
	@JsonView(Views.Location.class)
	ArrayList<VehicleModel> flaggedVehicles;

	public ArrayList<VehicleModel> getActiveVehicles() {
		return activeVehicles;
	}

	public void setActiveVehicles(ArrayList<VehicleModel> activeVehicles) {
		this.activeVehicles = activeVehicles;
	}

	public ArrayList<VehicleModel> getFlaggedVehicles() {
		return flaggedVehicles;
	}

	public void setFlaggedVehicles(ArrayList<VehicleModel> flaggedVehicles) {
		this.flaggedVehicles = flaggedVehicles;
	}
	
	
}
