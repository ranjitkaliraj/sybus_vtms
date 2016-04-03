package com.sybus.web.controller;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonView;
import com.sybus.web.controller.jsonview.Views;
import com.sybus.web.database.domain.Vehicle;
import com.sybus.web.model.BusStopModel;
import com.sybus.web.model.FareModel;
import com.sybus.web.model.PassengerModel;
import com.sybus.web.model.RouteModel;
import com.sybus.web.model.RouteWayModel;
import com.sybus.web.model.ScheduleModel;
import com.sybus.web.model.StopDistanceModel;
import com.sybus.web.model.VehicleDetailModel;
import com.sybus.web.model.VehicleModel;
import com.sybus.web.model.VehicleResult;
import com.sybus.web.service.BusStopService;
import com.sybus.web.service.FareService;
import com.sybus.web.service.ReportService;
import com.sybus.web.service.RouteService;
import com.sybus.web.service.ScheduleService;
import com.sybus.web.service.UserService;
import com.sybus.web.service.VehicleService;

@Controller
public class BaseController {
	private ApplicationContext context;
	private final static org.slf4j.Logger logger = LoggerFactory.getLogger(BaseController.class);

	@RequestMapping("/")
	public ModelAndView displayLogin(HttpSession session,
			@CookieValue(value = "sybus_user_cookie", required = false) String cookie) {

		logger.info("Displaying the login page.");
		String sessionUser = (String) session.getAttribute("user");

		/*
		 * Cookie cookie = null; logger.info(
		 * "Checking if cookie is present. is so getting it."); for (Cookie c :
		 * request.getCookies()) { if (c.getName() == "sybus_user_cookie") {
		 * cookie = c; logger.info("Cookie found : {}",c.getName()); } else{
		 * logger.info("No Cookie found."); } }
		 */
		if ((sessionUser == null || sessionUser == "") && cookie == null) {
			logger.info("Session is doesnot exist and cookie is not set as well. Redirecting to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else if (cookie != null) {
			logger.info("Cookie is not null. Getting the user id for this cookie :{}", cookie);

			context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
			UserService userService = (UserService) context.getBean("userService");

			// now starting a new session.

			String sessionId = userService.getSessionId(cookie);
			session.setAttribute("user", sessionId);
			logger.info("Session started. Session id: {}", sessionId);

			ModelAndView model = new ModelAndView("home");
			return model;

		} else {
			logger.info("Session is still exist. Redirecting to homepage : ,{}", sessionUser);
			ModelAndView model = new ModelAndView("home");
			return model;
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView LoginCheck(@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("checkbox") String remember, HttpSession session, HttpServletResponse response) {
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		UserService userService = (UserService) context.getBean("userService");

		// checking the username and password.
		logger.info("Performing Login check.");
		boolean loginCheck = userService.checkUserLogin(username, password);
		if (loginCheck == true) {
			// setting cookies if remember is checked.
			// remember value on when not checked and remember-me,on when
			// checked. include both hidden and non-hidden value. so, logic is
			// is string length is greater that 3 then remember is checked.
			if (remember.length() > 3) {
				logger.info("Remember me checked. Starting database session.");

				Cookie cookie = new Cookie("sybus_user_cookie", username);
				cookie.setMaxAge(1209600); // 2week expiry
				response.addCookie(cookie);
				logger.info("Cookie added.");

				logger.info("Adding the Session to database.");
				String sessionId = userService.startSession(username);
				session.setAttribute("user", sessionId);
				logger.info("Session started. Session id: {}", sessionId);
			} else {
				// if remember is not checked. then only setting temporary
				// session not database session.
				logger.info("Remember me not checked. Starting temporary local session. Setting the session id.:{}",
						username);
				session.setAttribute("user", username);
			}

			logger.info("Redirecting to home page.");
			ModelAndView model = new ModelAndView("home");
			return model;
		} else {
			logger.error("Returning to login page.");
			ModelAndView model = new ModelAndView("login");
			model.addObject("message", "Username/Password is invalid.");
			return model;
		}
	}

	// loggin out.
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, HttpServletResponse response) {
		// removing cookie.
		logger.info("Deleting cookie.");
		Cookie cookie = new Cookie("sybus_user_cookie", null);
		cookie.setMaxAge(0); // 0 seconds.
		response.addCookie(cookie);

		// deleting the session in database
		logger.info("deleting session from database" + (String) session.getAttribute("user"));
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		UserService userService = (UserService) context.getBean("userService");

		userService.endSession((String) session.getAttribute("user"));

		// removing session
		logger.info("Removing session.");
		session.removeAttribute("user");

		logger.info("Returning to login page.");
		ModelAndView model = new ModelAndView("login");
		return model;
	}

	@RequestMapping("/home")
	public ModelAndView displayHome(HttpSession session) {
		logger.info("Displaying main home page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to main home page.");
			ModelAndView model = new ModelAndView("home");
			return model;
		}
	}

	@RequestMapping("/management")
	public ModelAndView displayManage(HttpSession session) {
		logger.info("Displaying main manage page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to main manage page.");
			ModelAndView model = new ModelAndView("manage");
			return model;
		}
	}

