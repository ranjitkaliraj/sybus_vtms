package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.Schedule;

public class ScheduleDao {
	private JdbcTemplate jdbcTemplate;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(ScheduleDao.class);
	
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	//This function the schedule data to the database and return schedule id.
	public long saveScheduleData(Schedule schedule){
		logger.info("Starting add Schedule.");

		String sql = "INSERT INTO SCHEDULE(vehicle_id, route_id, schedule_time) VALUES(" + schedule.getVehicleID() + ","+ schedule.getRouteID() + ",TIME'"+schedule.getTime()+"')";
		logger.info("Adding the schedule data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Schedule add successful.");
			String sql1 = "SELECT SCHEDULE_ID FROM SCHEDULE WHERE VEHICLE_id="+schedule.getVehicleID()+" AND ROUTE_ID="+schedule.getRouteID()+" AND SCHEDULE_TIME='"+schedule.getTime()+"'";
			return jdbcTemplate.execute(sql1, new PreparedStatementCallback<Long>() {

				@Override
				public Long doInPreparedStatement(PreparedStatement statement)
						throws SQLException, DataAccessException {
					logger.info("Executing the query now.");
					ResultSet result = statement.executeQuery();
					long id = 0;
					if (result.next()) {
						id = result.getLong(1);
					}
					statement.close();
					return id;
				}
			});
		} else {
			logger.error("Schedule add failed");
			return -1;
		}
	}
	
	
	//This function update the schedule data to the database.
	public boolean updateScheduleData(Schedule schedule){
		logger.info("Starting update schedule.");

		String sql = "UPDATE SCHEDULE SET vehicle_id="+ schedule.getVehicleID() +", route_id=" + schedule.getRouteID() + ",schedule_time='"+schedule.getTime()+"' WHERE schedule_id=" + schedule.getScheduleID() + "";
		logger.info("updating the Schedule data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Schedule update successful.");
			return true;
		} else {
			logger.error("Schedule update failed");
			return false;
		}
	}
	
	//this function delete schedule data from the database
	public boolean deleteScheduleData(long scheduleID){
		logger.info("Starting delete route.");

		String sql = "DELETE FROM SCHEDULE WHERE schedule_ID=" + scheduleID + "";
		logger.info("Deleting the schedule data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Schedule delete successful.");
			return true;
		} else {
			logger.error("Schedule delete failed");
			return false;
		}
	}
	
	
	// this function gets list of all available schedule list.
	public ArrayList<Schedule> getScheduleData() {
		logger.info("Getting all schedule list from the database.");
		String sql = "SELECT * FROM SCHEDULE";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Schedule>>() {

			@Override
			public ArrayList<Schedule> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Schedule> list = new ArrayList<>();
				while (result.next()) {
					Schedule schedule = new Schedule();
					schedule.setScheduleID(result.getLong(1));
					schedule.setVehicleID(result.getLong(2));
					schedule.setRouteID(result.getLong(3));
					schedule.setTime(result.getString(4));
					list.add(schedule);
				}
				statement.close();
				return list;
			}
		});
	}
	
	
	//This function gets the routeName list
	//This function return all the available routeNames only.
	public ArrayList<String> getRouteNamesList() {
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
	
	//this function gets the vehicle name list.
	// this function gets list of all available Vehicle list.
	public ArrayList<String> getVehicleNameList() {
		logger.info("Getting all Vehicle list from the database.");
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
	
	
	
	//This function return all the available routeNames only.
	public String getRouteName(long route_id) {
		logger.info("Getting route name from the database.");
		String sql = "SELECT ROUTE_NAME FROM ROUTE WHERE ROUTE_ID="+route_id+"";
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
	
	//this function gets the vehicle name list.
	// this function gets list of all available Vehicle list.
	public String getVehicleName(long vehicle_id) {
		logger.info("Getting vehicle name list from the database.");
		String sql = "SELECT VEHICLE_NAME FROM VEHICLE WHERE VEHICLE_ID="+vehicle_id+"";
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
	
	
	//This function return all the available routeNames only.
	public Long getRouteID(String name) {
		logger.info("Getting route name from the database.");
		String sql = "SELECT ROUTE_ID FROM ROUTE WHERE ROUTE_NAME='"+name+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Long>() {

			@Override
			public Long doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				long id = 0;
				if (result.next()) {
					id = result.getLong(1);
				}
				statement.close();
				return id;
			}
		});
	}
	
	// this function get vehicle id.
	public Long getVehicleID(String name) {
		logger.info("Getting vehicle name list from the database.");
		String sql = "SELECT VEHICLE_ID FROM VEHICLE WHERE VEHICLE_NAME='"+name+"'";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<Long>() {

			@Override
			public Long doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				long id = 0;
				if (result.next()) {
					id = result.getLong(1);
				}
				statement.close();
				return id;
			}
		});
	}
	
	
	// this function get schedule time for particular vehicle.
	public String getParticularSchedule(long id) {
		logger.info("Getting schedule from the database.");
		String sql = "SELECT schedule_time FROM SCHEDULE WHERE schedule_id = "+id+"";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>() {

			@Override
			public String doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				String schedule = "";
				if (result.next()) {
					schedule = result.getString(1);
					logger.info("Result: {}", schedule);
				}
				statement.close();
				return schedule;
			}
		});
	}
}
