/*
Model: SY Bus - Vehicle Tracking and Management System
Database: PostgreSQL 9.4
*/


-- Create schemas section -------------------------------------------------

--CREATE SCHEMA SY
--;

-- Create tables section -------------------------------------------------

-- Table BusStop

CREATE TABLE BusStop(
 stop_id BigSerial NOT NULL,
 stop_name Text NOT NULL,
 location_point geometry(POINT,900913) NOT NULL
)
;
COMMENT ON COLUMN BusStop.stop_id IS 'Bus stop id.'
;
COMMENT ON COLUMN BusStop.stop_name IS 'Bus stop name.'
;
COMMENT ON COLUMN BusStop.location_point IS 'Lat/long co-ordinates of location in point.'
;

-- Add keys for table BusStop

ALTER TABLE BusStop ADD CONSTRAINT stopID PRIMARY KEY (stop_id)
;

-- Table Destination

CREATE TABLE Destination(
 destination_id BigSerial NOT NULL,
 osm_id Bigint,
 destination_name Text NOT NULL,
 location_point geometry(POINT,900913) NOT NULL
)
;
COMMENT ON COLUMN Destination.destination_id IS 'Identifier of the destionation and it is auto incremental.'
;
COMMENT ON COLUMN Destination.destination_name IS 'Name of the destination.'
;
COMMENT ON COLUMN Destination.location_point IS 'Lat/long co-ordinate of location in point.'
;

-- Add keys for table Destination

ALTER TABLE Destination ADD CONSTRAINT destinationID PRIMARY KEY (destination_id)
;

-- Table Distance

CREATE TABLE Distance(
 id BigSerial NOT NULL,
 distance Integer NOT NULL,
 stop_id Bigint NOT NULL,
 route_id Bigint NOT NULL
)
;
COMMENT ON COLUMN Distance.id IS 'Auto incremental identifier.'
;
COMMENT ON COLUMN Distance.distance IS 'Distance between stops of particular route. Used to calculate fare amount.'
;

-- Add keys for table Distance

ALTER TABLE Distance ADD CONSTRAINT distanceID PRIMARY KEY (id)
;

-- Table Fare

CREATE TABLE Fare(
 fare_id Serial NOT NULL,
 amount Integer NOT NULL,
 distance Integer NOT NULL
)
;
COMMENT ON COLUMN Fare.fare_id IS 'Auto incremental number for primary key.'
;
COMMENT ON COLUMN Fare.amount IS 'Amount of the fare for particular distance.'
;
COMMENT ON COLUMN Fare.distance IS 'Distance betewen stops in form of Kilo meter.'
;

-- Add keys for table Fare

ALTER TABLE Fare ADD CONSTRAINT fareID PRIMARY KEY (fare_id)
;

-- Table Road

CREATE TABLE Road(
 road_id Bigint NOT NULL,
 name Text NOT NULL,
 roadLine geometry(LINESTRING,4326) NOT NULL
)
;
COMMENT ON COLUMN Road.road_id IS 'ID of the road.'
;
COMMENT ON COLUMN Road.name IS 'Road name.'
;
COMMENT ON COLUMN Road.roadLine IS 'Lat/long co-ordinates of the location in form of point.'
;

-- Add keys for table Road

ALTER TABLE Road ADD CONSTRAINT roadID PRIMARY KEY (road_id)
;

-- Table Route

CREATE TABLE Route(
 route_id BigSerial NOT NULL,
 route_name Varchar NOT NULL,
 bus_stops Text NOT NULL,
 route_way geometry(LINESTRING,900913)
)
;
COMMENT ON COLUMN Route.route_id IS 'Route number.'
;
COMMENT ON COLUMN Route.route_name IS 'Name of the Route.'
;
COMMENT ON COLUMN Route.bus_stops IS 'List of bus stops of the routes.'
;
COMMENT ON COLUMN Route.route_way IS 'List of Lat/long co-ordinates in form of line string of the route.'
;

-- Add keys for table Route

ALTER TABLE Route ADD CONSTRAINT routeNo PRIMARY KEY (route_id)
;

-- Table Schedule

CREATE TABLE Schedule(
 schedule_id BigSerial NOT NULL,
 vehicle_id Bigint NOT NULL,
 route_id Bigint NOT NULL,
 schedule_time Time NOT NULL
)
;
COMMENT ON COLUMN Schedule.schedule_id IS 'Auto incremental identifier of schedule.'
;
COMMENT ON COLUMN Schedule.schedule_time IS 'Schedule time for particular vehicle for particular route.'
;

-- Add keys for table Schedule

ALTER TABLE Schedule ADD CONSTRAINT scheduleID PRIMARY KEY (schedule_id)
;

-- Table SyLogin

CREATE TABLE SyLogin(
 username Varchar NOT NULL,
 password Varchar NOT NULL
)
;
COMMENT ON COLUMN SyLogin.username IS 'User name for sajha yatayat staffs.'
;
COMMENT ON COLUMN SyLogin.password IS 'password for sajha yatayat staffs.'
;

-- Add keys for table SyLogin

