package com.sybus.web.model;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;

public class FareModel {

	@JsonView(Views.Public.class)
	private int distance;
	
	@JsonView(Views.Public.class)
	private float amount;
	
	@JsonView(Views.UpdateData.class)
	private int oldDistance;
	
	@JsonView(Views.UpdateData.class)
	private float oldAmount;

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
}
