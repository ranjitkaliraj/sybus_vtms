package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.Passenger;
import com.sybus.web.database.domain.Route;

public class PassengerDao {
	private JdbcTemplate jdbcTemplate;

	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(PassengerDao.class);

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	//This function gets all the passenger details.
	// this function gets list of all available route list.
	public ArrayList<Passenger> getPassengers() {
		logger.info("Getting all the passenger details.");
		String sql = "SELECT INITCAP(LOWER(f_name))||' '||INITCAP(LOWER(f_name)), email_address FROM users";
		return jdbcTemplate.execute(sql, new PreparedStatementCallback<ArrayList<Passenger>>() {

			@Override
			public ArrayList<Passenger> doInPreparedStatement(PreparedStatement statement)
					throws SQLException, DataAccessException {
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				ArrayList<Passenger> list = new ArrayList<>();
				while (result.next()) {
					Passenger p = new Passenger();
					p.setName(result.getString(1));
					p.setEmail(result.getString(2));
					list.add(p);
				}
				statement.close();
				return list;
			}
		});
	}
}