ALTER TABLE SyLogin ADD CONSTRAINT username PRIMARY KEY (username)
;

-- Table SySession

CREATE TABLE SySession(
 session_id Varchar NOT NULL,
 username Varchar NOT NULL
)
;
COMMENT ON COLUMN SySession.session_id IS 'Random generated number (by application).'
;

-- Add keys for table SySession

ALTER TABLE SySession ADD CONSTRAINT Key8 PRIMARY KEY (session_id)
;

-- Table Transaction

CREATE TABLE Transaction(
 transaction_id BigSerial NOT NULL,
 payment_status Boolean NOT NULL,
 amount Integer NOT NULL,
 time Date NOT NULL,
 route_id Bigint NOT NULL,
 vehicle_id Bigint NOT NULL,
 user_id Bigint NOT NULL
)
;
COMMENT ON COLUMN Transaction.transaction_id IS 'Auto increment number.'
;
COMMENT ON COLUMN Transaction.payment_status IS 'Either true or false. '
;
COMMENT ON COLUMN Transaction.amount IS 'Fare amount to be paid.'
;
COMMENT ON COLUMN Transaction.time IS 'Time of transaction. '
;

-- Add keys for table Transaction

ALTER TABLE Transaction ADD CONSTRAINT Key9 PRIMARY KEY (transaction_id)
;

-- Table Users

CREATE TABLE Users(
 user_id BigSerial NOT NULL,
 f_name Varchar NOT NULL,
 l_name Varchar NOT NULL,
 email_address Varchar NOT NULL
)
;
COMMENT ON COLUMN Users.user_id IS 'Auto generated incremental number for user id.
'
;
COMMENT ON COLUMN Users.f_name IS 'User first name'
;
COMMENT ON COLUMN Users.l_name IS 'User last name.'
;
COMMENT ON COLUMN Users.email_address IS 'User email address.'
;

-- Add keys for table Users

ALTER TABLE Users ADD CONSTRAINT userID PRIMARY KEY (user_id)
;

-- Table UserLogin

CREATE TABLE UserLogin(
 user_id Bigint NOT NULL,
 password Varchar NOT NULL
)
;
COMMENT ON COLUMN UserLogin.user_id IS 'Value is user id from user table.'
;
COMMENT ON COLUMN UserLogin.password IS 'Login password of the user.'
;

-- Add keys for table UserLogin

ALTER TABLE UserLogin ADD CONSTRAINT Key10 PRIMARY KEY (user_id)
;

-- Table UserSession

CREATE TABLE UserSession(
 session_id Varchar NOT NULL,
 username Bigint NOT NULL
)
;
COMMENT ON COLUMN UserSession.session_id IS 'Random generated session id. (By application)'
;

-- Add keys for table UserSession

ALTER TABLE UserSession ADD CONSTRAINT SessionID PRIMARY KEY (session_id)
;

-- Table Vehicle

CREATE TABLE Vehicle(
 vehicle_id BigSerial NOT NULL,
 vehicle_name Varchar NOT NULL
)
;
COMMENT ON COLUMN Vehicle.vehicle_id IS 'Number of the vehicle.'
;
COMMENT ON COLUMN Vehicle.vehicle_name IS 'Name of the vehicle'
;

-- Add keys for table Vehicle

ALTER TABLE Vehicle ADD CONSTRAINT Key11 PRIMARY KEY (vehicle_id)
;

-- Table VehicleHistory

CREATE TABLE VehicleHistory(
 id BigSerial NOT NULL,
 session_start_time Time NOT NULL,
 session_end_time Time NOT NULL,
 date Date NOT NULL,
 schedule_id Bigint NOT NULL
)
;
COMMENT ON COLUMN VehicleHistory.id IS 'Autogenerated incremantal primay key.'
;
COMMENT ON COLUMN VehicleHistory.location_point IS 'Lat/long co-ordinates of location in point format.'
;
COMMENT ON COLUMN VehicleHistory.session_start_time IS 'Start time of the vehicle session.'
;
COMMENT ON COLUMN VehicleHistory.session_end_time IS 'End time of the vehicle session.'
;
COMMENT ON COLUMN VehicleHistory.date IS 'Date of the vehicle session.'
;

-- Add keys for table VehicleHistory

ALTER TABLE VehicleHistory ADD CONSTRAINT id PRIMARY KEY (id)
;

-- Table VehicleSession

CREATE TABLE VehicleSession(
 session_id BigSerial NOT NULL,
 location_point geometry(POINT,900913) NOT NULL,
 flag_status Boolean NOT NULL,
 schedule_id Bigint NOT NULL
)
;
COMMENT ON COLUMN VehicleSession.session_id IS 'Auto incremental session identifier.'
;
COMMENT ON COLUMN VehicleSession.location_point IS 'Lat/long co-ordinate of location in form of point.'
;
COMMENT ON COLUMN VehicleSession.flag_status IS 'Flag status of particular vehicle.'
;

-- Add keys for table VehicleSession

ALTER TABLE VehicleSession ADD CONSTRAINT sessionID PRIMARY KEY (session_id)
;

-- Table RoutingPoint

