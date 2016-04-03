package com.sybus.web.model;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class SingleStopDistanceModel {
	
	@JsonView(Views.Public.class)
	private String name;
	
	@JsonView(Views.Public.class)
	private int distance;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
}
