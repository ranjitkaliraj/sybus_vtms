package com.sybus.web.service;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;

import com.sybus.web.database.dao.ScheduleDao;
import com.sybus.web.database.domain.Schedule;
import com.sybus.web.model.ScheduleModel;

public class ScheduleService {
	private ScheduleDao scheduleDao;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(ScheduleService.class);
	
	public ScheduleService(ScheduleDao scheduleDao){
		this.scheduleDao = scheduleDao;
	}
	
	//this function gets the bus stop list of all bus stops.
	public ArrayList<ScheduleModel> getAllSchedules(){
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
	
	//this function add new schedule data.
	public long addSchedule(ScheduleModel model){
		logger.info("Starting to add Schedule details.{},  {},  {}", model.getRoute(), model.getTime(), model.getVehicle());
		Schedule schedule = new Schedule();
		schedule.setRouteID(scheduleDao.getRouteID(model.getRoute()));		//Im lazy enough to change reverse vehicle with schedule that is why wrong function here but it gives correct value. :D
		//schedule.setScheduleID(model.getScheduleID());
		schedule.setTime(model.getTime());
		schedule.setVehicleID(scheduleDao.getVehicleID(model.getVehicle()));
		
		logger.info("Now calling databse layer function to add schedule.");
		return scheduleDao.saveScheduleData(schedule);
	}
	
	
	//This function update bus stop
	private void updateSchedule(ScheduleModel model){
		logger.info("Starting to update Schedule details. {}, {}, {}, {},{}", model.getVehicle(), model.getRoute(), model.getTime(), scheduleDao.getVehicleID(model.getVehicle()), scheduleDao.getRouteID(model.getRoute()));
		Schedule schedule = new Schedule();
		schedule.setRouteID(scheduleDao.getRouteID(model.getRoute()));
		schedule.setScheduleID(model.getScheduleID());
		schedule.setTime(model.getTime());
		schedule.setVehicleID(scheduleDao.getVehicleID(model.getVehicle()));
		
		logger.info("Now calling databse layer function to update schedule.");
		scheduleDao.updateScheduleData(schedule);
	}
	
	//This function update the bus stop in bulk
	public void updateScheduleInBulk(ArrayList<ScheduleModel> list){
		logger.info("Updating {} schedules in bulk.",list.size());
		for(ScheduleModel schedule : list){
			this.updateSchedule(schedule);
		}
	}
	
	//This function delete a bus stop
	private void deleteSchedule(long scheduleId){
		logger.info("Deleteing schedule: {}",scheduleId);
		scheduleDao.deleteScheduleData(scheduleId);
	}
		
	//this function delete bus stops in bulk
	public void deleteSchedules(ArrayList<Long> schedules){
		logger.info("Deleting schedules in bulk. total stops: {}", schedules.size());
		for(long schedule : schedules){
			this.deleteSchedule(schedule);
		}
	}
	
	
	//Getting schedule for particular vehicle
	public String getSchedule(long id){
		return scheduleDao.getParticularSchedule(id);
	}
	
}
