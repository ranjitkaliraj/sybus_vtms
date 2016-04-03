package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.RouteDao;
import com.sybus.web.database.domain.BusStop;
import com.sybus.web.model.BusStopModel;

public class BusStopService {
	private RouteDao routeDao;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(BusStopService.class);
	
	public BusStopService(RouteDao routeDao){
		this.routeDao = routeDao;
	}
	
	//this function gets the bus stop list of all bus stops.
	public ArrayList<BusStopModel> getAllBusStops(){
		logger.info("Starting to get all bus stop list");
		ArrayList<BusStopModel> list = new ArrayList<>();
		
		logger.info("Getting all bus stops list");
		ArrayList<BusStop> domainStopList = routeDao.getAllBusStop();
		for( BusStop stop : domainStopList){
			BusStopModel model = new BusStopModel();
			model.setName(stop.getBusStop());
			model.setLatitude(stop.getLatitude());
			model.setLongitude(stop.getLongitude());
			list.add(model);
		}
		logger.info("Returning bus stop list");
		return list;
	}
	
	//This function gets all the bus stops list but for particular route.
	public ArrayList<BusStopModel> getAllBusStops(String routeName){
		logger.info("Starting to get all bus stop list for {}",routeName);
		ArrayList<BusStopModel> list = new ArrayList<>();
		
		//getting the stops list first for this route.
		//String stops = routeDao.getBusStops(routeName);
		
		String[] stopList = routeDao.getBusStops(routeName).trim().split(",");
		
		logger.info("Getting all bus stops list.");
		for(String stop : stopList){
			BusStop busStopDomain = routeDao.getSingleBusStopLatLng(stop);
			BusStopModel model = new BusStopModel();
			model.setName(busStopDomain.getBusStop());
			model.setLatitude(busStopDomain.getLatitude());
			model.setLongitude(busStopDomain.getLongitude());
			list.add(model);
		}		
		logger.info("Returning bus stop list");
		return list;
	}
	
	
	//this function add new bus stop.
	public boolean addBusStop(BusStopModel model){
		logger.info("Starting to add bus stop");
		BusStop stop = new BusStop();
		stop.setBusStop(model.getName());
		stop.setLatitude(model.getLatitude());
		stop.setLongitude(model.getLongitude());
		
		logger.info("Now calling databse layer function to add bus stop");
		return routeDao.addBusStop(stop);
	}
	
	
	//This function update bus stop
	private void updateBusStop(BusStopModel model){
		logger.info("Starting to update bus stop");
		BusStop stop = new BusStop();
		logger.info("Converting model object into domain object.");
		stop.setOldBusStop(model.getName());
		stop.setBusStop(model.getUpdatedName());
		stop.setLatitude(model.getLatitude());
		stop.setLongitude(model.getLongitude());
		
		logger.info("Now calling databse layer function to update bus stop");
		routeDao.updateBusStop(stop);
	}
	
	//This function update the bus stop in bulk
	public void updateBusStopInBulk(ArrayList<BusStopModel> list){
		logger.info("Updating {} bus stops in bulk.",list.size());
		for(BusStopModel stop : list){
			this.updateBusStop(stop);
		}
	}
	
	//This function delete a bus stop
	private void deleteBusStop(String name){
		logger.info("Deleteing stop: {}",name);
		routeDao.deleteBusStop(name);
	}
		
	//this function delete bus stops in bulk
	public void deleteBusStops(ArrayList<String> stops){
		logger.info("Deleting stops in bulk. total stops: {}", stops.size());
		for(String name : stops){
			this.deleteBusStop(name);
		}
	}
	

}
