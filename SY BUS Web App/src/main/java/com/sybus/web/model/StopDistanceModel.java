package com.sybus.web.model;

import java.util.ArrayList;

import org.json.simple.JSONObject;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class StopDistanceModel {
	
	@JsonView(Views.Public.class)
	private String name;
	
	@JsonView(Views.Public.class)
	private boolean available;
	
	@JsonView(Views.ObjectCollection.class)
	private ArrayList<StopDistanceModel> stops;		//store collection of single stop below.

	@JsonView(Views.Single.class)
	private int distance;				
	
	@JsonView(Views.Single.class)
	private String stopName;
	
	@JsonView(Views.Object.class)
	private StopDistanceModel stop; 		//store distance and stopName only. as single row.
	
	@JsonView(Views.AllCollection.class)
	private ArrayList<StopDistanceModel> allData;		//store all data. i.e. collection of this object that contain name available and stops attribute.
	
	@JsonView(Views.Public.class)
	private ArrayList<SingleStopDistanceModel> distanceData;
	
	public ArrayList<SingleStopDistanceModel> getDistanceData() {
		return distanceData;
	}

	public void setDistanceData(ArrayList<SingleStopDistanceModel> distanceData) {
		this.distanceData = distanceData;
	}

	public StopDistanceModel getStop() {
		return stop;
	}

	public void setStop(StopDistanceModel stop) {
		this.stop = stop;
	}

	public ArrayList<StopDistanceModel> getAllData() {
		return allData;
	}

	public void setAllData(ArrayList<StopDistanceModel> allData) {
		this.allData = allData;
	}

	public ArrayList<StopDistanceModel> getStops() {
		return stops;
	}
	
	public void setStops(ArrayList<StopDistanceModel> stops) {
		this.stops = stops;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getStopName() {
		return stopName;
	}

	public void setStopName(String stopName) {
		this.stopName = stopName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}
}
