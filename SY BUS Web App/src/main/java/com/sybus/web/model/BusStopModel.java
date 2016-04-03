package com.sybus.web.model;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class BusStopModel {
	
	@JsonView(Views.Public.class)
	private String name;
	
	@JsonView(Views.Public.class)
	private float latitude;
	
	@JsonView(Views.Public.class)
	private float longitude;

	@JsonView(Views.AddData.class)
	private String updatedName; 
	
	public String getUpdatedName() {
		return updatedName;
	}

	public void setUpdatedName(String updatedName) {
		this.updatedName = updatedName;
	}

	public String getName() {
		return name;
	}

	public void setName(String busStopName) {
		this.name = busStopName;
	}

	public float getLatitude() {
		return latitude;
	}

	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public float getLongitude() {
		return longitude;
	}

	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}	
}
