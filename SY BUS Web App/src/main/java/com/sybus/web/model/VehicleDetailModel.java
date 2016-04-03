package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

//For use in Report no. 4.
public class VehicleDetailModel {

	@JsonView(Views.DisplayData.class)
	private ArrayList<RouteModel> routes;
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<ScheduleModel> schedules;

	@JsonView(Views.DisplayData.class)
	private ArrayList<VehicleModel> vehicles;

	@JsonView(Views.DisplayData.class)
	private ArrayList<FareModel> fares;
	
	public ArrayList<RouteModel> getRoutes() {
		return routes;
	}
	public void setRoutes(ArrayList<RouteModel> routes) {
		this.routes = routes;
	}
	public ArrayList<ScheduleModel> getSchedules() {
		return schedules;
	}
	public void setSchedules(ArrayList<ScheduleModel> schedules) {
		this.schedules = schedules;
	}
	public ArrayList<VehicleModel> getVehicles() {
		return vehicles;
	}
	public void setVehicles(ArrayList<VehicleModel> vehicles) {
		this.vehicles = vehicles;
	}
	public ArrayList<FareModel> getFares() {
		return fares;
	}
	public void setFares(ArrayList<FareModel> fares) {
		this.fares = fares;
	}
	

}
