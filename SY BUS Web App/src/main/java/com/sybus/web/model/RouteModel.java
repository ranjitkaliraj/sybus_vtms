package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class RouteModel {
	//display data - name and routeStops
	//add data = name and addedRouteStopNames
	//update data = name, updatedRouteName, addedRouteStopNames. --  view filters.
	
	@JsonView(Views.Public.class)
	private String name;
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<BusStopModel> stops;
	
	@JsonView(Views.UpdateData.class)
	private String updatedRouteName;

	@JsonView(Views.AddData.class)
	private ArrayList<String> addedRouteStopNames;
	
	@JsonView(Views.UpdateData.class)
	private ArrayList<RouteModel> updateRouteData;  //it is arraylist of this class itself. it is of UpdateData view type so the object will have only name, stoplist and update name variable.
	
	@JsonView(Views.Tracking.class)
	private ArrayList<WayNodeModel> wayLine;
	
	public ArrayList<WayNodeModel> getWayLine() {
		return wayLine;
	}
	public void setWayLine(ArrayList<WayNodeModel> wayLine) {
		this.wayLine = wayLine;
	}
	public ArrayList<RouteModel> getUpdateRouteData() {
		return updateRouteData;
	}
	public void setUpdateRouteData(ArrayList<RouteModel> updateRouteData) {
		this.updateRouteData = updateRouteData;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public ArrayList<String> getAddedRouteStopNames() {
		return addedRouteStopNames;
	}
	public void setAddedRouteStopNames(ArrayList<String> addedRouteStopNames) {
		this.addedRouteStopNames = addedRouteStopNames;
	}
	public ArrayList<BusStopModel> getStops() {
		return stops;
	}
	public void setStops(ArrayList<BusStopModel> stops) {
		this.stops = stops;
	}
	public String getUpdatedRouteName() {
		return updatedRouteName;
	}
	public void setUpdatedRouteName(String updatedRouteName) {
		this.updatedRouteName = updatedRouteName;
	}
}
