package com.sybus.web.model;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class WayNodeModel {
	@JsonView(Views.Public.class)
	private int node;
	
	@JsonView(Views.Public.class)
	private float latitude;
	
	@JsonView(Views.Public.class)
	private float longitude;

	public int getNode() {
		return node;
	}

	public void setNode(int node) {
		this.node = node;
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
