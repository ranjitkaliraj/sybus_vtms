package com.sybus.web.service;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

import sun.misc.BASE64Encoder;

import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sybus.web.database.dao.UserDao;
import com.sybus.web.database.domain.User;

public class UserService {
	//private ApplicationContext context;
	private UserDao userDao;
	private User user;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(UserService.class);
	
	public UserService(UserDao userDao){
		//context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		//userDao = (UserDao) context.getBean("userdao");
		this.userDao = userDao;
	}
	
	
	//this function checks the user credential
	public boolean checkUserLogin(String username, String password){
		Random random = new SecureRandom();
		logger.info("Hashing the password.");
		String passwordHash = hashUserPassword(password);
		
		user = new User();
		
		user.setUsername(username);
		user.setPassword(passwordHash);
		
		//Checking in the database.
		logger.info("Calling to database layer validateUser() function");
		return userDao.validateUser(user);
	}
	
	
	//This function 
	//this function hash the password.
    private String hashUserPassword(String password) {
    	logger.info("Creating password hash.");
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            
            digest.update(password.getBytes());
            BASE64Encoder encoder = new BASE64Encoder();
            byte hashedBytes[] = (new String(digest.digest(), "UTF-8")).getBytes();
            
            logger.info("Hashed password:{}",encoder.encode(hashedBytes));
            
            return encoder.encode(hashedBytes);
        } 
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 Error.", e);
		} 
        catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Encoding Error.", e);
        }
    }
    
    
    //This function start the new session and return the session id.
    public String startSession(String username){
        // getting 32 byte random number
        SecureRandom generator = new SecureRandom();
        byte randomBytes[] = new byte[32];
        generator.nextBytes(randomBytes);

        @SuppressWarnings("restriction")
		BASE64Encoder encoder = new BASE64Encoder();

        logger.info("Generating session id.");
        @SuppressWarnings("restriction")
		String sessionId = encoder.encode(randomBytes);
        
        user.setUsername(username);
        user.setSessionId(sessionId);
        
        if(userDao.addSession(user)==true){
        	return sessionId;
        }
        else{
        	return null;
        }
    }
    
    //This function get the session id.
    public String getSessionId(String username){
    	logger.info("Getting the session id.");
    	return userDao.getSession(username);
    }
    
    //This function delete the session.
    public boolean endSession(String sessionId){
    	logger.info("Deleting session");
    	int status = userDao.deleteSession(sessionId);
    	if(status==1){
    		return true;
    	}
    	else{
    		return false;
    	}
    }
}