	@RequestMapping("/manage-route")
	public ModelAndView displayManageRoute(HttpSession session) {
		logger.info("Displaying Manage route page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to manage route page.");
			ModelAndView model = new ModelAndView("manage_route");

			logger.info("Getting route load data to load in page from controller");
			context = new ClassPathXmlApplicationContext("ApplicationContext.xml");

			// RouteService routeService = (RouteService)
			// context.getBean("routeService");
			// BusStopService busStopService = (BusStopService)
			// context.getBean("busStopService");

			/*
			 * logger.info(
			 * "Initializing and getting manage route page loading data to add in page."
			 * );
			 * 
			 * Gson gson = new Gson(); logger.info(
			 * "INitializing GSON to convert java object into json");
			 * model.addObject("routeData",
			 * gson.toJson(routeService.getRoutes()));
			 * model.addObject("busStopData",
			 * gson.toJson(busStopService.getAllBusStops()));
			 * model.addObject("routeWayData",
			 * gson.toJson(routeService.getAllRouteWays()));
			 * model.addObject("routeStopsDistanceData",
			 * gson.toJson(routeService.getAllStopDistanceData()));
			 */
			return model;
		}
	}

	@RequestMapping("/manage-schedule")
	public ModelAndView displayManageSchedule(HttpSession session) {
		logger.info("Displaying Manage schedule page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to manage schedule page.");
			ModelAndView model = new ModelAndView("manage_schedule");
			return model;
		}
	}

	@RequestMapping("/manage-vehicle")
	public ModelAndView displayManageVehicle(HttpSession session) {
		logger.info("Displaying Manage vehicle page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to manage Vehicle page.");
			ModelAndView model = new ModelAndView("manage_vehicle");
			return model;
		}
	}

	@RequestMapping("/manage-fare")
	public ModelAndView displayManageFare(HttpSession session) {
		logger.info("Displaying Manage fare page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to manage fare page.");
			ModelAndView model = new ModelAndView("manage_fare");
			return model;
		}
	}

	@RequestMapping("/route-with-most-passenger-travelling-report")
	public ModelAndView displayReporting1(HttpSession session) {
		logger.info("Displaying Route with most passenger travelling Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Route with most passenger travelling report page.");
			ModelAndView model = new ModelAndView("reporting_1");
			return model;
		}
	}

	@RequestMapping("/route-with-most-traffic-condition-report")
	public ModelAndView displayReporting2(HttpSession session) {
		logger.info("Displaying Route with most traffic Condition Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Route with most traffic Condition Report page.");
			ModelAndView model = new ModelAndView("reporting_2");
			return model;
		}
	}

	@RequestMapping("/time-where-most-passenger-ride-bus-report")
	public ModelAndView displayReporting3(HttpSession session) {
		logger.info("Displaying Time where most passenger ride bus Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Time where most passenger ride bus Report page.");
			ModelAndView model = new ModelAndView("reporting_3");
			return model;
		}
	}

	@RequestMapping("/vehicle-schedule-fare-and-route-report")
	public ModelAndView displayReporting4(HttpSession session) {
		logger.info("Displaying Vehicle, schedule, fare and route Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Vehicle, schedule, fare and route Report page.");
			ModelAndView model = new ModelAndView("reporting_4");
			return model;
		}
	}

	@RequestMapping("/registered-passenger-details-report")
	public ModelAndView displayReporting5(HttpSession session) {
		logger.info("Displaying Registered Passenger Details Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Registered Passenger Details Report page.");
			ModelAndView model = new ModelAndView("reporting_5");
			return model;
		}
	}

	@RequestMapping("/bus-with-highest-and-lowest-travelling-time-report")
	public ModelAndView displayReporting6(HttpSession session) {
		logger.info("Displaying Bus with highest and lowest travelling time Report page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to Bus with highest and lowest travelling time Report page.");
			ModelAndView model = new ModelAndView("reporting_6");
			return model;
		}
	}

	@RequestMapping("/tracking")
	public ModelAndView displayTracking(HttpSession session) {
		logger.info("Displaying tracking page.");
		String sessionUser = (String) session.getAttribute("user");
		logger.info("Checking if session does exist or not.");
		if (sessionUser == null || sessionUser == "") {
			logger.info("Session does not exist. Redirect to login page.");
			ModelAndView model = new ModelAndView("login");
			return model;
		} else {
			logger.info("Session does exist. Redirect to tracking page.");
			ModelAndView model = new ModelAndView("tracking");
			return model;
		}
	}

	// MANAGEMENT DATA SECTION

	// ################################## MANAGE ROUTE
	// ########################################

	// Load routes
	@JsonView(Views.DisplayData.class)
	@RequestMapping(value = "/load_routes", method = RequestMethod.POST)
	public @ResponseBody ArrayList<RouteModel> loadRoutes() {
		logger.info("Loading the route data for Route tab.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		return routeService.getRoutes();
	}

	// add routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_route", method = RequestMethod.POST)
	public @ResponseBody boolean saveRoute(@JsonView(Views.AddData.class) @RequestBody RouteModel route/*
																										 */) {
		logger.info("Saving the new route via add route ajax: {}", route.getName());
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		/*
		 * RouteModel routeModel = new RouteModel();
		 * routeModel.setName(route.getName());
		 * routeModel.setAddedRouteStopNames(route.getStops()); logger.info(
		 * "sfsfdsfdsfdsf:  {}");
		 */
		return routeService.saveRouteDetails(route);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_route", method = RequestMethod.POST)
	public @ResponseBody void updateRoutes(@JsonView(Views.UpdateData.class) @RequestBody RouteModel route) {
		logger.info("Updating the route via update route ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");

		routeService.updateAllRoutes(route.getUpdateRouteData());
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_route", method = RequestMethod.POST)
	public @ResponseBody void deleteRoutes(@RequestBody ArrayList<String> routeNameList) {
		logger.info("Deleting the route via delete route ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		routeService.deleteRoutes(routeNameList);
	}

	// ###############################MANAGE BUS
	// STOPS#################################

	// Load bus stops
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/load_stops", method = RequestMethod.POST)
	public @ResponseBody ArrayList<BusStopModel> loadBusStops() {
		logger.info("Loading the bus stop data for Bus Stop tab.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		BusStopService stopService = (BusStopService) context.getBean("busStopService");
		return stopService.getAllBusStops();
	}

	// add stop
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_stop", method = RequestMethod.POST)
	public @ResponseBody boolean saveBusStop(@JsonView(Views.AddData.class) @RequestBody BusStopModel stop) {
		logger.info("Saving the new bus stop via add bus stop ajax: {}", stop.getName());
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		BusStopService stopService = (BusStopService) context.getBean("busStopService");
		return stopService.addBusStop(stop);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_stops", method = RequestMethod.POST)
	public @ResponseBody void updateBusStops(
			@JsonView(Views.UpdateData.class) @RequestBody ArrayList<BusStopModel> stopLists) {
		logger.info("Updating the bus stop details via update bus stop ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		BusStopService stopService = (BusStopService) context.getBean("busStopService");

		stopService.updateBusStopInBulk(stopLists);
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_stops", method = RequestMethod.POST)
	public @ResponseBody void deleteBusStops(@RequestBody ArrayList<String> stops) {
		logger.info("Deleting the bus stop via delete bus stop  ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		BusStopService stopService = (BusStopService) context.getBean("busStopService");
		stopService.deleteBusStops(stops);
	}

	// ############################### ROUTE WAY
	// #################################

	// Load route ways data
	@JsonView(Views.DisplayData.class)
	@RequestMapping(value = "/load_route_ways", method = RequestMethod.POST)
	public @ResponseBody RouteWayModel loadRouteWays() {
		logger.info("Loading the routeway data for Bus Stop tab.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		return routeService.getRouteWaysData();
	}

	// add new route way.
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_route_way", method = RequestMethod.POST)
	public @ResponseBody void saveRouteWay(@JsonView(Views.Public.class) @RequestBody RouteWayModel routeWay) {
		logger.info("Saving the route way via add route way ajax. route name: {}", routeWay.getName());
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		routeService.addRouteWayData(routeWay);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_route_way", method = RequestMethod.POST)
	public @ResponseBody void updateRouteWay(@JsonView(Views.Public.class) @RequestBody RouteWayModel routeWay) {
		logger.info("Updating the route way via ajax, route name: {}", routeWay.getName());
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		routeService.updateRouteWayData(routeWay);
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_route_way", method = RequestMethod.POST)
	public @ResponseBody void deleteRouteWay(@RequestBody String routeName) {
		logger.info("Deleting the route way of route: {} from ajax", routeName);
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		routeService.deleteRouteWayData(routeName);
	}

	// ############################### ROUTE STOP'S DISTANCE
	// #################################

	// Load route ways data
	@JsonView(Views.AllCollection.class)
	@RequestMapping(value = "/load_stops_distance", method = RequestMethod.POST)
	public @ResponseBody ArrayList<StopDistanceModel> loadRouteStopsDistance() {
		logger.info("Loading the route stops distance form route stops distance tab.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		return routeService.getAllStopDistanceData();
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_stops_distance", method = RequestMethod.POST)
	public @ResponseBody void updateRouteStopsDistance(
			@JsonView(Views.Public.class) @RequestBody StopDistanceModel model) {
		logger.info("Updating the route stop distance via ajax, route name: {}", model.getName());
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		routeService.updateRouteStopsDistance(model);
	}

	// ############################### SCHEDULE MANAGEMENT
	// #################################

	// Load route ways data
	@JsonView(Views.DisplayData.class)
	@RequestMapping(value = "/load_schedule_data", method = RequestMethod.POST)
	public @ResponseBody ScheduleModel loadScheduleData() {
		logger.info("Loading schedule data for Schedule management.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		ScheduleService scheduleService = (ScheduleService) context.getBean("scheduleService");

		ArrayList<ScheduleModel> schedules = scheduleService.getAllSchedules();
		ArrayList<String> routes = routeService.getRouteNames();
		ArrayList<String> vehicles = vehicleService.getVehicleNameList();

		ScheduleModel model = new ScheduleModel();
		model.setRoutes(routes);
		model.setVehicles(vehicles);
		model.setSchedules(schedules);

		return model;

	}

	// add new route way.
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_schedule_data", method = RequestMethod.POST)
	public @ResponseBody long saveScheduleData(@JsonView(Views.Public.class) @RequestBody ScheduleModel schedule) {
		logger.info("Saving new schedule data via ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ScheduleService scheduleService = (ScheduleService) context.getBean("scheduleService");
		return scheduleService.addSchedule(schedule);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_schedule_data", method = RequestMethod.POST)
	public @ResponseBody void updateScheduleData(
			@JsonView(Views.Public.class) @RequestBody ArrayList<ScheduleModel> list) {
		logger.info("Updating schedule data via ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ScheduleService scheduleService = (ScheduleService) context.getBean("scheduleService");
		scheduleService.updateScheduleInBulk(list);
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_schedule_data", method = RequestMethod.POST)
	public @ResponseBody void deleteScheduleData(@RequestBody ArrayList<Long> ids) {
		logger.info("Deleting schedule data via ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ScheduleService scheduleService = (ScheduleService) context.getBean("scheduleService");
		scheduleService.deleteSchedules(ids);
	}

	// ############################### VEHICLE MANAGEMENT
	// #################################

	// Load route ways data
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/load_vehicle_data", method = RequestMethod.POST)
	public @ResponseBody ArrayList<VehicleModel> loadVehicleData() {
		logger.info("Loading Vehicle data for Vehicle management via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		return vehicleService.getAllVehicles();
	}

	// add new route way.
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_vehicle_data", method = RequestMethod.POST)
	public @ResponseBody void saveVehicleData(@JsonView(Views.Public.class) @RequestBody String vehicle) {
		logger.info("Saving new vehicle data via ajax. vehicle name: {}", vehicle);
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		vehicleService.addVehicle(vehicle);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_vehicle_data", method = RequestMethod.POST)
	public @ResponseBody void updateVehicleData(
			@JsonView(Views.Public.class) @RequestBody ArrayList<VehicleModel> vehicles) {
		logger.info("Updating vehicle data via ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		vehicleService.updateVehicleInBulk(vehicles);
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_vehicle_data", method = RequestMethod.POST)
	public @ResponseBody void deleteVehicleData(@RequestBody ArrayList<String> vehicles) {
		logger.info("Deleting vehicle data from ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		vehicleService.deleteVehicles(vehicles);
	}

	// ############################### FARE MANAGEMENT
	// #################################

	// Load route ways data
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/load_fare_data", method = RequestMethod.POST)
	public @ResponseBody ArrayList<FareModel> loadFareData() {
		logger.info("Loading Fare data for fare management via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		FareService fareService = (FareService) context.getBean("fareService");
		return fareService.getAllFares();
	}

	// add new route way.
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/save_fare_data", method = RequestMethod.POST)
	public @ResponseBody void saveFareData(@JsonView(Views.Public.class) @RequestBody FareModel fare) {
		logger.info("Saving new fare data via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		FareService fareService = (FareService) context.getBean("fareService");
		fareService.addFare(fare);
	}

	// update routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/update_fare_data", method = RequestMethod.POST)
	public @ResponseBody void updateFareData(
			@JsonView(Views.UpdateData.class) @RequestBody ArrayList<FareModel> fares) {
		logger.info("Updating Fare data via ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		FareService fareService = (FareService) context.getBean("fareService");
		fareService.updateFareInBulk(fares);
	}

	// delete routes
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/delete_fare_data", method = RequestMethod.POST)
	public @ResponseBody void deleteFareData(
			@JsonView(Views.UpdateData.class) @RequestBody ArrayList<FareModel> fares) {
		logger.info("Deleting Fare data from ajax");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		FareService fareService = (FareService) context.getBean("fareService");
		fareService.deleteFares(fares);
	}

	// ############################### VEHICLE TRACKING
	// #################################
	// Load route ways data
	@JsonView(Views.Tracking.class)
	@RequestMapping(value = "/load_tracking_routes", method = RequestMethod.POST)
	public @ResponseBody ArrayList<RouteModel> loadTrackingRoutes() {
		logger.info("Loading all the available routes detail for tracking via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		RouteService routeService = (RouteService) context.getBean("routeService");
		return routeService.getRoutesForTracking();
	}

	
	//This function loads the active and flagged vehicle list for tracking.
	@JsonView(Views.Location.class)
	@RequestMapping(value = "/getVehicles", method = RequestMethod.POST)
	public @ResponseBody VehicleResult loadTrackingRoutes(@RequestBody String routeName) {
		logger.info("Loading all the available vehicle detail for tracking via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ScheduleService scheduleService = (ScheduleService) context.getBean("scheduleService");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");

		//Getting active vehicle list.
		ArrayList<VehicleModel> activeVehicle = vehicleService.getActiveVehicles(routeName);
		ArrayList<VehicleModel> flaggedVehicles = vehicleService.getFlaggedVehicles(routeName);
		
		ArrayList<VehicleModel> resultActiveVehicle = new ArrayList<>();
		ArrayList<VehicleModel> resultFlaggedVehicles = new ArrayList<>();
		
		//Now, adding other vehicle info e.g. ETA etc. for active vehicles
		for(VehicleModel vehicle : activeVehicle){
			logger.info("Making active vehicle data ready : {}, {}", vehicle.getLongitude(), vehicle.getLatitude());
			VehicleModel v = vehicleService.getVehicleDetails(vehicle.getName(), routeName, vehicle.getLongitude(), vehicle.getLatitude());
			String schedule = scheduleService.getSchedule(vehicle.getScheduleID());
			v.setSchedule(schedule);
			//vehicle.setEta(v.getEta());
			//vehicle.setCurrent_location(v.getRoadName());
			//vehicle.setNextStop(v.getNextStop());
			//vehicle.setName(v.getName());
			//vehicle.setLongitude(v.getLongitude());
			//vehicle.setLatitude(v.getLatitude());
			logger.info("{}", v.toString());
			resultActiveVehicle.add(v);
		}
		
		//Now, adding other vehicle info e.g. ETA etc. for flagged vehicles
		for(VehicleModel vehicle : flaggedVehicles){
			logger.info("Making flagged vehicle data ready");
			VehicleModel v = vehicleService.getVehicleDetails(vehicle.getName(), routeName, vehicle.getLongitude(), vehicle.getLatitude());
			String schedule = scheduleService.getSchedule(vehicle.getScheduleID());
			v.setSchedule(schedule);
			//v.setEta(v.getEta());
			//v.setCurrent_location(v.getRoadName());VehicleModel
			//v.setNextStop(v.getNextStop());
			//vehicle.setName(v.getName());
			//vehicle.setLongitude(v.getLongitude());
			//vehicle.setLatitude(v.getLatitude());
			logger.info("{}", v.toString());
			resultFlaggedVehicles.add(v);
		}
		logger.info("Active vehicle count: {}",resultActiveVehicle.size());
		logger.info("flagged vehicle count: {}",resultFlaggedVehicles.size());
		VehicleResult m = new VehicleResult();
		m.setActiveVehicles(resultActiveVehicle);
		m.setFlaggedVehicles(resultFlaggedVehicles);
		
		return m;		
	}
	
	
	//This function flag particular vehicle
	@JsonView(Views.Tracking.class)
	@RequestMapping(value = "/flag_vehicle", method = RequestMethod.POST)
	public @ResponseBody boolean flagVehicle(@RequestBody String vehicleName) {
		logger.info("Starting vehicle flag from tracking via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		return vehicleService.flagVehicle(vehicleName);		
	}
	
	
	//This function flag particular vehicle
	@JsonView(Views.Tracking.class)
	@RequestMapping(value = "/unflag_vehicle", method = RequestMethod.POST)
	public @ResponseBody boolean unflagVehicle(@RequestBody String vehicleName) {
		logger.info("Starting vehicle unflag from tracking via ajax.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		VehicleService vehicleService = (VehicleService) context.getBean("vehicleService");
		return vehicleService.unFlagVehicle(vehicleName);		
	}
	
	
	
	//###################################################################################
	/*
	 * Reporting section
	 * 
	 */
	
	//This function get passenger data for report
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/passenger_report", method = RequestMethod.GET)
	public @ResponseBody ArrayList<PassengerModel> getPassengerReport() {
		logger.info("Getting passenger details.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ReportService reportService = (ReportService) context.getBean("reportService");
		return reportService.getPassengerDetails();		
	}
	
	
	//This function get passenger data for report
	@JsonView(Views.DisplayData.class)
	@RequestMapping(value = "/vehicle_details_report", method = RequestMethod.GET)
	public @ResponseBody VehicleDetailModel getVehicleDetailsReport() {
		logger.info("Getting vehicle, route, schedule and fare details.");
		context = new ClassPathXmlApplicationContext("ApplicationContext.xml");
		ReportService reportService = (ReportService) context.getBean("reportService");
		return reportService.getVehicleDetails();		
	}
	
}
