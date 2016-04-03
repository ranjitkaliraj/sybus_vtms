<%@page session="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<spring:url value="resources/images/favicon.png" var="favicon" />
<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap-theme.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/images/icon.png" var="titleIcon" />
<spring:url value="resources/images/map1.png" var="frontCoverBg" />

		
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SY Bus - Vehicle Tracking and Management System for Sajha Yatayat </title>
        <link rel="shortcut icon" type="image/png" href="${favicon}"/>
        <!-- Latest compiled and minified CSS -->
        <link href="${bootstrapCss}" rel="stylesheet">
        <!-- Optional theme -->
        <link href="${bootstrapThemeCss}" rel="stylesheet">
        <style type="text/css">
            .panel-default>.panel-heading-custom {
            background: rgba(0, 0, 0, 0.7);
            color: #EEE;
            height: 36px;
            padding: 2px;
            }
            ::-webkit-scrollbar {
            display: none;
            }
        </style>
    </head>
    <body>
        <header class="navbar-inverse navbar-fixed-top" role="banner">
            <div class="container">
                <nav role="navigation">
                    <div class="container-fluid">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed"
                                data-toggle="collapse"
                                data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span> <span
                                class="icon-bar"></span> <span class="icon-bar"></span> <span
                                class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="#"
                                style="color: #DDD; font-size: 22px; margin-top: -10px;">
                                <span
                                
                                    style="float: left; margin-right: 8px; margin-left: 0px"><img
                                    src="${titleIcon}" alt="icon" height="40" width="45"></span>
                                <div style="font-size: 28px; margin-top: 5px; float: left; margin-right: 10px">
                                    SY BUS<br>
                                    <span style="font-size: 12px; float: left">Vehicle
                                    Tracking &amp; Management System </span>
                                </div>
                            </a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse"
                            id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="active"><a href="#">HOME <span
                                    class="sr-only">(current)</span></a></li>
                                <li><a href="tracking">VEHICLE TRACKING</a></li>
                                <li><a href="management">MANAGE</a></li>
                                <!--<li class="active" class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">MANAGE <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                       <li><a id="target" href="#">Manage Routes</a></li>
                                       <li><a href="#">Manage Schedules</a></li>
                                       <li><a href="#">Manage Fare</a></li>
                                       <li><a href="#">Manage Vehicles</a></li>
                                    </ul>
                                    </li>-->
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle"
                                        data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false">REPORTING <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="route-with-most-passenger-travelling-report">Route with Most Passenger Travelling Report</a></li>
                                        <li><a href="route-with-most-traffic-condition-report">Route with Most Traffic Report</a></li>
                                        <li><a href="time-where-most-passenger-ride-bus-report">Time where Most Passenger Ride Bus Report</a></li>
                                        <li><a href="vehicle-schedule-fare-and-route-report">Vehicle, Schedule, Fare and Route Details Report</a></li>
                                        <li><a href="registered-passenger-details-report">Registered Passenger Details Report</a></li>
                                        <li><a href="bus-with-highest-and-lowest-travelling-time-report">Bus with Highest and Lowest Travelling Time Report</a></li>
                                    </ul>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle"
                                        data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false">Options <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="logout">Logout</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a onclick="alert()">Help</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <!-- /.navbar-collapse -->
                    </div>
                    <!-- /.container-fluid -->
                </nav>
            </div>
        </header>
        <br>
        <br>
        <!-- Main body-->
        <!--Vehicle tracking section-->
        <div class="jumbotron"
            style="background: url('${frontCoverBg}'); background-cover: cover; background-repeat: n; background-position: center center; border: 5px solid rgba(0, 0, 0, 0.2); height: 499px">
            <!--using container to make the well in center or align center-->
            <div class="container" style="margin-left: 90px; margin-top: 30px">
                <div class="well well-sm"
                    style="color: #FFF; width: 780px; height: 320px; background: rgba(0, 0, 0, 0.6); border: 1px solid #000; border-radius: 5px;">
                    <h2>
                        <span style="font-size: 40px;">VEHICLE<br>TRACKING
                        </span><br>
                        <small><strong style="font-size: 28px; color: #CCC">Track,
                        monitor and Control Vehicles</strong></small>
                    </h2>
                    <p
                        style="text-align: left; font-size: 15px; font-family: Arial, Helvetica, sans-serif; font-weight: normal">Welcome
                        to Sajha Yatayat Vehicle Tracking and Management System. You can
                        track and monitor all the vehicles operated in various routes
                        anytime. In addition, you can control vehicles and its tracking
                        status by disabling and enabling from the tracking list.
                    </p>
                    <p>
                        <a class="btn btn-sm"
                            style="color: #FFF; border: 1px solid rgba(255, 255, 255, 0.7); font-size: 14px; font-weight: normal"
                            href="tracking.html" role="button">START TRACKING</a>
                    </p>
                </div>
            </div>
        </div>
        <div class="container" role="main" style="margin-top: -32px">
            <!---Vehicle management section-->
            <div class="page-header">
                <h2 style="color: #4CAF50">
                    VEHICLE MANAGEMENT <small>Manage various vehicle information</small>
                </h2>
            </div>
            <div class="container marketing"
                style="margin-left: -14px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">
                <div class="col-lg-3" style="text-align: center">
                    <div class="panel panel-default" style="padding: 5px; margin: -10px">
                        <h3>VEHICLE MANAGEMENT</h3>
                        <p style="text-align: justify;">Manage various vehicle
                            information. You can view list of existing vehicle details and add
                            a new vehicle details with single click. In addition, you can edit
                            and update existing vehicle details and delete particular vehicle
                            from the list as well.
                        </p>
                        <p>
                            <a class="btn"
                                style="color: #000; border: 1px solid rgba(0, 0, 0, 0.7);"
                                href="#" role="button">Manage Vehicle &raquo;</a>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align: center">
                    <div class="panel panel-default" style="padding: 5px; margin: -10px">
                        <h3>
                            ROUTE<br> MANAGEMENT
                        </h3>
                        <p style="text-align: justify;">Manage route information and
                            other details. You can view list of existing route details and add
                            a new route details with different stops. In addition, you can
                            edit and update existing route details and delete particular route
                            details from list.
                        </p>
                        <p>
                            <a class="btn"
                                style="color: #000; border: 1px solid rgba(0, 0, 0, 0.7)"
                                href="#" role="button">Manage Route &raquo;</a>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align: center">
                    <div class="panel panel-default" style="padding: 5px; margin: -10px">
                        <h3>
                            FARE<br> MANAGEMENT
                        </h3>
                        <p style="text-align: justify">Manage fare information and
                            other details. You can view list of list of existing fare details
                            and add a new fare amount details for various distance. In
                            addition, you can edit and update existing fare details and delete
                            vehicle.
                        </p>
                        <p>
                            <a class="btn"
                                style="color: #000; border: 1px solid rgba(0, 0, 0, 0.7)"
                                href="#" role="button">Manage Fare &raquo;</a>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align: center">
                    <div class="panel panel-default" style="padding: 5px; margin: -10px">
                        <h3>SCHEDULE MANAGEMENT</h3>
                        <p style="text-align: justify">Produce and manage schedules.
                            You can view list of existing scheduling details and add a new
                            schedule for particular vehicle for particular route. In addition,
                            you can edit and update existing schedule and delete schedules.
                        </p>
                        <p>
                            <a class="btn"
                                style="color: #000; border: 1px solid rgba(0, 0, 0, 0.7)"
                                href="#" role="button">Manage Schedule &raquo;</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="page-header">
                <h2 style="color: #4CAF50">
                    REPORTING <small>Generate various reports</small>
                </h2>
            </div>
            <!--Reporting section-->
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Route with most passenger travelling <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Route with most traffic Condition <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Time where most passenger ride bus <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Vehicle, schedule, fare and route <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Registered Passenger Details <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
            <div class="col-lg-2" style="text-align: center">
                <div class="panel panel-default" style="padding: 5px; margin: -10px">
                    <h5 style="font-weight: bold">
                        Bus with highest and lowest travelling time <br>Report
                    </h5>
                    <p>
                        <a class="btn btn-block"
                            style="color: #595959; border: 1px solid rgba(0, 0, 0, 0.7)"
                            href="#" role="button">Generate &raquo;</a>
                    </p>
                </div>
            </div>
        </div>
        
        <div class="page-header" style="text-align: center">
            <img src="${titleIcon}" alt="icon">
            <h2>
                SY BUS <small>Vehicle Tracking &amp; Management System</small>
            </h2>
        </div>
        <br>
        <!-- Footer -->
        <div class="navbar-header"
            style="position: fixed; bottom: 0; width: 100%; height: 40px; background: #212121">
            <div style="text-align: center; font-size: 11px; color: #DDD">
                <div class="container" style="margin-top: 5px">
                    <span><strong style="color: Green">Copyright &copy;
                    sybus.com 2015 </strong><br> SAJHA YATAYAT VEHICLE TRACKING AND
                    MANAGEMENT SYSTEM (SYBUS) </span>
                </div>
            </div>
        </div>
        <!-- Latest compiled JQuery JavaScript -->
        <spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
        <script src="${jqueryJs}"></script>
    
        <spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>
        <script src="${bootstrapJs}"></script>
        
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <spring:url value="resources/js/ie10-viewport-bug-workaround.js" var="viewportBusJs"/>
        <script src="">${"viewportBusJs"}</script>
        
    </body>
</html>