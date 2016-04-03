package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.Fare;

public class FareDao {
	private JdbcTemplate jdbcTemplate;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(FareDao.class);

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	//This function the Fare data to the database.
	public boolean saveFareData(Fare fare){
		logger.info("Starting to add Fare.");

		String sql = "INSERT INTO FARE(amount, distance) VALUES(" + fare.getAmount() + ","+ fare.getDistance() +")";
		logger.info("Adding the Fare data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Fare add successful.");
			return true;
		} else {
			logger.error("Fare add failed");
			return false;
		}
	}
	
	
	//This function update the Fare data to the database.
	public boolean updateFareData(Fare fare){
		logger.info("Starting update Fare.");

		String sql = "UPDATE FARE SET distance="+ fare.getDistance() +", amount="+ fare.getAmount() +" WHERE distance="+ fare.getOldDistance() +" AND amount="+ fare.getOldAmount() +"";
		logger.info("updating the Fare data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Fare update successful.");
			return true;
		} else {
			logger.error("Fare update failed");
			return false;
		}
	}
	
	//this function delete Fare data from the database
	public boolean deleteFareData(Fare fare){
		logger.info("Starting delete route.");

		String sql = "DELETE FROM FARE WHERE distance="+ fare.getDistance() +" AND amount="+ fare.getAmount() +"";
		logger.info("Deleting the Fare data to the database route table.");
		int result = jdbcTemplate.update(sql);

		if (result == 1) {
			logger.info("Fare delete successful.");
			return true;
		} else {
			logger.error("Fare delete failed");
			return false;
		}
	}
	
	
	// this function gets list of all available Fare list.
	public ArrayList<Fare> getFareData() {
		logger.info("Getting all Fare list from the database.");
		String sql = "SELECT amount, distance FROM FARE";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Fare>>() {

			@Override
			public ArrayList<Fare> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Fare> list = new ArrayList<>();
				while (result.next()) {				
					Fare fare = new Fare();
					fare.setAmount(result.getFloat(1));
					fare.setDistance(result.getInt(2));
					list.add(fare);
				}
				statement.close();
				return list;
			}
		});
	}
}