CREATE TABLE RoutingPoint(
 _id BigSerial NOT NULL,
 osm_id Bigint NOT NULL,
 name Text,
 path Integer NOT NULL,
 point geometry(POINT,900913) NOT NULL,
 isjunction Boolean NOT NULL
)
;
COMMENT ON COLUMN RoutingPoint._id IS 'Auto incremental number for junction id.'
;
COMMENT ON COLUMN RoutingPoint.osm_id IS 'OSM id. imported from OSM data.'
;
COMMENT ON COLUMN RoutingPoint.name IS 'Name of point, imported from OSM data.'
;
COMMENT ON COLUMN RoutingPoint.path IS 'Sequence number of the point.'
;
COMMENT ON COLUMN RoutingPoint.point IS 'Lat/long co-ordinate of location.'
;
COMMENT ON COLUMN RoutingPoint.isjunction IS 'Is the point is junction or not. i.e. have same value as another intersect.'
;

-- Add keys for table RoutingPoint

ALTER TABLE RoutingPoint ADD CONSTRAINT junctionID PRIMARY KEY (_id)
;

-- Table RouteRoad

CREATE TABLE RouteRoad(
 road_id BigSerial NOT NULL,
 name Text NOT NULL,
 roadLine geometry(LINESTRING,4326) NOT NULL
)
;
COMMENT ON COLUMN RouteRoad.road_id IS 'Road id, primary key'
;
COMMENT ON COLUMN RouteRoad.name IS 'Name of the road.'
;
COMMENT ON COLUMN RouteRoad.roadLine IS 'Array of points/lng lat of the road.'
;

-- Add keys for table RouteRoad

ALTER TABLE RouteRoad ADD CONSTRAINT Key12 PRIMARY KEY (road_id)
;

-- Table LocationHistory

CREATE TABLE LocationHistory(
 id BigSerial NOT NULL,
 location geometry(POINT,900913) NOT NULL,
 time Time NOT NULL,
 session_id Bigint NOT NULL
)
;
COMMENT ON COLUMN LocationHistory.location IS 'Current location of the vehicle in form of point(converted from lat lng)'
;
COMMENT ON COLUMN LocationHistory.time IS 'Time for the stored point'
;

-- Add keys for table LocationHistory

ALTER TABLE LocationHistory ADD CONSTRAINT Key13 PRIMARY KEY (id)
;

-- Table Traffic

CREATE TABLE Traffic(
 traffic_id BigSerial NOT NULL,
 startPoint geometry(POINT,900913) NOT NULL,
 endPoint geometry(POINT,900913) NOT NULL,
 time time NOT NULL,
 date Date NOT NULL,
 type Text NOT NULL,
 roadName Text NOT NULL,
 route_id Bigint NOT NULL
)
;
COMMENT ON COLUMN Traffic.traffic_id IS 'Auto increment primary key.'
;
COMMENT ON COLUMN Traffic.startPoint IS 'The location point where the traffic start.'
;
COMMENT ON COLUMN Traffic.endPoint IS 'The location point where the traffic end.'
;
COMMENT ON COLUMN Traffic.time IS 'time of traffic.'
;
COMMENT ON COLUMN Traffic.date IS 'Date of the traffic.'
;

-- Add keys for table Traffic

ALTER TABLE Traffic ADD CONSTRAINT Key14 PRIMARY KEY (traffic_id)
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE Distance ADD CONSTRAINT " BusStop has a distance " FOREIGN KEY (stop_id) REFERENCES BusStop (stop_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Distance ADD CONSTRAINT " distance between stops of route " FOREIGN KEY (route_id) REFERENCES Route (route_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Schedule ADD CONSTRAINT " is scheduled to " FOREIGN KEY (vehicle_id) REFERENCES Vehicle (vehicle_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Schedule ADD CONSTRAINT " route has " FOREIGN KEY (route_id) REFERENCES Route (route_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE SySession ADD CONSTRAINT " sylogin creates " FOREIGN KEY (username) REFERENCES SyLogin (username) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Transaction ADD CONSTRAINT " generated for route " FOREIGN KEY (route_id) REFERENCES Route (route_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Transaction ADD CONSTRAINT " generated for vehicle " FOREIGN KEY (vehicle_id) REFERENCES Vehicle (vehicle_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Transaction ADD CONSTRAINT " generated by " FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE UserLogin ADD CONSTRAINT " has login " FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE UserSession ADD CONSTRAINT " creates user session " FOREIGN KEY (username) REFERENCES UserLogin (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE VehicleSession ADD CONSTRAINT " start vehicle session " FOREIGN KEY (schedule_id) REFERENCES Schedule (schedule_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE LocationHistory ADD CONSTRAINT " stores Temporarily " FOREIGN KEY (session_id) REFERENCES VehicleSession (session_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE VehicleHistory ADD CONSTRAINT " stored in history " FOREIGN KEY (schedule_id) REFERENCES Schedule (schedule_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Traffic ADD CONSTRAINT " has traffic condition " FOREIGN KEY (route_id) REFERENCES Route (route_id) ON DELETE NO ACTION ON UPDATE NO ACTION
;




