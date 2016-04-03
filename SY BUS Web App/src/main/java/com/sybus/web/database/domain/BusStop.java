package com.sybus.web.database.domain;

public class BusStop {
	private String busStop;
	private String oldBusStop;
	private float longitude; 
	private float latitude;
	
	public String getBusStop() {
		return busStop;
	}
	public void setBusStop(String busStop) {
		this.busStop = busStop;
	}
	public String getOldBusStop() {
		return oldBusStop;
	}
	public void setOldBusStop(String oldBusStop) {
		this.oldBusStop = oldBusStop;
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
}
