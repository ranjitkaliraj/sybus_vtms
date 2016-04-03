package com.sybus.web.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.sybus.web.database.domain.User;

public class UserDao {
	private JdbcTemplate jdbcTemplate;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(UserDao.class);

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		logger.info("Initializing constructor.");
	}

	//this function validate the login of the user. Return true if correct else false.
	public boolean validateUser(User user) {
		logger.info("Starting Validating user.");
		String query = "Select count(1) from sylogin where username = ? and password = ?";
		return jdbcTemplate.execute(query, new PreparedStatementCallback<Boolean>(){

			@Override
			public Boolean doInPreparedStatement(PreparedStatement statement) throws SQLException, DataAccessException {
				// TODO Auto-generated method stub
				statement.setString(1, user.getUsername());
				statement.setString(2, user.getPassword());
				
				boolean status = false;
				ResultSet result = statement.executeQuery();
				if(result.next()){
					if(result.getInt(1)>0){
						status = true;
						logger.info("Username and Password matched.");
					}
					else{
						status = false;
						logger.error("Username or Password do not matched.");
					}
				}
				statement.close();
				logger.info("returning the status.");
				return status;
			}
		});
	}
	
	//This function add session. upon the successful start, it return true.
	public boolean addSession(User user){
		logger.info("Starting session.");
        
		logger.info("First checking any previous session exist for this user.");
		String session_id = this.getSession(user.getUsername());
		if (session_id!=null){
			//this.deleteSessionWithUsername(user.getUsername());
			logger.info("Previous session exists. Deleting now.");
			this.deleteSession(session_id);			
		}
        String sql = "INSERT INTO SYSESSION(session_id, username) VALUES('"+user.getSessionId()+"','"+user.getUsername()+"')";
        logger.info("Adding the session id to the database session table.");
        int result = jdbcTemplate.update(sql);
        
        if(result == 1){
        	logger.info("Session creation successful.");
        	return true;
        }
        else{
        	logger.error("Session creation failed");
        	return false;
        }		
	}
	
	
    // This function delete the session by deleting it from the SySession table
    public int deleteSession(String sessionId) {
    	logger.info("Deleting the session id.");
    	 String sql = "DELETE FROM SYSESSION WHERE SESSION_ID='"+sessionId+"'";         
         int result = jdbcTemplate.update(sql);
         return result;
    }
    

    // This function retrieves the session from the SySession table
    public String getSession(String username) {
    	logger.info("Getting session from the database.");
        String sql = "SELECT SESSION_ID FROM SYSESSION WHERE USERNAME=?";
        return jdbcTemplate.execute(sql, new PreparedStatementCallback<String>(){
   
			@Override
			public String doInPreparedStatement(PreparedStatement statement) throws SQLException, DataAccessException {
				// TODO Auto-generated method stub
				statement.setString(1, username);
				
				String id = "";
				logger.info("Executing the query now.");
				ResultSet result = statement.executeQuery();
				if(result.next()){
					logger.info("Session id found.");
					id = result.getString(1);
				}
				statement.close();
				return id;
			}
		});        
    }
}
