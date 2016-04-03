package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class VehicleModel {

	@JsonView(Views.Public.class)
	private String name;

	@JsonView(Views.Public.class)
	private String oldName;

	@JsonView(Views.Public.class)
	private long scheduleID;

	//For tracking only
	
	@JsonView(Views.Location.class)
	private String current_location;
	
	@JsonView(Views.Location.class)
	private float longitude;
	
	@JsonView(Views.Location.class)
	private float latitude;
	
	@JsonView(Views.Location.class)
	private String eta;

	@JsonView(Views.Location.class)
	private String schedule;
	
	@JsonView(Views.Location.class)
	private String nextStop;
		

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public float getLongitude() {
		return longitude;
	}

	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}

	public float getLatitude() {
		return latitude;
	}

	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public String getCurrent_location() {
		return current_location;
	}

	public void setCurrent_location(String current_location) {
		this.current_location = current_location;
	}

	public String getEta() {
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}


	public long getScheduleID() {
		return scheduleID;
	}

	public void setScheduleID(long scheduleID) {
		this.scheduleID = scheduleID;
	}

	public String getNextStop() {
		return nextStop;
	}

	public void setNextStop(String nextStop) {
		this.nextStop = nextStop;
	}
	
}
