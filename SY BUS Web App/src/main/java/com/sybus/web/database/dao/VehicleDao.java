package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.Vehicle;

public class VehicleDao {
	private JdbcTemplate jdbcTemplate;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(VehicleDao.class);

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	
	// this function gets list of all available active Vehicle list.
		public ArrayList<String> getVehicleData() {
			logger.info("Getting all Vehicle name list from the database.");
			String sql = "SELECT vehicle_name FROM Vehicle";
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
		
		
	//This function the Vehicle data to the database.
	public boolean saveVehicleData(String name){
		logger.info("Starting add Vehicle.");

		String sql = "INSERT INTO Vehicle(vehicle_name) VALUES('" + name + "')";
		logger.info("Adding the Vehicle data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Vehicle add successful.");
			return true;
		} else {
			logger.error("Vehicle add failed");
			return false;
		}
	}
	
	
	//This function update the Vehicle data to the database.
	public boolean updateVehicleData(String oldName, String newName){
		logger.info("Starting update Vehicle.");

		String sql = "UPDATE Vehicle SET vehicle_name='"+ newName +"' WHERE vehicle_name='" + oldName + "'";
		logger.info("updating the Vehicle data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Vehicle update successful.");
			return true;
		} else {
			logger.error("Vehicle update failed");
			return false;
		}
	}
	
	//this function delete Vehicle data from the database
	public boolean deleteVehicleData(String name){
		logger.info("Starting delete route.");

		String sql = "DELETE FROM Vehicle WHERE vehicle_name='" + name + "'";
		logger.info("Deleting the Vehicle data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Vehicle delete successful.");
			return true;
		} else {
			logger.error("Vehicle delete failed");
			return false;
		}
	}
	
	
	// this function gets list of all available active Vehicle list.
	public ArrayList<Vehicle> getActiveVehicles(String routeName) {
		logger.info("Getting all Vehicle list from the database.");
		String sql = "SELECT x.schedule_id, y.vehicle_id, ST_X(ST_Transform(x.location_point, 4326)), ST_Y(ST_Transform(x.location_point, 4326)) FROM vehiclesession As x, schedule As y WHERE x.schedule_id = y.schedule_id AND x.flag_status=false AND y.route_id = (SELECT route_id FROM route WHERE route_name='"+routeName+"')";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Vehicle>>() {

			@Override
			public ArrayList<Vehicle> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Vehicle> list = new ArrayList<>();
				while (result.next()) {					
					Vehicle vehicle = new Vehicle();
					vehicle.setScheduleID(result.getLong(1));
					vehicle.setVehicelID(result.getLong(2));
					vehicle.setLatitude(result.getFloat(4));
					vehicle.setLongitude(result.getFloat(3));
					list.add(vehicle);
				}
				statement.close();
				return list;
			}
		});
	}
	

	//this function gets the all the flagged vehicle list.
	public ArrayList<Vehicle> getFlaggedVehicles(String routeName ){
		logger.info("Getting all Vehicle list from the database.");
		String sql = "SELECT x.schedule_id, y.vehicle_id, ST_X(ST_Transform(x.location_point, 4326)), ST_Y(ST_Transform(x.location_point, 4326)) FROM vehiclesession As x, schedule As y WHERE x.schedule_id = y.schedule_id AND x.flag_status=true AND y.route_id = (SELECT route_id FROM route WHERE route_name='"+routeName+"')";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Vehicle>>() {

			@Override
			public ArrayList<Vehicle> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Vehicle> list = new ArrayList<>();
				while (result.next()) {					
					Vehicle vehicle = new Vehicle();
					vehicle.setScheduleID(result.getLong(1));
					vehicle.setVehicelID(result.getLong(2));
					vehicle.setLatitude(result.getFloat(4));
					vehicle.setLongitude(result.getFloat(3));
					list.add(vehicle);
				}
				statement.close();
				return list;
			}
		});
	}
	
	//This function gets the vehicle name from the vehicle id.
	public String getVehicleName(long id){
		logger.info("Getting the vehicle name.");
		String sql = "SELECT vehicle_name FROM Vehicle WHERE vehicle_id="+id+"";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				String name = "";
				if (result.next()) {
					name = result.getString(1);
				}
				statement.close();
				return name;
			}
		});
	}
	
	
	//This function gets the current road name of the vehicle.
	@Deprecated
	public String getCurrentRoadName(float vehicleLat, float vehicellng){
		String sql ="select st_distance(st_closestpoint(st_astext(roadline)::geometry, st_astext(st_transform(ST_SetSRID(ST_MakePoint("+vehicellng+", "+vehicleLat+"),4326),900913)))::geography, ST_SetSRID(ST_MakePoint("+vehicellng+", "+vehicleLat+"),4326)) as x, road_name from routeroad order by x asc";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				String name = "";
				if (result.next()) {
					name = result.getString(2);
				}
				statement.close();
				return name;
			}
		});
	}
	
	
	//This function gets the next bus stop name and distance in Km of the particular vehicle for particular route.
	@Deprecated
	public HashMap<String, String> findNextStop(float lat, float lng, String routeName){
		String sql ="SELECT (SELECT st_length(st_transform(st_line_substring(route_way, st_line_locate_point(route_way, st_transform(st_setsrid(st_point("+lng+", "+lat+"),4326),900913)),  st_line_locate_point(route_way, location_point)),4326)::geography)  FROM route WHERE route_name='"+routeName+"') as length, stop_name FROM busstop WHERE stop_name = ANY(string_to_array((SELECT bus_stops FROM route WHERE route_name='"+routeName+"'), ',')) AND st_within(location_point, (SELECT st_addpoint((SELECT st_line_substring(route_way, st_line_locate_point(route_way, st_transform(st_setsrid(st_point("+lng+", "+lat+"),4326),900913)),  st_line_locate_point(route_way,st_endpoint(route_way))) FROM route WHERE route_name='"+routeName+"'), st_makepoint(1,1)))) IS TRUE ORDER BY length ASC LIMIT 1;";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<HashMap<String, String>>() {

			@Override
			public HashMap<String, String> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				HashMap<String, String> nextStop = new HashMap<>();
				
				if (result.next()) {
					DecimalFormat df = new DecimalFormat("###.##");
					nextStop.put("distance", df.format(result.getDouble(1)/1000).toString());
					nextStop.put("name", result.getString(2));
				}
				statement.close();
				return nextStop;
			}
		});
	}
	
	
	//Getting nearest bus stop of particular vehicle.
	public String getVehicleNexttBusStop(float lat, float lng, String routeName){
		logger.info("Getting vehicle next busstop.");
		String sql ="WITH "
				+ "temp_route_way As (SELECT st_addpoint((SELECT st_line_substring(route_way, st_line_locate_point(route_way, st_Transform(st_setSRID(st_makepoint("+lng+", "+lat+"),4326), 900913)), st_line_locate_point(route_way,st_endpoint(route_way)))  FROM route WHERE route_name='"+routeName+"'), st_makepoint(1,1)) As way)"
				+ "SELECT (SELECT ST_Length(st_transform(st_line_substring(route_way, st_line_locate_point(route_way,st_Transform(st_setSRID(st_makepoint("+lng+", "+lat+"),4326), 900913)), st_line_locate_point(route_way, location_point)),4326)::geography)  from route where route_name='Route 1') as length,stop_name from busstop WHERE stop_name = ANY(string_to_array((SELECT bus_stops FROM route WHERE route_name='Route 1'), ',')) AND st_dwithin((st_transform(location_point, 4326))::Geography, (ST_Transform(ST_ClosestPoint((SELECT way FROM temp_route_way), location_point), 4326))::Geography, 20) IS TRUE ORDER BY length ASC LIMIT 1";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				String name = "";
				if (result.next()) {
					logger.info("result found, now returnning.");
					name = result.getString(2);
				}
				statement.close();
				return name;
			}
		});
	}
	
	
	//This function gets the ETA to next stop for the current bus.
	// This function gets vehicle ETA, current road name.
	//if ETA is null, then location history data is not present.
		public String[] getVehicleETA(String routeName, String vehicleName, String nextBusStop) {
			logger.info("Getting ETA and current road name for vehicle : {}", vehicleName);
			String sql = "WITH " 
					+ "/*User input data*/" 
					+ "temp_routeName As (SELECT '"+routeName+"'::text As name),"
					+ "temp_vehicleName As (SELECT '"+vehicleName+"'::text As name),"
					+ "temp_stopName As (SELECT '"+nextBusStop+"'::text As name),"
					+ "time_range As (SELECT 5::integer As time)," 
					+"/* Getting schedule for provided vehicle and route*/"
					+ "temp_scheduleId As (SELECT schedule_id FROM schedule WHERE route_id=(SELECT route_id FROM route WHERE route_name=(SELECT name FROM temp_routeName)) AND vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name=(SELECT name FROM temp_vehicleName))),"
					+ "/*Getting user specified rows (5 mins i.e. 5*4 20 rows since vehicle is updated every 15 secs. so 1 min = 4 row) of vehicle history*/"
					+ "temp_locationHistory As (SELECT location, time FROM locationhistory WHERE session_id=(SELECT session_id FROM vehiclesession WHERE schedule_id=(SELECT * FROM temp_scheduleId)) ORDER BY time DESC LIMIT ((SELECT * FROM time_range)*4 /*One minute contain 4 row*/)),"
					+ "/*Getting last and 20th last or first points*/"
					+ "temp_firstPoint As (SELECT location FROM temp_locationHistory ORDER BY TIME ASC LIMIT 1),"
					+ "temp_lastPoint As (SELECT location FROM temp_locationHistory ORDER BY TIME DESC LIMIT 1),"
					+ "/*Getting a linestring between user bus stop and vehicle location*/"
					+ "temp_vehicle_user_way As (SELECT st_line_substring(route_way, st_line_locate_point(route_way, (SELECT location_point FROM vehiclesession WHERE schedule_id = (SELECT * FROM temp_scheduleId))), st_line_locate_point(route_way, (SELECT location_point FROM busstop WHERE stop_name=(SELECT name FROM temp_stopName)))) FROM route WHERE route_name=(SELECT name FROM temp_routeName)),"
					+ "/*Calculating total no. of bus stops between above line string*/"
					+ "temp_bus_stop_count As (SELECT COUNT(*) FROM busstop WHERE stop_name = ANY(string_to_array((SELECT bus_stops FROM route WHERE route_name= (SELECT name FROM temp_routeName)), ',')) AND st_dwithin((st_transform(location_point, 4326))::Geography, (ST_Transform(ST_ClosestPoint((SELECT * FROM temp_vehicle_user_way), location_point), 4326))::Geography, 20)),"
					+ "/* Calculating vehicle to user busstop distance*/"
					+ "user_stop_to_vehicle_distance As (SELECT ST_Length((ST_Transform( /*Substring between vehicle location and user bus stop.*/  (SELECT * FROM temp_vehicle_user_way)   ,4326))::Geography)),"
					+ "/*Calculating speed, note that, average 1.5 min time waste has been added on each bus stop. Speed = Distance / Time */"
					+ "/*Calculating the substring from route way and finding its length and then finding the speed by dividing 5 mins  i.e. location history range 20 row*/"
					+ "past_vehicle_speed As (SELECT ((ST_Length(ST_line_substring(route_way, ST_line_locate_point(route_way, (SELECT * FROM temp_firstPoint)), ST_line_locate_point(route_way, (SELECT * FROM temp_lastPoint)))))/(( (SELECT * FROM time_range) + (SELECT COUNT(*)*1.5 /*Adding 1.5 min extra as bus stop time waste on each bus stop*/  FROM temp_bus_stop_count) )/60::float  /*Dividing by 60 to convert 5 mins() to hour*/))/1000 /* Divided by 1000 to convert from meter to km.*/ FROM route WHERE route_name=(SELECT * FROM temp_routeName))"
					+ "/*Calculating Time from vehicle to bus stop and current road name of vehicle.  Time = Distance/Speed */"
					+ "SELECT ROUND((((SELECT * FROM user_stop_to_vehicle_distance)/1000 /*Converting into km by multiplying by 1000*/)/(SELECT * FROM past_vehicle_speed))*60) /* Converting into minute from hour */ As ETA, roadName, (SELECT * FROM temp_bus_stop_count) As stops_between FROM (SELECT name As roadName FROM routeRoad WHERE ST_Dwithin(ST_Transform(roadline, 4326)::Geography, ST_Transform(ST_ClosestPoint((SELECT route_way FROM ROUTE WHERE route_name='Route 1'), (SELECT location_point FROM vehiclesession WHERE schedule_id=(SELECT * FROM temp_scheduleId))), 4326)::Geography,20) LIMIT 1) As current_vehicle_name";

			return jdbcTemplate.execute(sql, new PreparedStatementCallback<String[]>() {

				@Override
				public String[] doInPreparedStatement(PreparedStatement statement)
						throws SQLException, DataAccessException {
					logger.info("Executing the query now.");
					ResultSet result = statement.executeQuery();
					String[] data = new String[2];
					if (result.next()) {
						logger.info("ETA calculated : {}",result.getString(1));
						data[0] = result.getString(1);
						data[1] = result.getString(2);
						return data;
					}
					{
						logger.info("Error while calculating ETA.");
					}
					return data;
				}
			});
		}
		
	
		//This function flag the vehicle.
		
		//This function update the Vehicle data to the database.
		public boolean flag(String vehicleName){
			logger.info("Starting update Vehicle.");

			String sql = "UPDATE vehiclesession SET flag_status=true WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='"+vehicleName+"'))";
			logger.info("Flagging the vehicle {}.", vehicleName);
			int result = jdbcTemplate.update(sql);

			if (result == 1) {
				logger.info("Vehicle flag successful.");
				return true;
			} else {
				logger.error("Vehicle flag failed");
				return false;
			}
		}
		
		
		//This function update the Vehicle data to the database.
		public boolean unFlag(String vehicleName){
			logger.info("Starting update Vehicle.");

			String sql = "UPDATE vehiclesession SET flag_status=false WHERE schedule_id=(SELECT schedule_id FROM schedule WHERE vehicle_id=(SELECT vehicle_id FROM vehicle WHERE vehicle_name='"+vehicleName+"'))";
			logger.info("UnFlagging the vehicle {}.", vehicleName);
			int result = jdbcTemplate.update(sql);

			if (result == 1) {
				logger.info("Vehicle unflag successful.");
				return true;
			} else {
				logger.error("Vehicle unflag failed");
				return false;
			}
		}
		
}
