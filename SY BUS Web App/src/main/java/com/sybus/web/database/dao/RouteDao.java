package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.BusStop;
import com.sybus.web.database.domain.Route;
import com.sybus.web.database.domain.WayNode;

public class RouteDao {
	private JdbcTemplate jdbcTemplate;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(RouteDao.class);

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	// this function gets list of all available route list.
	public ArrayList<Route> getRoutes() {
		logger.info("Getting all route list from the database.");
		String sql = "SELECT ROUTE_NAME, BUS_STOPS FROM ROUTE";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Route>>() {

			@Override
			public ArrayList<Route> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Route> list = new ArrayList<>();
				while (result.next()) {
					Route route = new Route();
					route.setName(result.getString(1));
					String a = result.getString(2);
					route.setStopsList(a);
					list.add(route);
				}
				statement.close();
				return list;
			}
		});
	}

	// this function insert route data
	public boolean addRoute(Route route) {
		logger.info("Starting add route.");

		String sql = "INSERT INTO ROUTE(route_name, bus_stops) VALUES('" + route.getName() + "','"+ route.getStopsList() + "')";
		logger.info("Adding the route data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Route add successful.");
			return true;
		} else {
			logger.error("Route add failed");
			return false;
		}
	}
	
	//this function update particular route.
	public boolean updateRoute(Route route){
		logger.info("Starting update route.");

		String sql = "UPDATE ROUTE SET ROUTE_NAME='"+route.getName()+"', BUS_STOPS='" + route.getStopsList() + "' WHERE ROUTE_NAME='" + route.getOldName() + "'";
		logger.info("updating the route data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Route update successful.");
			return true;
		} else {
			logger.error("Route update failed");
			return false;
		}
	}
	
	//this function delete particular route
	public boolean deleteRoute(String routeName){
		logger.info("Starting delete route.");

		String sql = "DELETE FROM ROUTE WHERE ROUTE_NAME='" + routeName + "'";
		logger.info("Deleting the route data to the database route table. route name: {}", routeName);
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Route delete successful.");
			return true;
		} else {
			logger.error("Route delete failed");
			return false;
		}
	}
	
	
	//this function delete the route fk row on distance table.
	public boolean deleteRouteRowOnDistance(long routeId){
		logger.info("Starting delete route stops distance.");

		String sql = "DELETE FROM DISTANCE WHERE ROUTE_ID='" + routeId + "'";
		logger.info("Deleting the route stops distance data to the database distance table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Route stops distance delete successful.");
			return true;
		} else {
			logger.error("Route stops distance delete failed");
			return false;
		}
	}
	
	
	//this function gets the all the bus stop list
	public ArrayList<BusStop> getAllBusStop(){
		logger.info("Getting all bus stop list from the database.");
		String sql = "SELECT STOP_NAME, st_x(st_transform(st_setsrid(location_point,900913),4326)),  st_y(st_transform(st_setsrid(location_point,900913),4326)) FROM BusStop";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<BusStop>>() {

			@Override
			public ArrayList<BusStop> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<BusStop> list = new ArrayList<>();
				while (result.next()) {
					BusStop stop = new BusStop();
					stop.setBusStop(result.getString(1));
					stop.setLongitude(result.getFloat(2));
					stop.setLatitude(result.getFloat(3));
					list.add(stop);
				}
				//statement.close();
				return list;
			}
		});
	}
	
	//this function gets particular bus stop long. lat. takes stop name as parameter.
	public BusStop getSingleBusStopLatLng(String stopName){
		logger.info("Getting single bus stop list from the database for stop name: {}", stopName);
		String sql = "SELECT STOP_NAME, st_x(st_transform(st_setsrid(location_point,900913),4326)),  st_y(st_transform(st_setsrid(location_point,900913),4326)) FROM BusStop WHERE stop_name='"+stopName+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<BusStop>() {

			@Override
			public BusStop doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();

				BusStop stop = new BusStop();
				if (result.next()) {
					stop.setBusStop(result.getString(1));
					stop.setLongitude(result.getFloat(2));
					stop.setLatitude(result.getFloat(3));
				}
				//statement.close();
				return stop;
			}
		});
	}
	

	//this functions gets the bus stops list as string from database.
	public String getBusStops(String routeName){
		logger.info("Starting to get string format bus stop list for {}",routeName);
		String sql = "SELECT bus_stops FROM ROUTE WHERE route_name='"+routeName+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();

				String stops = new String();
				
				if (result.next()) {
					stops = result.getString(1);
				}
				//statement.close();
				return stops;
			}
		});
	}
	//This function adds the bus stop to the database.
	public boolean addBusStop(BusStop stop) {
		logger.info("Starting add bus stop.");

		String sql = "INSERT INTO BUSSTOP(stop_name, location_point) VALUES('" + stop.getBusStop() + "',ST_Transform(ST_SetSRID(ST_MakePoint("+stop.getLongitude()+", "+stop.getLatitude()+"), 4326),900913))";
		logger.info("Adding the bus stop data to the database busstop table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Bus stop add successful.");
			return true;
		} else {
			logger.error("Bus stop add failed");
			return false;
		}
	}
	
	//This function update the bus stop to the database.
	public boolean updateBusStop(BusStop stop) {
		logger.info("Starting update bus stop.");

		String sql = "UPDATE BUSSTOP SET STOP_NAME='" + stop.getBusStop() + "',LOCATION_POINT=ST_Transform(ST_SetSRID(ST_MakePoint("+stop.getLongitude()+", "+stop.getLatitude()+"), 4326),900913) WHERE STOP_NAME='"+stop.getOldBusStop()+"'";
		logger.info("Adding the bus stop data to the database busstop table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Bus stop add successful.");
			return true;
		} else {
			logger.error("Bus stop add failed");
			return false;
		}
	}
	
	
	//this function delete particular bustop
	public boolean deleteBusStop(String stopName){
		logger.info("Starting delete route.");

		String sql = "DELETE FROM BUSSTOP WHERE STOP_NAME='" + stopName + "'";
		logger.info("Deleting the route data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Busstop delete successful.");
			return true;
		} else {
			logger.error("Busstop delete failed");
			return false;
		}
	}
	
	//How to get all the routeways. not possible to get all as separate route object if get all so fist 
	//get the route names and then for each route name get routeway object.
	
	//This function return all the available routeNames only.
	public ArrayList<String> getRouteNames() {
		logger.info("Getting all route name list from the database.");
		String sql = "SELECT ROUTE_NAME FROM ROUTE";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<String>>() {

			@Override
			public ArrayList<String> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<String> list = new ArrayList<>();
				while (result.next()) {
					list.add(result.getString(1));
				}
				statement.close();
				return list;
			}
		});
	}
	
	//This function get list of all long lat of given route/ routeWay data.
	public Route getRouteWayData(String routeName){
		logger.info("Getting all route way list from the database.");
		String sql = "select  (ST_DumpPoints(route_way)).path[1] AS path, st_x(st_transform(st_setsrid(((ST_DumpPoints(route_way)).geom),900913),4326)) as lng, st_y(st_transform(st_setsrid(((ST_DumpPoints(route_way)).geom),900913),4326)) as lat from route where route_name='"+routeName+"';";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Route>() {

			@Override
			public Route doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<WayNode> list = new ArrayList<>();
				while (result.next()) {
					WayNode waynode = new WayNode();
					waynode.setNode(result.getInt(1));
					waynode.setLongitude(result.getFloat(2));
					waynode.setLatitude(result.getFloat(3));
					list.add(waynode);
				}
				//statement.close();
				Route route = new Route();
				route.setName(routeName);
				route.setRouteway(list);
				return route;
			}
		});
	}
	
	
	//This function gets routeway available route name.
	public ArrayList<String> getWayAvailableRoutes(){
		logger.info("Getting all route way list from the database with route way available.");
		String sql = "SELECT ROUTE_NAME FROM ROUTE WHERE ROUTE_WAY IS NOT NULL";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<String>>() {

			@Override
			public ArrayList<String> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<String> list = new ArrayList<>();
				while (result.next()) {
					list.add(result.getString(1));
				}
				logger.info("Returning the list of routeway available route names: {} rows",list.size());
				return list;
			}
		});
	}
	
	
	//This function gets routeway un available route name.
	public ArrayList<String> getWayUnAvailableRoutes(){
		logger.info("Getting all route way list from the database with route way not available.");
		String sql = "SELECT ROUTE_NAME FROM ROUTE WHERE ROUTE_WAY IS NULL";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<String>>() {

			@Override
			public ArrayList<String> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<String> list = new ArrayList<>();
				while (result.next()) {
					list.add(result.getString(1));
				}
				logger.info("Returning the list of routeway not available route names: {} rows", list.size());
				return list;
			}
		});
	}
	
	//This function add and/or update the route way to the database.
	public boolean addRouteWay(Route route){
		logger.info("Starting add/updating route way.");
		
		ArrayList<String> points = new ArrayList<>();
		logger.info("Making the line string as collection of each node.");
		//creating the array sql string of line string 
		for (WayNode node : route.getRouteway()){
			String singleNode = "ST_Transform(ST_SetSRID(ST_MakePoint("+node.getLongitude()+", "+node.getLatitude()+"), 4326),900913)";
			logger.info(singleNode);
			points.add(singleNode);
		}
		/*for(int i=0; i<route.getRouteway().size();i++){
			Point point = new Point();
			point.setX(route.getRouteway().get(i).getLongitude());
			point.setY(route.getRouteway().get(i).getLatitude());
			point.setSrid(4326);
			arr.add(point);
		}*/
		String sql = "UPDATE ROUTE SET route_way=ST_Transform(ST_MakeLine(ARRAY"+points+"),900913) WHERE route_name='"+route.getName()+"'";
		logger.info("Adding the bus stop data to the database busstop table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("routeway add/update successful.");
			return true;
		} else {
			logger.error("routeway add/update  failed");
			return false;
		}
	}
	
	//this function delete the route way.
	public boolean deleteRouteWay(String routeName){
		logger.info("Deleting route way data from the database route table. Name: {}", routeName);
		String sql = "UPDATE ROUTE SET route_way=NULL WHERE route_name='"+routeName+"'";
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("routeway delete successful.");
			return true;
		} else {
			logger.error("routeway delete  failed");
			return false;
		}
	}
	
	
	//This function gets the stop id from of the bus stop from stop name.
	public Long getBusStopId(String stopName){
		logger.info("Getting bus stop id from the database for {}",stopName);
		String sql = "SELECT stop_id FROM BUSSTOP WHERE stop_name='"+stopName+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Long>() {

			@Override
			public Long doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				if (result.next()) {
					long id = result.getLong(1);
					//statement.close();
					logger.info("Id found : {}",id);
					return id;
				}
				else{
					logger.info("Failed: Can not find the id.");
					//statement.close();
					return null;
				}
			}
		});
	}
	
	
	//This function gets the stop name from of the bus stop from stop id.
	public String getBusStopName(long stop_id){
		logger.info("Getting bus stop id from the database for {}",stop_id);
		String sql = "SELECT stop_name FROM BUSSTOP WHERE stop_id='"+stop_id+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				if (result.next()) {
					String name = result.getString(1);
					//statement.close();
					logger.info("Name found : {}",name);
					return name;
				}
				else{
					logger.info("Failed: Can not find the name.");
					//statement.close();
					return null;
				}
			}
		});
	}
	
	//this function gets the route id from the route name.
	public long getRouteId(String routeName){
		logger.info("Getting route id from the database for {}",routeName);
		String sql = "SELECT route_id FROM ROUTE WHERE route_name='"+routeName+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Long>() {

			@Override
			public Long doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				if (result.next()) {
					long id = result.getLong(1);
					statement.close();
					logger.info("Id found : {}",id);
					return id;
				}
				else{
					logger.info("Failed: Can not find the id.");
					//statement.close();
					return null;
				}
			}
		});
	}
	
	//This function add the route bus stop distance.
	public boolean addRouteStopsDistance(long stop_id, long route_id, int distance){
		String sql = "INSERT INTO DISTANCE(distance, stop_id, route_id) VALUES('"+distance+"','"+stop_id+"','"+route_id+"')";
		logger.info("Adding the route's bus stop distance to the database busstop table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("route stops distance add successful.");
			return true;
		} else {
			logger.error("route stops distance add  failed");
			return false;
		}
	}
	
	//this function gets all the route bus stop distance for particular route.
	public Route getRouteStopsDistance(long routeId){
		logger.info("Getting route stops distance from the database for {}",routeId);
		String sql = "SELECT distance, stop_id FROM DISTANCE WHERE route_id='"+routeId+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Route>() {

			@Override
			public Route doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				Route route = new Route();
				ArrayList<Integer> distances = new ArrayList<>();
				ArrayList<Long> stops = new ArrayList<>();
				while (result.next()) {
					distances.add(result.getInt(1));
					stops.add(result.getLong(2));
				}
				logger.info("Got distance count: {}, and Stops count: {}",distances.size(),stops.size());
				route.setStopDistance(distances);
				route.setStopIds(stops);
				return route;
			}
		});
	}
	
	//This function return the sum of the distance of route stops.
	//this is to check that if the stops distance is set or not if set distance sum!=0.
	public int getRouteStopsDistanceSum(){
		logger.info("Getting route stops distance sum from the database");
		String sql = "SELECT SUM(distance) FROM DISTANCE";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Integer>() {

			@Override
			public Integer doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				int total = 0;
				if (result.next()) {
					total = result.getInt(1);
				}
				return total;
			}
		});
	}
	
	//This function update the route stops distance.
	//for delete set value zero.
	public boolean updateRouteStopsDistance(long routeId, long stopId, int distance){
		String sql = "UPDATE DISTANCE SET distance='"+distance+"' WHERE stop_id='"+stopId+"' AND route_id='"+routeId+"'";
		logger.info("Updating the route's bus stop distance to the database busstop table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("route stops distance delete/update successful.");
			return true;
		} else {
			logger.error("route stops distance delete/update  failed");
			return false;
		}
	}
}
