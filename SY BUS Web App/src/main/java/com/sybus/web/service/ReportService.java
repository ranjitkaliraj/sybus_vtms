package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.FareDao;
import com.sybus.web.database.dao.PassengerDao;
import com.sybus.web.database.dao.RouteDao;
import com.sybus.web.database.dao.ScheduleDao;
import com.sybus.web.database.dao.VehicleDao;
import com.sybus.web.database.domain.BusStop;
import com.sybus.web.database.domain.Fare;
import com.sybus.web.database.domain.Passenger;
import com.sybus.web.database.domain.Route;
import com.sybus.web.database.domain.Schedule;
import com.sybus.web.model.BusStopModel;
import com.sybus.web.model.FareModel;
import com.sybus.web.model.PassengerModel;
import com.sybus.web.model.RouteModel;
import com.sybus.web.model.ScheduleModel;
import com.sybus.web.model.VehicleDetailModel;
import com.sybus.web.model.VehicleModel;

public class ReportService {
	private VehicleDao vehicleDao;
	private RouteDao routeDao;
	private FareDao fareDao;
	private ScheduleDao scheduleDao;
	private PassengerDao passengerDao;
	
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(ReportService.class);
	
	public ReportService(VehicleDao vehicleDao, RouteDao routeDao, FareDao fareDao, ScheduleDao scheduleDao, PassengerDao passengerDao){
		this.vehicleDao = vehicleDao;
		this.routeDao = routeDao;
		this.fareDao = fareDao;
		this.scheduleDao = scheduleDao;
		this.passengerDao = passengerDao;
	}
	
	
	//This function gets the passenger details.
	public ArrayList<PassengerModel> getPassengerDetails(){
		logger.info("Getting passenger details for reporting.");
		ArrayList<PassengerModel> list = new ArrayList<>();
		
		ArrayList<Passenger> dbResult = passengerDao.getPassengers();
		
		for(Passenger p : dbResult){
			PassengerModel m = new PassengerModel();
			m.setName(p.getName());
			m.setEmail(p.getEmail());
			list.add(m);
		}
		return list;
	}
	
	
	
	//this function get the route, vehicle, schedule and fare details.
	public VehicleDetailModel getVehicleDetails(){
		logger.info("Getting vehicles details for reporting.");
		 
		VehicleDetailModel model = new VehicleDetailModel();
		
		model.setRoutes(this.getRoutes());
		model.setSchedules(this.getAllSchedules());
		model.setFares(this.getAllFares());
		model.setVehicles(this.getAllVehicles());
		
		return model;		
	}
	
	//this function gets the list of available routes
	private ArrayList<RouteModel> getRoutes(){
		logger.info("Starting to get routes.");
		ArrayList<RouteModel> routes = new ArrayList<>();
		
		//getting the data from data layer.
		logger.info("Getting all routes and looping.");
		for(int i=0; i<routeDao.getRoutes().size();i++){
			RouteModel routeModel = new RouteModel();
			logger.info("New Route model instantiated");
			
			Route route = routeDao.getRoutes().get(i);
			logger.info("All routes received");
			ArrayList<BusStopModel> stops = new ArrayList<>();
			
			//splitting the route list into array.
			String[] stopsList = route.getStopsList().split(",");
						
			//getting the long. lat for each stop
			logger.info("Getting long lat object of each bus stops.");
			for(int j=0;j<stopsList.length;j++){
				BusStop stop = routeDao.getSingleBusStopLatLng(stopsList[j]);
				BusStopModel stopModel = new BusStopModel();
				stopModel.setName(stop.getBusStop());
				stopModel.setLatitude(stop.getLatitude());
				stopModel.setLongitude(stop.getLongitude());
				stops.add(stopModel);
				//logger.info("Stop object added.");
			}
			routeModel.setName(route.getName());
			routeModel.setStops(stops);
			routes.add(routeModel);
		}	
		logger.info("Returning the array of all the routes with Bus stop long and lat.");
		return routes;	
	}
	
	//this function gets all the Fare name list.
	private ArrayList<FareModel> getAllFares(){
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
	
	
	//this function gets the bus stop list of all bus stops.
	private ArrayList<ScheduleModel> getAllSchedules(){
		logger.info("Starting to get all schedule list");
		
		//model object to store schedule collection, routelist adn vehicle list.
		//ArrayList<ScheduleModel> collection = new ArrayList<>();
		
		//Getting the schedule list from database.
		logger.info("Getting the schedule list from database.");
		ArrayList<Schedule> scheduleList = scheduleDao.getScheduleData();

		ArrayList<ScheduleModel> models = new ArrayList<>();
		logger.info("Transforming domain object into model object");
		for(Schedule schedule : scheduleList){
			ScheduleModel model = new ScheduleModel();
			model.setRoute(scheduleDao.getRouteName(schedule.getRouteID()));
			model.setScheduleID(schedule.getScheduleID());
			model.setTime(schedule.getTime());
			model.setVehicle(scheduleDao.getVehicleName(schedule.getVehicleID()));;
			models.add(model);
		}
		logger.info("Returning bus stop list");
		return models;
	}
	
	//this function gets all the vehicle name list.
	private ArrayList<VehicleModel> getAllVehicles(){
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
}
