package com.sybus.web.model;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class RouteWayModel {
	
	@JsonView(Views.Public.class)
	private String name;
	
	@JsonView(Views.Public.class)
	private ArrayList<WayNodeModel> wayLine;

	@JsonView(Views.DisplayData.class)
	private ArrayList<RouteWayModel> routeWay;		//for load data. contain collection of route way. (name, wayline.)
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<String> routeWayAvailableStops;	//for load data
	
	@JsonView(Views.DisplayData.class)
	private ArrayList<String> routeWayNotAvailableStops;	//for load data.
	
	public ArrayList<RouteWayModel> getRouteWay() {
		return routeWay;
	}

	public void setRouteWay(ArrayList<RouteWayModel> routeWay) {
		this.routeWay = routeWay;
	}

	public ArrayList<String> getRouteWayAvailableStops() {
		return routeWayAvailableStops;
	}

	public void setRouteWayAvailableStops(ArrayList<String> routeWayAvailableStops) {
		this.routeWayAvailableStops = routeWayAvailableStops;
	}

	public ArrayList<String> getRouteWayNotAvailableStops() {
		return routeWayNotAvailableStops;
	}

	public void setRouteWayNotAvailableStops(ArrayList<String> routeWayNotAvailableStops) {
		this.routeWayNotAvailableStops = routeWayNotAvailableStops;
	}

	public String getName() {
		return name;
	}

	public void setName(String routeName) {
		this.name = routeName;
	}

	public ArrayList<WayNodeModel> getWayLine() {
		return wayLine;
	}

	public void setWayLine(ArrayList<WayNodeModel> wayLine) {
		this.wayLine = wayLine;
	}
	
		
}
