package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.FareDao;
import com.sybus.web.database.domain.Fare;
import com.sybus.web.model.FareModel;

public class FareService {
	private FareDao fareDao;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(FareService.class);
	
	public FareService(FareDao fareDao){
		this.fareDao = fareDao;
	}
	
	//this function gets all the Fare name list.
	public ArrayList<FareModel> getAllFares(){
		logger.info("Starting to get all Fare list");
		ArrayList<FareModel> modelList = new ArrayList<>();
		
		ArrayList<Fare> FareList = fareDao.getFareData();
		
		logger.info("Transforming Fare object into model object");
		for(Fare fare : FareList){
			FareModel model = new FareModel();
			model.setAmount(fare.getAmount());
			model.setDistance(fare.getDistance());
			modelList.add(model);
		}
		logger.info("Returning Fare list");
		return modelList;
	}
	
	//this function add new Fare data.
	public boolean addFare(FareModel model){
		logger.info("Starting to add Fare details.");
		Fare fare = new Fare();
		fare.setAmount(model.getAmount());
		fare.setDistance(model.getDistance());
		
		logger.info("Now calling databse layer function to add Fare.");
		return fareDao.saveFareData(fare);
	}
	
	
	//This function update bus stop
	private void updateFare(FareModel model){
		logger.info("Starting to update Fare details.");		
		Fare fare = new Fare();
		fare.setAmount(model.getAmount());
		fare.setDistance(model.getDistance());
		fare.setOldAmount(model.getOldAmount());
		fare.setOldDistance(model.getOldDistance());
		
		logger.info("Now calling databse layer function to update Fare.");
		fareDao.updateFareData(fare);
	}
	
	//This function update the bus stop in bulk
	public void updateFareInBulk(ArrayList<FareModel> list){
		logger.info("Updating {} Fares in bulk.",list.size());
		for(FareModel Fare : list){
			this.updateFare(Fare);
		}
	}
	
	//This function delete a bus stop
	private void deleteFare(FareModel model){
		logger.info("Deleteing Fare");
		
		Fare fare = new Fare();
		fare.setAmount(model.getAmount());
		fare.setDistance(model.getDistance());
		
		fareDao.deleteFareData(fare);
	}
		
	//this function delete bus stops in bulk
	public void deleteFares(ArrayList<FareModel> Fares){
		logger.info("Deleting Fares in bulk. total stops: {}", Fares.size());
		for(FareModel fare : Fares){
			this.deleteFare(fare);
		}
	}	
}
