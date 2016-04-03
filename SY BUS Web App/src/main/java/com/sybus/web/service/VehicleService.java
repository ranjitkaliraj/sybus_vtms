package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.VehicleDao;
import com.sybus.web.database.domain.Vehicle;
import com.sybus.web.model.VehicleModel;

public class VehicleService {
	private VehicleDao vehicleDao;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(VehicleService.class);
	
	public VehicleService(VehicleDao vehicleDao){
		this.vehicleDao = vehicleDao;
	}
	
	//this function gets all the vehicle name list.
	public ArrayList<VehicleModel> getAllVehicles(){
		logger.info("Starting to get all Vehicle list");
		ArrayList<VehicleModel> modelList = new ArrayList<>();
		
		ArrayList<String> VehicleList = vehicleDao.getVehicleData();
		
		logger.info("Transforming String array into model object");
		for(String vehicle : VehicleList){
			VehicleModel model = new VehicleModel();
			model.setName(vehicle);
			modelList.add(model);
		}
		logger.info("Returning vehicle list");
		return modelList;
	}
	
	//this function add new vehicle data.
	public boolean addVehicle(String vehicle){
		logger.info("Starting to add Vehicle details.");
		logger.info("Now calling databse layer function to add Vehicle.");
		return vehicleDao.saveVehicleData(vehicle);
	}
	
	
	//This function update bus stop
	private void updateVehicle(VehicleModel model){
		logger.info("Starting to update Vehicle details.");		
		logger.info("Now calling databse layer function to update Vehicle.");
		vehicleDao.updateVehicleData(model.getOldName(), model.getName());
	}
	
	//This function update the bus stop in bulk
	public void updateVehicleInBulk(ArrayList<VehicleModel> list){
		logger.info("Updating {} Vehicles in bulk.",list.size());
		for(VehicleModel Vehicle : list){
			this.updateVehicle(Vehicle);
		}
	}
	
	//This function delete a bus stop
	private void deleteVehicle(String name){
		logger.info("Deleteing Vehicle: {}",name);
		vehicleDao.deleteVehicleData(name);
	}
		
	//this function delete bus stops in bulk
	public void deleteVehicles(ArrayList<String> Vehicles){
		logger.info("Deleting Vehicles in bulk. total stops: {}", Vehicles.size());
		for(String Vehicle : Vehicles){
			this.deleteVehicle(Vehicle);
		}
	}
	
	//This function gets vehicle list as collection of string.
	public ArrayList<String> getVehicleNameList(){
		logger.info("Starting to get all Vehicle list");
		ArrayList<String> list = new ArrayList<>();
		
		ArrayList<String> VehicleList = vehicleDao.getVehicleData();
		
		logger.info("Transforming String array into model object");
		for(String vehicle : VehicleList){
			list.add(vehicle);
		}
		logger.info("Returning vehicle list");
		return list;
	}
	
	
	//This function gets list of all the active vehicles.
	public ArrayList<VehicleModel> getActiveVehicles(String route){
		logger.info("Getting and returning active vehicles");
		ArrayList<VehicleModel> vehicles = new ArrayList<>();
		
		ArrayList<Vehicle> list = vehicleDao.getActiveVehicles(route);
		for(Vehicle vehicle : list){
			VehicleModel model = new VehicleModel();
			model.setScheduleID(vehicle.getScheduleID());
			model.setName(vehicleDao.getVehicleName(vehicle.getVehicelID()));
			model.setLatitude(vehicle.getLatitude());
			model.setLongitude(vehicle.getLongitude());
			vehicles.add(model);
		}
		return vehicles;
	}
	
	//This function gets list of all the active vehicles.
	public ArrayList<VehicleModel> getFlaggedVehicles(String route){
		logger.info("Getting and returning flagged vehicles");
		ArrayList<VehicleModel> vehicles = new ArrayList<>();
		
		ArrayList<Vehicle> list = vehicleDao.getFlaggedVehicles(route);
		for(Vehicle vehicle : list){
			VehicleModel model = new VehicleModel();
			model.setScheduleID(vehicle.getScheduleID());
			model.setName(vehicleDao.getVehicleName(vehicle.getVehicelID()));
			model.setLatitude(vehicle.getLatitude());
			model.setLongitude(vehicle.getLongitude());
			vehicles.add(model);
		}
		return vehicles;
	}
	
	
	//This function gets the vehicle Tracking details such as ETA, Next bus stop, etc.
	public VehicleModel getVehicleDetails(String vehicleName, String routeName, float lng, float lat){
		logger.info("Getting the next bus stop of vehicle : {}", vehicleName);
		String nextBusStop = vehicleDao.getVehicleNexttBusStop(lat, lng, routeName);
		
		logger.info("Now, getting ETA and current busstop of vehicle");
		String[] eta = vehicleDao.getVehicleETA(routeName, vehicleName, nextBusStop);
		
		VehicleModel vehicle = new VehicleModel();
		vehicle.setName(vehicleName);
		vehicle.setLatitude(lat);
		vehicle.setLongitude(lng);
		vehicle.setEta(eta[0]);
		vehicle.setCurrent_location(eta[1]);
		vehicle.setNextStop(nextBusStop);
		
		return vehicle;
	}
	
	
	//THis function flag vehicle.
	public boolean flagVehicle(String vehicleName){
		return vehicleDao.flag(vehicleName);
	}
	
	
	//this function unflag vehicle
	public boolean unFlagVehicle(String vehicleName){
		return vehicleDao.unFlag(vehicleName);
	}
}
