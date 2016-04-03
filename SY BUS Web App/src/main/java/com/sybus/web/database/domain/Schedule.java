package com.sybus.web.database.domain;

public class Schedule {
	private long scheduleID;
	private long routeID;
	private long vehicleID;
	private String time;
	
	public long getScheduleID() {
		return scheduleID;
	}
	public void setScheduleID(long scheduleID) {
		this.scheduleID = scheduleID;
	}
	public long getRouteID() {
		return routeID;
	}
	public void setRouteID(long routeID) {
		this.routeID = routeID;
	}
	public long getVehicleID() {
		return vehicleID;
	}
	public void setVehicleID(long vehicleID) {
		this.vehicleID = vehicleID;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

}
