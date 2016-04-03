package com.sybus.web.database.domain;

public class Vehicle {
	private long scheduleID;
	private long vehicelID;
	private String name;
	private float longitude;
	private float latitude;
	private String roadName;
	private String eta;
	private String nextStop;
	

	public long getScheduleID() {
		return scheduleID;
	}
	public void setScheduleID(long scheduleID) {
		this.scheduleID = scheduleID;
	}
	public long getVehicelID() {
		return vehicelID;
	}
	public void setVehicelID(long vehicelID) {
		this.vehicelID = vehicelID;
	}
	public String getName() {
		return name;		
	}
	public void setName(String name) {
		this.name = name;
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

	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	public String getEta() {
		return eta;
	}
	public void setEta(String eta) {
		this.eta = eta;
	}
	public String getNextStop() {
		return nextStop;
	}
	public void setNextStop(String nextStop) {
		this.nextStop = nextStop;
	}	
	
}
