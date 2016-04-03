package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class ScheduleModel {
	
	@JsonView(Views.Public.class)
	private long scheduleID;
	
	@JsonView(Views.Public.class)
	private String route;
	
	@JsonView(Views.Public.class)
	private String vehicle;
	
	@JsonView(Views.Public.class)
	private String time;
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<ScheduleModel> schedules;
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<String> routes;
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<String> vehicles;

	public long getScheduleID() {
		return scheduleID;
	}

	public void setScheduleID(long scheduleID) {
		this.scheduleID = scheduleID;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public ArrayList<ScheduleModel> getSchedules() {
		return schedules;
	}

	public void setSchedules(ArrayList<ScheduleModel> schedules) {
		this.schedules = schedules;
	}

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
