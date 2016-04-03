package com.sybus.web.database.domain;

public class Fare {
	private int distance;
	private float amount;
	private int oldDistance;
	private float oldAmount;
	
	public int getOldDistance() {
		return oldDistance;
	}
	public void setOldDistance(int oldDistance) {
		this.oldDistance = oldDistance;
	}
	public float getOldAmount() {
		return oldAmount;
	}
	public void setOldAmount(float oldAmount) {
		this.oldAmount = oldAmount;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}	
}
