<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<spring:url value="resources/images/favicon.png" var="favicon" />
<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/css/dashboard.css" var="dashboardCss"/>

<spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
<spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>

<spring:url value="resources/images/icon.png" var="titleIcon" />


<!DOCTYPE html>
<html lang="en">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>SY Bus - Fare Tracking and Management System for Sajha Yatayat</title>
      <link rel="shortcut icon" type="image/png" href="${favicon}"/>
      <!-- Latest compiled and minified CSS -->
      <link href="${bootstrapCss}" rel="stylesheet">
      <!-- Optional theme -->
      <link href="${bootstrapThemeCss}" rel="stylesheet">
	  <!--css import for sidepanel dashboard-->
    <link href="${dashboardCss}" rel="stylesheet">	
	
        <style type="text/css">
            html,body{height:95.3%}
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
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            </button>			
                            <a class="navbar-brand" href="home" style="color:#DDD;font-size:22px;margin-top:-10px;">
                                <span style="float:left;margin-right:8px;margin-left:0px"><img src="${titleIcon}" alt="icon" height="45" width="45"></span> 
                                <div style="font-size:28px;margin-top:5px; float:left;margin-right:10px">SY BUS<br><span style="font-size:12px;float:left">Vehicle Tracking &amp; Management System </span></div>
                            </a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li><a href="home">HOME <span class="sr-only">(current)</span></a></li>
                                <li><a href="tracking">VEHICLE TRACKING</a></li>
                                <li class="active"><a href="management">MANAGE</a></li>
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
        <!-- Main body-->   
        <div class ="container-fluid" style="margin-top:6px; height:100%;width:100%">
            <!-- Nav tabs -->
            <!--enclosing this tab menu in container fluid so that there is certain padding and we also dont want to have padding in content e.g. map so exclusively defining only this div that wrap tab section only-->
            <div class="container page-header" role="main" style="margin-top:10px; padding:10px">
                <h2 style="color:#4CAF50">VEHICLE MANAGEMENT <small>Manage various vehicle information</small></h2>
            </div>
            <div class="container" style="margin-top:50px; font-family:Arial, Helvetica, sans-serif;font-size:13px">
                <div class="col-lg-3" style="text-align:center">
                    <div class="panel panel-default" style="padding:5px; margin:-10px">
                        <h3 style="color:#4CAF50">ROUTE<br> MANAGEMENT</h3>
                        <p style="text-align:justify;">
                            Manage route information and other details. You can view list of existing route details and add a new route details with different stops. In addition, you can edit and update existing route details and delete particular route details from list.
                        </p>
                        <p><a class="btn" style="color:#000; border:1px solid #616161" href="manage-route" role="button">Manage Route &raquo;</a></p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align:center">
                    <div class="panel panel-default" style="padding:5px; margin:-10px">
                        <h3 style="color:#4CAF50">SCHEDULE <br>MANAGEMENT</h3>
                        <p style="text-align:justify">
                            Produce and manage schedules. You can view list of existing scheduling details and add a new schedule for particular vehicle for particular route. In addition, you can edit and update existing schedule and delete schedules.
                        </p>
                        <p><a class="btn" style="color:#000; border:1px solid #616161" href="manage-schedule" role="button">Manage Schedule &raquo;</a></p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align:center">
                    <div class="panel panel-default" style="padding:5px; margin:-10px">
                        <h3 style="color:#4CAF50">VEHICLE <br>MANAGEMENT</h3>
                        <p style="text-align:justify;">Manage various vehicle information. You can view list of existing vehicle details and add a new vehicle details with single click. In addition, you can edit and update existing vehicle details and delete particular vehicle from the list as well.</p>
                        <p><a class="btn" style="color:#000; border:1px solid #616161;" href="manage-vehicle" role="button">Manage Vehicle &raquo;</a></p>
                    </div>
                </div>
                <div class="col-lg-3" style="text-align:center">
                    <div class="panel panel-default" style="padding:5px; margin:-10px">
                        <h3 style="color:#4CAF50">FARE<br> MANAGEMENT</h3>
                        <p style="text-align:justify">
                            Manage fare information and other details. You can view list of list of existing fare details and add a new fare amount details for various distance. In addition, you can edit and update existing fare details and delete vehicle.
                        </p>
                        <p><a class="btn" style="color:#000; border:1px solid #616161" href="manage-fare" role="button">Manage Fare &raquo;</a></p>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <!--loading icon animation-->
        <div id="loading" style="background:url('images/loading.gif');background-repeat:no-repeat;background-position:center center;height:auto; width:auto; position: absolute;top:0;bottom: 0;left: 0;right: 0;margin: auto;position:absolute; z-index:9999; display:none"></div>
        <br>
        <!-- Footer -->
        <div class="navbar-header" style="position: fixed;bottom: 0; width: 100%; height:40px; background:#212121">
            <div  style="text-align:center; font-size:11px;color:#DDD">
                <div class="container" style="margin-top:5px">
                    <span><strong  style="color:Green">Copyright &copy; sybus.com 2015 </strong><br> SAJHA YATAYAT VEHICLE TRACKING AND MANAGEMENT SYSTEM (SYBUS)  </span>
                </div>
            </div>
        </div>
	  <!--Javascript section-->
      <!-- Latest compiled JQuery JavaScript -->
      <script src="${jqueryJs}"></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src="${bootstrapJs}"></script>
    </body>
</html>