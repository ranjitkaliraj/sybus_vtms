package com.sybus.web.database.domain;

import java.util.ArrayList;
import java.util.HashMap;

public class Route {
	private String name;
	private String oldName;
	private String stopsList;
	private ArrayList<BusStop> stopsObject;
	private ArrayList<WayNode> routeway;
	private ArrayList<Integer> stopDistance;	//provide in sequence as of bus stop.
	private ArrayList<String> stopName;	//provide in sequence as of bus stop.
	private ArrayList<Long> stopIds;	//provide in sequence as of bus stop.
	
	public ArrayList<Long> getStopIds() {
		return stopIds;
	}
	public void setStopIds(ArrayList<Long> stopIds) {
		this.stopIds = stopIds;
	}
	public ArrayList<Integer> getStopDistance() {
		return stopDistance;
	}
	public void setStopDistance(ArrayList<Integer> stopDistance) {
		this.stopDistance = stopDistance;
	}
	public ArrayList<String> getStopName() {
		return stopName;
	}
	public void setStopName(ArrayList<String> stopName) {
		this.stopName = stopName;
	}
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
	public String getStopsList() {
		return stopsList;
	}
	public void setStopsList(String stopsList) {
		this.stopsList = stopsList;
	}
	public ArrayList<BusStop> getStopsObject() {
		return stopsObject;
	}
	public void setStopsObject(ArrayList<BusStop> stopsObject) {
		this.stopsObject = stopsObject;
	}
	public ArrayList<WayNode> getRouteway() {
		return routeway;
	}
	public void setRouteway(ArrayList<WayNode> routeway) {
		this.routeway = routeway;
	}
}
