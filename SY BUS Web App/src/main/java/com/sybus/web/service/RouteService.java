package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.RouteDao;
import com.sybus.web.database.domain.BusStop;
import com.sybus.web.database.domain.Route;
import com.sybus.web.database.domain.WayNode;
import com.sybus.web.model.BusStopModel;
import com.sybus.web.model.RouteModel;
import com.sybus.web.model.RouteWayModel;
import com.sybus.web.model.SingleStopDistanceModel;
import com.sybus.web.model.StopDistanceModel;
import com.sybus.web.model.WayNodeModel;

public class RouteService {
	private RouteDao routeDao;
	private BusStopService busStopService;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(RouteService.class);
	
	public RouteService(RouteDao routeDao, BusStopService busStopService){
		this.routeDao = routeDao;
		this.busStopService = busStopService;
	}
	
	//this function gets the list of available routes
	public ArrayList<RouteModel> getRoutes(){
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
	
	//This function add the route details.
	public boolean saveRouteDetails(RouteModel route){
		logger.info("Setting parameter to domain Route object from Route Model object");
		Route domainRoute = new Route();
		domainRoute.setName(route.getName());
		domainRoute.setStopsList(getStringOfArray(route.getAddedRouteStopNames()));

		logger.info("Starting to add Route");
		if (routeDao.addRoute(domainRoute)==true){
			
			logger.info("Now, adding the route stop distance to default Zero value.");
			//setting the route distance between all stops to zero.
			for(int i=0; i<route.getAddedRouteStopNames().size();i++){
				long routeId = routeDao.getRouteId(route.getName());
				long stopId = routeDao.getBusStopId(route.getAddedRouteStopNames().get(i));
				
				//now adding the bus stops distance to zero.
				routeDao.addRouteStopsDistance(stopId, routeId, 0);
			}
			logger.info("Add successful. Returning true.");
			return true;
		}
		else{
			logger.info("Add un-successful. Returning false.");
			return false;
		}
	}
	
	
	//This function update the route details.
	private boolean updateRouteDetails(RouteModel route){
		logger.info("Converting Model object into Domain object.");
		Route domainRoute = new Route();
		domainRoute.setOldName(route.getName());
		domainRoute.setName(route.getUpdatedRouteName());
		domainRoute.setStopsList(getStringOfArray(route.getAddedRouteStopNames()));
		
		logger.info("Starting to update Route");
		if(routeDao.updateRoute(domainRoute) == true){
			logger.info("Update route {} success. Returning true.",domainRoute.getName());
			return true;
		}
		else{
			logger.info("Update route {} failed. Returning false.",domainRoute.getName());
			return false;
		}
	}
	
	//This function update multiple route detail.
	public void updateAllRoutes(ArrayList<RouteModel> routeList){
		logger.info("Updating {} routes.", routeList.size());
		for(RouteModel route : routeList){
			logger.info("Updating route: {}", route.getName());
			this.updateRouteDetails(route);
		}
	}
	
	//This function converts array of route into string
	public String getStringOfArray(ArrayList<String> list){
		String text = "";
		for(int i=0; i<list.size();i++){
			if(i==(list.size()-1)){
				text = text+list.get(i);
			}
			else{text = text+list.get(i)+",";}
		}
		return text;
	}
	
	//This function deletes the route details.
	public void deleteRoutes(ArrayList<String> routeNameList){
		for(String name : routeNameList){
			logger.info("Deleting the route rows from distance table first.");
			if(routeDao.deleteRouteRowOnDistance(routeDao.getRouteId(name))==true){
				logger.info("Deleting success now deleting the route itself.");
				routeDao.deleteRoute(name);
			}
		}
	}
	
	//This gets the all the routeway details.
	@Deprecated 
	public ArrayList<RouteWayModel> getAllRouteWays(){
		logger.info("Starting to get all route details.");
		
		//instantiating model list.
		ArrayList<RouteWayModel> list = new ArrayList<>();
		
		logger.info("First getting all the available route name list.");
		ArrayList<String> routesList = routeDao.getRouteNames();
		
		logger.info("Looping through each route and getting the route way data");
		for (String routeName : routesList){

			RouteWayModel routeWayModel = new RouteWayModel();
			
			logger.info("Getting route way data for {}",routeName);
			Route route = routeDao.getRouteWayData(routeName);
			
			ArrayList<WayNodeModel> nodeList = new ArrayList<>();
			
			logger.info("Converting Way Node Domain object into Model object.");
			for(WayNode wayNodeDomain : route.getRouteway()){
				WayNodeModel wayNodeModel= new WayNodeModel();
				
				wayNodeModel.setNode(wayNodeDomain.getNode());
				wayNodeModel.setLatitude(wayNodeDomain.getLatitude());
				wayNodeModel.setLongitude(wayNodeDomain.getLongitude());
				nodeList.add(wayNodeModel);			
			}
			logger.info("Now setting the route way model object.");
			routeWayModel.setWayLine(nodeList);
			routeWayModel.setName(routeName);
			list.add(routeWayModel);
		}	
		logger.info("returning the routeway data list");
		return list;
	}
	
	//This function add new route way data.
	public boolean addRouteWayData(RouteWayModel wayModel){
		logger.info("Starting to add new route way data");
		Route route = new Route();
		route.setName(wayModel.getName());
		
		ArrayList<WayNode> wayNodeList = new ArrayList<>();
		logger.info("Converting WayNodeModel object into WayNode Domain object");
		for(WayNodeModel model : wayModel.getWayLine()){
			WayNode wayNodeDomain = new WayNode();
			wayNodeDomain.setNode(model.getNode());
			wayNodeDomain.setLatitude(model.getLatitude());
			wayNodeDomain.setLongitude(model.getLongitude());
			wayNodeList.add(wayNodeDomain);
		}
		route.setRouteway(wayNodeList);
		
		logger.info("Now calling the database layer function to add data.");
		return routeDao.addRouteWay(route);
	}
	
	
	//this method add the routeway in a bulk.
	@Deprecated
	public void addRouteWayDataInBulk(ArrayList<RouteWayModel> wayModel){
		logger.info("Add route way in bulk for {} route way entry.",wayModel.size());
		for(RouteWayModel routeWay : wayModel){
			this.addRouteWayData(routeWay);
		}
	}
	
	//This function update the way data.
	public boolean updateRouteWayData(RouteWayModel wayModel){
		logger.info("Starting to update new route way data");
		Route route = new Route();
		route.setName(wayModel.getName());
		
		ArrayList<WayNode> wayNodeList = new ArrayList<>();
		logger.info("Converting WayNodeModel object into WayNode Domain object");
		for(WayNodeModel model : wayModel.getWayLine()){
			WayNode wayNodeDomain = new WayNode();
			wayNodeDomain.setNode(model.getNode());
			wayNodeDomain.setLatitude(model.getLatitude());
			wayNodeDomain.setLongitude(model.getLongitude());
			wayNodeList.add(wayNodeDomain);
		}
		route.setRouteway(wayNodeList);
		
		logger.info("Now calling the database layer function to update data.");
		return routeDao.addRouteWay(route);		//add update is same.   //the addrouteway method can be used but i created this separate method to update. I don't know why? :D
	}
	
	//This function deletes route way data.
	public boolean deleteRouteWayData(String routeName){
		return routeDao.deleteRouteWay(routeName);
	}
	
	//This function gets all the route stops distance data.
	public ArrayList<StopDistanceModel> getAllStopDistanceData(){
		ArrayList<StopDistanceModel> allCollection = new ArrayList<>();
		
		//first getting all the route stops list.
		logger.info("First getting all the available route name list.");
		ArrayList<String> routesList = routeDao.getRouteNames();
		
		logger.info("Looping through each route and getting the route stop distance data");
		for (String routeName : routesList){
			logger.info("Getting the distance info for {}",routeName);
			Route route = routeDao.getRouteStopsDistance(routeDao.getRouteId(routeName));
			
			StopDistanceModel model = new StopDistanceModel();

			ArrayList<Integer> distances = route.getStopDistance();
			logger.info("Got list of distance of this route: {}", distances.toString());
			ArrayList<Long> stops = route.getStopIds();
			logger.info("Got list of stops of this route: {}", stops.toString());
			
			//ArrayList to store the converted distance JSON object.
			ArrayList<StopDistanceModel> listOfSingleStopDistanceObject = new ArrayList<>();
			
			for(int i=0; i<distances.size();i++){
				StopDistanceModel SingleStopDistanceObject = new StopDistanceModel();
				SingleStopDistanceObject.setDistance(distances.get(i));
				SingleStopDistanceObject.setStopName(routeDao.getBusStopName(stops.get(i)));
				listOfSingleStopDistanceObject.add(SingleStopDistanceObject);
			}
			model.setName(routeName);
			if(routeDao.getRouteStopsDistanceSum()>0){
				model.setAvailable(true);
			}
			else{
				model.setAvailable(false);
			}
			model.setStops(listOfSingleStopDistanceObject);
			logger.info("Total row found for {} is :{}",routeName,listOfSingleStopDistanceObject.size());
			allCollection.add(model);
		}
		return allCollection;
	}
	
	
	//This function delete(set value to zero)/update route stops distance.
	public void updateRouteStopsDistance(StopDistanceModel model){
		logger.info("Starting add update of route stop distance value. stops count: {}",model.getDistanceData().size());
		long routeId = routeDao.getRouteId(model.getName());
		
		for(SingleStopDistanceModel stopObject : model.getDistanceData()){
			logger.info("looping and adding distance of {}, for stopname : {} and distance: {}",model.getName(), stopObject.getName(), stopObject.getDistance());
			long stop_id = routeDao.getBusStopId(stopObject.getName());
			routeDao.updateRouteStopsDistance(routeId, stop_id, stopObject.getDistance());
		}
	}
	
	
	//This function loads the route way data.
	public RouteWayModel getRouteWaysData(){
		logger.info("Starting to get route ways.");
		
		RouteWayModel routeWayModel = new RouteWayModel();		//main object to return.
		
		//first getting route unavailable routeway.
		logger.info("Getting route way un-available route names and adding it to Model object.");
		routeWayModel.setRouteWayNotAvailableStops(routeDao.getWayUnAvailableRoutes());
		
		//again getting the route way available route names.
		logger.info("Getting route way available route names and adding it to model object.");
		ArrayList<String> routeNames = routeDao.getWayAvailableRoutes();
		routeWayModel.setRouteWayAvailableStops(routeNames);
		
		//now looping through route way available route name and getting its route way.
		logger.info("Looping and Getting route way form route way available routes.");
			
		
		ArrayList<RouteWayModel> list = new ArrayList<>();  //stores route name and its way line string as way node collection of lng and lat and node.
		
		//looping each route name (way available route) and getting it and adding it to  model object.
		for(String name : routeNames){
			//instantiating model object to store all the available route way data.
			logger.info("instantiating model object to store all the available route way data and creating a array that will store each node data and this arraylist will be added to the instantiated model object.");
			RouteWayModel routeWayModel1 = new RouteWayModel();
			ArrayList<WayNodeModel> wayNodeList = new ArrayList<>();
			Route routeDomain = routeDao.getRouteWayData(name);
			logger.info("Now getting the way nodes for each route");
			for(WayNode node : routeDomain.getRouteway()){
				logger.info("node:{}, lat: {}, lng: {}",node.getNode(),node.getLatitude(), node.getLongitude());
				WayNodeModel model = new WayNodeModel();
				model.setNode(node.getNode());
				model.setLatitude(node.getLatitude());
				model.setLongitude(node.getLongitude());
				wayNodeList.add(model);
			}
			routeWayModel1.setName(name);
			routeWayModel1.setWayLine(wayNodeList);
			list.add(routeWayModel1);
		}
		routeWayModel.setRouteWay(list);
		logger.info("Returning route way data collection");
		return routeWayModel;
	}
	
	
	//This function gets name of all the available routes.
	public ArrayList<String> getRouteNames(){
		ArrayList<String> list = new ArrayList<>();
		list = routeDao.getRouteNames();
		return list;		
	}
	
	//Get the route list to display in tracking.
	public ArrayList<RouteModel> getRoutesForTracking(){
		logger.info("Starting to get route lsit for tracking");
		ArrayList<RouteModel> collection = new ArrayList<>();
		
		//First getting the all route names.
		logger.info("Getting the route name list and looping through each list and get bus stops and way line data.");
		ArrayList<String> routes = this.getRouteNames();
		
		//now looping through each route and getting its stops and routeway details.
		for(String route : routes){
			//getting all the stops details for this route.
			logger.info("Getting the all the bus stops data for route : {}",route);
			ArrayList<BusStopModel> stops = busStopService.getAllBusStops(route);
			
			Route nodes = routeDao.getRouteWayData(route);
			ArrayList<WayNodeModel> nodesModel = new ArrayList<>();
				
			logger.info("Transforming wayNode domain object into model object.: {}",nodes.getRouteway().toArray().toString());
			for(WayNode node : nodes.getRouteway()){
				WayNodeModel nodeModel = new WayNodeModel();
				nodeModel.setNode(node.getNode());
				nodeModel.setLatitude(node.getLatitude());
				nodeModel.setLongitude(node.getLongitude());
				nodesModel.add(nodeModel);
			}
			RouteModel routeModel = new RouteModel();
			routeModel.setName(route);
			routeModel.setStops(stops);
			routeModel.setWayLine(nodesModel);
			collection.add(routeModel);			
		}
		logger.info("Returning the route collection for tracking.");
		return collection;
	}
}

