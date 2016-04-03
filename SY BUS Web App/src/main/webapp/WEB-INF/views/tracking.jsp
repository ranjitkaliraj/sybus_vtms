<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<spring:url value="resources/images/favicon.png" var="favicon" />

<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap-theme.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/css/dashboard.css" var="dashboardCss"/>

<spring:url value="resources/leaflet/leaflet.css" var="leafletCss"/>
<spring:url value="resources/leaflet/leaflet.label.css" var="leafletLabelCss"/>
<spring:url value="resources/leaflet/leaflet.zoomdisplay.css" var="leafletZoomdisplayCss"/>
<spring:url value="resources/leaflet/leaflet.awesome-markers.css" var="leafletAwesomeMarkersCss"/>
<spring:url value="resources/leaflet/leaflet_numbered_markers.css" var="leafletNumberedMarkersCss"/>
<spring:url value="resources/leaflet/easy-button.css" var="leafletEasyButtonCss"/>

<spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
<spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>

<spring:url value="resources/leaflet/leaflet.js" var="leafletJs"/>
<spring:url value="resources/leaflet/leaflet.zoomdisplay.js" var="leafletZoomdisplayJs"/>
<spring:url value="resources/leaflet/leaflet.awesome-markers.js" var="leafletAwesomeMarkersJs"/>
<spring:url value="resources/leaflet/leaflet.polylineDecorator.js" var="leafletPolylineDecoratorJs"/>
<spring:url value="resources/leaflet/easy-button.js" var="leafletEasyButtonJs"/>
<spring:url value="resources/leaflet/leaflet.label.js" var="leafletLabelJs"/>

<spring:url value="resources/images/icon.png" var="titleIcon" />
<spring:url value="resources/images/action.gif" var="actionLoadingIcon" />
<spring:url value="resources/images/Thin fading line.gif" var="loadingIcon" />
<spring:url value="resources/images/bus61.png" var="busIcon" />


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SY Bus - Vehicle Tracking and Management System for Sajha Yatayat</title>
<link rel="shortcut icon" type="image/png" href="${favicon}" />
<!-- Latest compiled and minified CSS -->
<link href="${bootstrapCss}" rel="stylesheet">
<!-- Optional theme -->
<link href="${bootstrapThemeCss}" rel="stylesheet">
<!--css import for sidepanel dashboard   used for tab-->
<link href="${dashboardCss}" rel="stylesheet">

<!--Leaflet CSS imports for map-->
<link rel='stylesheet' href='${leafletCss}' />
<link rel='stylesheet' href='${leafletLabelCss}' />
<link rel='stylesheet' href='${leafletZoomdisplayCss}' />
<link rel="stylesheet" href="${leafletAwesomeMarkersCss}">
<link rel="stylesheet" href="${leafletNumberedMarkersCss}">
<link rel="stylesheet" href="${leafletEasyButtonCss}">
<style type="text/css">
html, body {
	height: 95.3%
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
						<a class="navbar-brand" href="home"
							style="color: #DDD; font-size: 22px; margin-top: -10px;"> <span
							style="float: left; margin-right: 8px; margin-left: 0px"><img
								src="${titleIcon}" alt="icon" height="40" width="45"></span>
							<div
								style="font-size: 28px; margin-top: 5px; float: left; margin-right: 10px">
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
							<li><a href="home">HOME <span class="sr-only">(current)</span></a></li>
							<li class="active"><a href="#">VEHICLE TRACKING</a></li>
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
	<!-- Main body-->
	<div style="margin-top: 8px; height: 100%; width: 100%">
		<!-- Nav tabs -->
		<!--enclosing this tab menu in container fluid so that there is certain padding and we also dont want to have padding in content e.g. map so exclusively defining only this div that wrap tab section only-->
		<div class="container-fluid"
			style="padding-left: 24px; padding-right: 24px">
			<ul class="nav nav-tabs" role="tablist" style="font-weight: normal">
				<li role="presentation" class="active"><a id="map_view"
					href="#map_view_tab" aria-controls="map_view_tab" role="tab"
					data-toggle="tab" style="height: 36px; padding: 8px"><span
						class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
						MAP VIEW </a></li>
				<li role="presentation"><a id="list_view" href="#list_view_tab"
					aria-controls="list_view_tab" role="tab" data-toggle="tab"
					style="height: 36px; padding: 8px"><span
						class="glyphicon glyphicon-list" aria-hidden="true"></span>
						VEHICLE LIST </a></li>
				<li role="presentation"><a id="flagged" href="#flagged_tab"
					aria-controls="flagged_tab" role="tab" data-toggle="tab"
					style="height: 36px; padding: 8px"><span
						class="glyphicon glyphicon-flag" aria-hidden="true"></span>
						FLAGGED </a></li>



				<!--Select Route dropdown-->
				<span class="dropdown" style="float: right; margin-left: 12px">
					<button id="select_route_dropdown_button"
						style="border: 1px solid #616161; width: 160px; height: 28px; padding: 1px;"
						class="btn btn-success" data-toggle="dropdown"
						data-placement="top" title="Select Route" type="button"
						id="routeList" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="true">
						SELECT ROUTE <span class="caret"></span>
					</button>
					<ul id="select_route_dropdown" class="dropdown-menu"
						aria-labelledby="dropdownMenu1">
						<!--<li><a onclick="" style="font-size:12px; cursor:pointer">ROUTE 1</a></li>
			<li><a onclick="" style="font-size:12px; cursor:pointer">ROUTE 2</a></li>
			<li><a onclick="" style="font-size:12px; cursor:pointer">ROUTE 3</a></li>
			<li><a onclick="" style="font-size:12px; cursor:pointer">ROUTE 4</a></li>-->
					</ul>
				</span>




				<span id="map_view_mode_dropdown" class="input-group"
					style="padding: 0px; margin: 0px; width: 220px; float: right; margin-left: 12px">
					<span class="input-group-addon"
					style="padding: 0px; margin: 0px; font-weight: normal font-size:12px; color: #000; padding-left: 6px; padding-right: 6px"><span
						class="glyphicon glyphicon-th"></span> VIEW</span> <select
					id="map_view_mode_dropdown_select"
					style="height: 28px; font-size: 12px; padding: 0px; color: #424242"
					class="form-control tooltip-bottom" placeholder="apple"
					title="Select Bus stop from the list."
					onchange="changeMapViewMode(this)">
						<option selected="selected" value="1">ALL VEHICLES</option>
						<option value="2">ACTIVE VEHICLES</option>
						<option value="3">FLAGGED VEHICLES</option>
						<option value="4">SINGLE VEHICLE</option>
				</select>
				</span>



				<!--Refresh button on tab fof vehicle list dropdown items-->
				<!--<a style="float:right; padding:5px; margin-right:15px" href="#"><span class="glyphicon glyphicon-refresh pull-right tooltip-bottom" data-toggle="tooltip" data-placement="bottom" title="Reload the Vehicle Lists" style="color:#595959" aria-hidden="true"></span></a>
		-->
				<!--Select Vehicle List dropdown-->
				<!--
		  <span class="dropdown" style="float:right; margin-left:15px">
		  <button style="border:1px solid #616161; background-color:#FFF; width:160px; height:28px; padding:1px" class="btn dropdown-toggle" type="button" id="vehicleList" data-toggle="dropdown" aria-label="Left Align" aria-haspopup="true" aria-expanded="true">
		  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span> VEHICLE LIST <span class="badge">19</span>
		  
		</button>
		<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="max-height:320px; background-color:rgba(255,255,255,1); overflow-y:scroll; font-size:12px">
			<li class="dropdown-header list-group-item"><span style="font-size:11px;">Active Vehicles <span class="badge">15</span> </span></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 
			<li class="dropdown-header list-group-item"><span style="font-size:12px;">Flagged Vehicles <span class="badge">4</span></span></li>
			
				 <li><a href='#'><span>BA 10 PA 12114</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
				 <li><a href='#'><span>BA 10 PA 74334</span></a></li>
		  </ul>
		</span>
		
		-->


				<!--Refresh button on tab fof vehicle list dropdown items-->
				<!--<a style="float:right;padding:5px; margin-left:16px" href="#"><span class="glyphicon glyphicon-th pull-right tooltip-bottom" data-toggle="tooltip" data-placement="bottom" title="View All Vehicles" style="color:#595959" aria-hidden="true"></span></a>
		-->

				<!--Well - Route and vehicle overview-->
				<span class="well well-sm"
					style="height: 28px; width: 400px; text-align: center; float: right; font-size: 14px; font-weight: bold; margin: 0px; padding: 3px; border: 1px solid #616161; background: none"><span
					id="header_description_route_name">Not Selected </span><small
					style="font-weight: normal;"> Active Vehicles: <span
						id="header_description_active_count">N/A </span>| Flagged
						Vehicles: <span id="header_description_flagged_count">N/A</span></small></span>

			</ul>
		</div>





		<!-- Tab panes to display detail content-->
		<div class="tab-content" class="col-sm-12"
			style="height: 100%; width: 100%; overflow-y: hidden">

			<div id="no_content_error_message" tabindex='1'
				class="alert in fade alert-success" role="alert"
				style="width: 80%; margin: auto; margin-top: 20px; display: none; background: none; border: 1px solid #595959">
				<h2 style="color: #595959;">
					<span style="color: #4CAF50"
						id="add_route_submit_message_alert_title">NOT AVAILABLE.</span><small
						id="add_route_submit_message_alert_details"> Currently,
						there is nothing to display. Routes are not available.</small>
				</h2>
			</div>

			<!--#############################Map view section#################################################-->

			<div role="tabpanel" class="tab-pane fade in active"
				id="map_view_tab"
				style="background-color:; height: 100%; width: 100%">

				<span id="map_view_tab_container"> <!--Left route list panel -->
					<div class="col-md-2 panel panel-default"
						style="height: 100%; width: 18%; padding: 6px; padding-left: 16px; margin: 0px">


						<!--main side panel section-->
						<div id="map_tab_left_vehicles_list_panel"
							style="height: 100%; width: 100%; padding: 0px; overflow-y: auto !important;">




							<!--Error message when flagging or unflagging vehciel-->
							<div id="vehicle_flag_unflag_server_error"
								class="alert alert-danger row-fluid" role="alert"
								style="display: none; font-size: 14px; height: auto; padding: 4px; padding-left: 12px">
								<strong>ERROR OCCURED.</strong><small> Something went
									wrong. Please, try again later.</small>
							</div>

							<!--Error message when downloading vehicle data from server-->
							<div id="vehicle_data_download_server_error"
								class="alert alert-danger row-fluid" role="alert"
								style="display: none; font-size: 14px; height: 106px; padding: 4px; padding-left: 12px">
								<strong>ERROR OCCURED.</strong><small> Something went
									wrong. Please, try again later.</small>


								<!--Vehicle list refresh button-->
								<div style="height: 0px">
									<button id="vehicle_data_download_server_error_refresh_button"
										type="button" class="btn btn-sm"
										style="height: 18px; width: 72px; padding: 0px; background: none; border: 1px solid #616161; float: left">
										<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
										Refresh
									</button>
									<span id="vehicle_data_download_server_error_refresh_loading"
										style="float: right; background: url(${actionLoadingIcon}); display: none; margin-top: 3px; margin-right: 6px; height: 16px; width: 16px; background-size: 16px 16px; background-repeat: no-repeat;"></span>
								</div>

							</div>




							<!--Table heading for added route way list-->
							<div id="active_vehicle_side_table_header"
								style="display: nones; margin-left: 10px; margin-bottom: -8px">
								<h4>
									<span style="color: #4CAF50">Active Vehicles</span><span
										id="active_vehicle_count" class="badge"
										style="margin-top: -2px; margin-left: 6px">4</span><br>
									<small> List of available active vehicles.</small>
								</h4>
							</div>

							<!--no active vehicles available message.-->
							<h2 id="active_vehicle_side_table_list_not_available_message"
								style="display: none; color: #CCC; margin-left: 12px;">Not
								Available</h2>


							<!--Active vehicle list section-->
							<div class="container-fluid"
								style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">

								<table
									class="table table-condensed table-striped table-bordered"
									id="active_vehicle_side_table_list">

									<tbody>
										<!--	<tr>
							<td>1</td>
							<td>BA 10 PA 3477 <span style="float:right; color:green" data-toggle="tooltip" data-placement="top" title="View on Map" class="glyphicon glyphicon-globe"></span><span style="float:right; color:red" data-toggle="tooltip" data-placement="top" title="Flag This" class="glyphicon glyphicon-flag"></span></td>
							</tr>-->
									</tbody>
								</table>
							</div>


							<hr style="margin-top: 0px">

							<!--Table heading for flagged vehicle list-->
							<div id="flagged_vehicle_side_table_header"
								style="display: nones; margin-left: 10px; margin-bottom: -8px">
								<h4>
									<span style="color: #4CAF50">Flagged Vehicles</span><span
										id="flagged_vehicle_count" class="badge"
										style="margin-top: -2px; margin-left: 6px">4</span><br>
									<small> List of in-active/flagged vehicles.</small>
								</h4>
							</div>

							<!--No flagged vehicles available message.-->
							<h2 id="flagged_vehicle_side_table_not_available_message"
								style="display: none; color: #CCC; margin-left: 12px;">Not
								Available</h2>


							<!--Flagged vehicles table list section-->
							<div class="container-fluid"
								style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">

								<table
									class="table table-condensed table-striped table-bordered"
									id="flagged_vehicle_side_table_list">

									<tbody>

										<!--<tr>
							<td>1</td>
							<td>BA 10 PA 3477 <span  data-toggle="tooltip" data-placement="top" title="UnFlag This" style="float:right; color:green" class="glyphicon glyphicon-flag"></span></td>
							</tr>	-->
									</tbody>
								</table>
							</div>

							<hr style="margin-top: 0px">
						</div>

					</div> <!--Map view section-->
					<div class="col-md-10 panel panel-default"
						style="height: 100%; width: 82%; padding: 0px; margin: 0px">

						<div id="map" class="col-sm-12"
							style="float: left; margin-top: 0px; border: 1px solid #BDBDBD; height: 96%; min-height: 96%;">


						</div>
					</div>

				</span>
			</div>



			<!--################################List view section#################################################################-->


			<div role="tabpanel" class="tab-pane fade" id="list_view_tab"
				style="height: 100%; width: 100%; overflow-x: hidden; overflow-y: hidden; padding-left: 24px; padding-right: 24px; margin-top: -28px; font-family: Arial, Helvetica, sans-serif">


				<div class="page-header"
					style="height: 32px; padding-left: 18px; padding-right: 18px;">
					<h3>
						<span style="color: #4CAF50">LIST OF VEHICLES </span><small>
							Detail list view of all available active vehicles for <strong
							id="list_view_tab_header_route_name">Route 22</strong>
						</small>



						<button id="list_view_refresh_button" type="button"
							class="btn btn-sm"
							style="background-color: #FFF; border: 1px solid #616161; float: right; margin-bottom: 20px; margin-right: -18px">
							<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
							Refresh
						</button>
						<span style="font-size: 12px; float: right; margin: 10px">Last
							refreshed at: <span id="active_tab_hour"></span>:<span
							id="active_tab_min"></span>:<span id="active_tab_sec"></span>
						</span>
					</h3>

				</div>


				<div id="vehicle_list_tab_container" style="height: 95%">

					<!--No active vehicles available message.-->
					<h1 id="active_vehicle_not_available_status"
						style="display: none; color: #CCC; width: 40%; margin: auto; padding-top: 120px">Active
						Vehicle list Not Available</h1>


					<div
						style="padding-left: 18px; padding-right: 18px; margin-top: -8px; font-size: 12px; height: 87%; width: 92%; margin: auto; overflow-y: auto">


						<table class="table table-condensed table-striped table-bordered"
							style="display: none" id="list_view_table">
							<thead>
								<tr style="background-color: rgba(0, 0, 0, 0.8); color: #CCC">
									<th style="text-align: center" width="3%">SN</th>
									<th style="text-align: center" width="12%">VEHICLE NO.</th>
									<th style="text-align: center" width="15%">CURRENT
										LOCATION</th>
									<th style="text-align: center" width="9%">LATITUDE</th>
									<th style="text-align: center" width="9%">LONGITUDE</th>
									<th style="text-align: center" width="17%">NEXT STOP</th>
									<th style="text-align: center" width="9%">ETA</th>
									<th style="text-align: center" width="10%">SCHEDULED ON</th>
									<th style="text-align: center" width="10%"><span
										class="glyphicon glyphicon-flag"></spam></th>

								</tr>
							</thead>
							<tbody>
								<!--<tr>
							<td>1</td>
							<td style="text-align:center">BA 10 PA 12233</td>
							<td>Kalimati Road</td>
							<td style="text-align:center">27.3232</td>
							<td style="text-align:center">85.3323</td>
							<td>Kalimati Station</td>
							<td style="text-align:center">5 mins</td>
							<td style="text-align:center">10:45</td>
							<td>    
								<button type="button" class="btn btn-xs btn-block" style="background:none; border:1px solid black; float:right; margin:0px">
									<span class="glyphicon glyphicon-flag" aria-hidden="true"></span> Flag It
								</button>
							</td>
						  </tr>-->

							</tbody>
						</table>



					</div>
				</div>
			</div>


			<!--#################################################Flagged vehicle view section##############################################-->


			<div role="tabpanel" class="tab-pane fade" id="flagged_tab"
				style="height: 100%; width: 100%; padding-left: 24px; padding-right: 24px; margin-top: -28px; font-family: Arial, Helvetica, sans-serif">


				<div class="page-header"
					style="height: 32px; padding-left: 18px; padding-right: 18px;">
					<h3>
						<span style="color: #4CAF50">FLAGGED VEHICLES</span> <small>
							List of all the flagged/disabled vehicles for <strong
							id="flagged_tab_header_route_name">Route 22</strong>
						</small>


						<button id="flagged_refresh_button" type="button"
							class="btn btn-sm"
							style="background-color: #FFF; border: 1px solid #616161; float: right; margin-bottom: 20px; margin-right: -18px">
							<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
							Refresh
						</button>

						<span style="font-size: 12px; float: right; margin: 10px">Last
							refreshed at: <span id="flagged_tab_hour"></span>:<span
							id="flagged_tab_min"></span>:<span id="flagged_tab_sec"></span>
						</span>
					</h3>

				</div>


				<span id="flagged_tab_container">
					<div class="col-md-1"></div>
					<div class="col-md-10"
						style="margin-top: -8px; font-size: 12px; height: 87%; overflow-y: auto">


						<!--No active vehicles available message.-->
						<h1 id="flagged_vehicle_not_available_status"
							style="display: none; color: #CCC; width: 55%; margin: auto; padding-top: 120px">Flagged
							Vehicle list Not Available</h1>


						<table class="table table-condensed table-striped table-bordered"
							style="display: none" id="flagged_vehicle_table">
							<thead>
								<tr
									style="background-color: #424242; color: #CCC; text-align: center">
									<th style="text-align: center">#SN</th>
									<th style="text-align: center">VEHICLE NO.</th>
									<th style="text-align: center">CURRENT LOCATION</th>
									<th style="text-align: center">LONGITUDE</th>
									<th style="text-align: center">LATITUDE</th>
									<th style="text-align: center">SCHEDULED ON</th>
									<th style="text-align: center" width="15%"><span
										class="glyphicon glyphicon-flag"></spam></th>

								</tr>
							</thead>
							<tbody>
								<!-- <tr>
							<td>1</td>
							<td style="text-align:center">BA 10 PA 12233</td>
							<td>Kalimati Road</td>
							<td style="text-align:center">27.3232</td>
							<td style="text-align:center">85.3323</td>
							<td style="text-align:center">12:00 AM</td>
						  </tr>-->


							</tbody>
						</table>
					</div>

				</span>
			</div>


		</div>
	</div>
	</div>
	<!--loading icon animation-->
	<div id="loading"
		style="background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: auto; width: auto; position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin: auto; position: absolute; z-index: 9999; display: none"></div>


	<div id="loading1"
		style="background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: auto; width: auto; position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin: auto; position: absolute; z-index: 9999; display: none"></div>


	<!--Modals-->
	<!--Alert Modal-->
	<div id="alert_modal" class="modal fade"
		style="margin-top: 120px; padding: 40px">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"
					style="height: 42px; padding: 8px; border-top-left-radius: 5px; border-top-right-radius: 5px; background-color: #424242; color: #FFF; text-align: center">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="alert_modal_title" class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<span style="font-size: 16px" id="alert_modal_content"></span>
				</div>
				<div class="modal-footer">
					<button id="alert_modal_close" type="button" class="btn btn-sm"
						data-dismiss="modal"
						style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						CLOSE
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->



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
	<!--Javascript section-->
	<!-- Latest compiled JQuery JavaScript -->
	<script src="${jqueryJs}"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="${bootstrapJs}"></script>

	<!--Leaflet javascript imports-->
	<!--Leaflet javascript imports-->
	<script src='${leafletJs}'></script>
	<script src='${leafletZoomdisplayJs}'></script>
	<script src="${leafletAwesomeMarkersJs}"></script>
	<script src='${leafletPolylineDecoratorJs}'></script>
	<!--only work this way. if we shift below label.jas this import will not work. why? may  be bug?-->
	<script src="${leafletEasyButtonJs}"></script>


	<script src='${leafletLabelJs}'></script>

	<script type="text/javascript">
	  
	  //Tooltip
	  	$('[data-toggle="tooltip"]').tooltip();
		$('button').click(function(){$(this).tooltip('hide')});
		$('tr').click(function(){$(this).tooltip('hide')});
			
	  //First load all data and on document ready set the data to page.
			
			var globalTabName = "map_view";
							
				$("#map_view").click(function (){
				globalTabName = "map_view";
				});
				$("#list_view").click(function (){
					globalTabName = "list_view";				
					//loadBusStopData();
				});
				$("#flagged").click(function (){
					globalTabName = "flagged";
				});
			
			
			
			//displaying route's all vehicle on map  when a particular route is selected from dropdown.
			$(document).ready(function() {		
				//setting global variable when each tab is clicked
				
				//when view dropdown button triggered and any route from the list is clicked then setting the name of dropdown name as route selected
					    $("#select_route_dropdown").on('click', 'li a', function(){
						  $("#select_route_dropdown_button:first-child").html($(this).text()+' <span class="caret"></span>');
						  //$("#select_route_dropdown_button:first-child").val($(this).text());
						  var routeName = $(this).text();
						  //removing previous click listener
						  
						  //activate the tracking vehicle for this/particular route method.
						  $("#loading").fadeIn();
						  setTimeout(function(){
						  //alert("activate");
						  activateTracking(routeName);
						  $("#loading").fadeOut();
						  },1000);
					   });
				});
	  
	  
	  
	  ////this function displays loading animation when each tab is loaded for the first time only.
			/*var first_time_map_tab_loaded = false;
			var first_time_list_view_tab_loaded = false;
			var first_time_flagged_tab_loaded = false;
			
			function firstTimeTabLoadinAnimation(){
				//route tab section			
				if(first_time_map_tab_loaded==false && globalTabName=="map_view"){			
					$("#loading").fadeIn();
					$("#map_view_tab_container").hide();
					setTimeout(function(){						
						$("#loading").fadeOut();					
						$("#map_view_tab_container").fadeIn();
					},800);
					first_time_map_tab_loaded=true;
				}
				//bus stop tab section
				else if(first_time_list_view_tab_loaded==false && globalTabName=="list_view"){				
					$("#loading").fadeIn();	
					$("#vehicle_list_tab_container").hide();
					setTimeout(function(){						
						$("#loading").fadeOut();					
						$("#vehicle_list_tab_container").fadeIn();
					},800);
					first_time_list_view_tab_loaded=true;
				}
				//route way tab section
				if(first_time_flagged_tab_loaded==false && globalTabName=="flagged"){			
					$("#loading").fadeIn();	
					$("#flagged_tab_container").hide();
					setTimeout(function(){						
						$("#loading").fadeOut();					
						$("#flagged_tab_container").fadeIn();
					},800);
					first_time_flagged_tab_loaded=true;
				}
			};*/
			//firstTimeTabLoadinAnimation();
	 



//EXAMPLE DATA .....................................................................................................................................................
			//var route1 = {name:"Route 1", stops:[{name:"Swayambhu Bus Station", latitude:27.71595, longitude:85.28364},{name:"Sitapaila Bus Station", latitude:27.70743, longitude:85.28263},{name:"Kalanki Bus Station", latitude:27.69337, longitude:85.28174},{name:"SoaltiMood Bus Station", latitude:27.69664, longitude:85.29356},{name:"Kalimati Bus Station", latitude:27.69835, longitude:85.29960},{name:"Teku Bus Station", latitude:27.69667, longitude:85.30570},{name:"Tripureshwor1 Bus Station", latitude:27.69462, longitude:85.31135},{name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336},{name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357},{name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666},{name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819},{name:"Hattisar Bus Station", latitude:27.71099, longitude:85.32210},{name:"Kamalpokhari Bus Station", latitude:27.71010, longitude:85.32514},{name:"Gyaneshwor Bus Station", latitude:27.70866, longitude:85.33199},{name:"Maitidevi Bus Station", latitude:27.70830, longitude:85.33338},{name:"Ratopul Bus Station", latitude:27.70811, longitude:85.33626},{name:"Gaushala Bus Station", latitude:27.70780, longitude:85.34334},{name:"Tilganga Bus Station", latitude:27.70613, longitude:85.34959},{name:"Airport Bus Station", latitude:27.70019, longitude:85.35411}],wayLine:[{node:1, latitude:27.71595, longitude:85.28364}, {node:2, latitude:27.70743, longitude:85.28263}, {node:3, latitude:27.69950, longitude:85.28177}, {node:4, latitude:27.69858, longitude:85.28154}, {node:5, latitude:27.69804, longitude:85.28155}, {node:6, latitude:27.69337, longitude:85.28174}, {node:7, latitude:27.69356, longitude:85.28275}, {node:8, latitude:27.69378, longitude:85.28370}, {node:9, latitude:27.69409, longitude:85.28449}, {node:10, latitude:27.69427, longitude:85.28498}, {node:11, latitude:27.69533, longitude:85.28908}, {node:12, latitude:27.69539, longitude:85.28979}, {node:13, latitude:27.69545, longitude:85.29009}, {node:14, latitude:27.69564, longitude:85.29072}, {node:15, latitude:27.69564, longitude:85.29088}, {node:16, latitude:27.69563, longitude:85.29101}, {node:17, latitude:27.69546, longitude:85.29200}, {node:18, latitude:27.69544, longitude:85.29216}, {node:19, latitude:27.69547, longitude:85.29250}, {node:20, latitude:27.69553, longitude:85.29270}, {node:21, latitude:27.69559, longitude:85.29285}, {node:22, latitude:27.69579, longitude:85.29306}, {node:23, latitude:27.69664, longitude:85.29356}, {node:24, latitude:27.69673, longitude:85.29381}, {node:25, latitude:27.69695, longitude:85.29447}, {node:26, latitude:27.69850, longitude:85.29960}, {node:27, latitude:27.69860, longitude:85.30000}, {node:28, latitude:27.69843, longitude:85.30074}, {node:29, latitude:27.69806, longitude:85.30260}, {node:30, latitude:27.69781, longitude:85.30355}, {node:31, latitude:27.69773, longitude:85.30372}, {node:32, latitude:27.69667, longitude:85.30570}, {node:33, latitude:27.69660, longitude:85.30587}, {node:34, latitude:27.69627, longitude:85.30704}, {node:35, latitude:27.69604, longitude:85.30776}, {node:36, latitude:27.69585, longitude:85.30828}, {node:37, latitude:27.69509, longitude:85.31006}, {node:38, latitude:27.69462, longitude:85.31135}, {node:39, latitude:27.69433, longitude:85.31206}, {node:40, latitude:27.69425, longitude:85.31229}, {node:41, latitude:27.69411, longitude:85.31274}, {node:42, latitude:27.69397, longitude:85.31336}, {node:43, latitude:27.69390, longitude:85.31375}, {node:44, latitude:27.69388, longitude:85.31395}, {node:45, latitude:27.69393, longitude:85.31397}, {node:46, latitude:27.69398, longitude:85.31401}, {node:47, latitude:27.69412, longitude:85.31407}, {node:48, latitude:27.69430, longitude:85.31410}, {node:49, latitude:27.69445, longitude:85.31409}, {node:50, latitude:27.69614, longitude:85.31384}, {node:51, latitude:27.69708, longitude:85.31374}, {node:52, latitude:27.69732, longitude:85.31368}, {node:53, latitude:27.69786, longitude:85.31347}, {node:54, latitude:27.69800, longitude:85.31338}, {node:55, latitude:27.69810, longitude:85.31330}, {node:56, latitude:27.69934, longitude:85.31341}, {node:57, latitude:27.69967, longitude:85.31345}, {node:58, latitude:27.70000, longitude:85.31348}, {node:59, latitude:27.70055, longitude:85.31351}, {node:60, latitude:27.70157, longitude:85.31357}, {node:61, latitude:27.70184, longitude:85.31360}, {node:62, latitude:27.70356, longitude:85.31377}, {node:63, latitude:27.70377, longitude:85.31375}, {node:64, latitude:27.70400, longitude:85.31380}, {node:65, latitude:27.70445, longitude:85.31383}, {node:66, latitude:27.70458, longitude:85.31387}, {node:67, latitude:27.70537, longitude:85.31405}, {node:68, latitude:27.70572, longitude:85.31412}, {node:69, latitude:27.70706, longitude:85.31431}, {node:70, latitude:27.70788, longitude:85.31436}, {node:71, latitude:27.70847, longitude:85.31440}, {node:72, latitude:27.70855, longitude:85.31444}, {node:73, latitude:27.70874, longitude:85.31463}, {node:74, latitude:27.70874, longitude:85.31482}, {node:75, latitude:27.70881, longitude:85.31530}, {node:76, latitude:27.70899, longitude:85.31590}, {node:77, latitude:27.70926, longitude:85.31666}, {node:78, latitude:27.70940, longitude:85.31703}, {node:79, latitude:27.70944, longitude:85.31709}, {node:80, latitude:27.70951, longitude:85.31716}, {node:81, latitude:27.70960, longitude:85.31720}, {node:82, latitude:27.70989, longitude:85.31724}, {node:83, latitude:27.71006, longitude:85.31723}, {node:84, latitude:27.71028, longitude:85.31738}, {node:85, latitude:27.71301, longitude:85.31783}, {node:86, latitude:27.71324, longitude:85.31790}, {node:87, latitude:27.71332, longitude:85.31819}, {node:88, latitude:27.71360, longitude:85.31938}, {node:89, latitude:27.71366, longitude:85.31997}, {node:90, latitude:27.71371, longitude:85.32197}, {node:91, latitude:27.71343, longitude:85.32204}, {node:92, latitude:27.71214, longitude:85.32219}, {node:93, latitude:27.71158, longitude:85.32223}, {node:94, latitude:27.71127, longitude:85.32218}, {node:95, latitude:27.71099, longitude:85.32210}, {node:96, latitude:27.71050, longitude:85.32198}, {node:97, latitude:27.71033, longitude:85.32223}, {node:98, latitude:27.71029, longitude:85.32271}, {node:99, latitude:27.71025, longitude:85.32311}, {node:100, latitude:27.71017, longitude:85.32450}, {node:101, latitude:27.71010, longitude:85.32514}, {node:102, latitude:27.71001, longitude:85.32604}, {node:103, latitude:27.70994, longitude:85.32623}, {node:104, latitude:27.70921, longitude:85.32938}, {node:105, latitude:27.70913, longitude:85.32979}, {node:106, latitude:27.70902, longitude:85.33025}, {node:107, latitude:27.70894, longitude:85.33067}, {node:108, latitude:27.70894, longitude:85.33067}, {node:109, latitude:27.70866, longitude:85.33199}, {node:110, latitude:27.70862, longitude:85.33222}, {node:111, latitude:27.70841, longitude:85.33291}, {node:112, latitude:27.70829, longitude:85.33330}, {node:113, latitude:27.70830, longitude:85.33338}, {node:114, latitude:27.70826, longitude:85.33363}, {node:115, latitude:27.70811, longitude:85.33626}, {node:116, latitude:27.70810, longitude:85.33653}, {node:117, latitude:27.70798, longitude:85.33935}, {node:118, latitude:27.70798, longitude:85.33945}, {node:119, latitude:27.70797, longitude:85.33995}, {node:120, latitude:27.70800, longitude:85.34021}, {node:121, latitude:27.70818, longitude:85.34097}, {node:122, latitude:27.70821, longitude:85.34117}, {node:123, latitude:27.70817, longitude:85.34186}, {node:124, latitude:27.70810, longitude:85.34227}, {node:125, latitude:27.70804, longitude:85.34251}, {node:126, latitude:27.70785, longitude:85.34314}, {node:127, latitude:27.70780, longitude:85.34334}, {node:128, latitude:27.70767, longitude:85.34371}, {node:129, latitude:27.70721, longitude:85.34436}, {node:130, latitude:27.70606, longitude:85.34581}, {node:131, latitude:27.70595, longitude:85.34601}, {node:132, latitude:27.70588, longitude:85.34619}, {node:133, latitude:27.70578, longitude:85.34653}, {node:134, latitude:27.70575, longitude:85.34674}, {node:135, latitude:27.70574, longitude:85.34693}, {node:136, latitude:27.70576, longitude:85.34731}, {node:137, latitude:27.70613, longitude:85.34959}, {node:138, latitude:27.70623, longitude:85.35030}, {node:139, latitude:27.70625, longitude:85.35048}, {node:140, latitude:27.70624, longitude:85.35070}, {node:141, latitude:27.70620, longitude:85.35092}, {node:142, latitude:27.70613, longitude:85.35111}, {node:143, latitude:27.70605, longitude:85.35128}, {node:144, latitude:27.70592, longitude:85.35147}, {node:145, latitude:27.70579, longitude:85.35162}, {node:146, latitude:27.70561, longitude:85.35177}, {node:147, latitude:27.70545, longitude:85.35187}, {node:148, latitude:27.70526, longitude:85.35195}, {node:149, latitude:27.70510, longitude:85.35198}, {node:150, latitude:27.70305, longitude:85.35213}, {node:151, latitude:27.70282, longitude:85.35218}, {node:152, latitude:27.70252, longitude:85.35232}, {node:153, latitude:27.70093, longitude:85.35353}, {node:154, latitude:27.70071, longitude:85.35373}, {node:155, latitude:27.70019, longitude:85.35411}]};
		
		
		
		
		
		//#         NEED TO HAVE ETA TO NEXT BUS STOP              
		
		

			var vehicle1={name:"BA 10 PA 3474", current_location:"Kalimati Road", latitude:27.70862, longitude:85.33222, nextStop:"Kalimati Bus Station", eta:"12 mins", schedule:"12:45"};
			var vehicle2={name:"BA 10 PA 3475", current_location:"Kalimati Road", latitude:27.70830, longitude:85.33338, nextStop:"Kalimati Bus Station", eta:"5 mins", schedule:"12:45"};
			var vehicle3={name:"BA 10 PA 3476", current_location:"Kalimati Road", latitude:27.71050, longitude:85.32198, nextStop:"Kalimati Bus Station", eta:"8 mins", schedule:"12:45"};
			var vehicle4={name:"BA 10 PA 3477", current_location:"Kalimati Road", latitude:27.70921, longitude:85.32938, nextStop:"Kalimati Bus Station", eta:"12 mins", schedule:"12:45"};
	  
	  //This variable holds route data, along with bus stop and route way information.
	  var routeCollection = [];
	  	  
	  //This function loads all the required data from the server.
	  function loadData(){
		//####################Server codes here.#################################################
		//first get the all route collection.
		$("#loading").fadeIn();
		$("#map_view_tab_container").hide();
		
		//routeCollection.push(route1);
		
		console.log("loading new vehicle tracking data.");
		setTimeout(function(){
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : "load_tracking_routes",
				dataType : 'json',
				timeout : 300000,
				success : function(data) {
					console.log("SUCCESS LOADING ROUTE DATA FOR TRACKING.");
					//updateRouteServerStatus = status;
					routeCollection = data;
						 // alert(activeVehiclesCollection.length);
					  if(routeCollection.length==0){
						//alert("ranjit");
						$("#no_content_error_message").slideDown().fadeIn();
						$("#map_view_tab").hide();
					  }
					  else{
						//writing the route name in select route button dropdown.
							jQuery.each(routeCollection, function(i, route){
								//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
								$('#select_route_dropdown').append('<li><a style="font-size:12px; cursor:pointer">'+route.name+'</a></li>');
							});
							
							
							//initially setting side panel tables not available since, till now no bus stop data are downloaded. it is only downloaded when user select particular route from the dropdown list.
							$("#active_vehicle_side_table_list_not_available_message").fadeIn();
							$("#active_vehicle_side_table_list").hide();		//hiding the table
								$("#active_vehicle_count").text(0);
						
						  
							$("#flagged_vehicle_side_table_not_available_message").fadeIn();
							$("#flagged_vehicle_side_table_list").hide();		//hiding the table
							$("#flagged_vehicle_count").text(0);	
							
						}
						
						$("#loading").fadeOut();					
						$("#map_view_tab_container").fadeIn();
						//for map invalid display						
						setTimeout(function(){map.invalidateSize()},500);
						setTimeout(function(){map.invalidateSize()},1000);
						setTimeout(function(){map.invalidateSize()},3000);
						setTimeout(function(){map.invalidateSize()},4000);
				},
				error : function(e) {
					console.log("ERROR WHILE LOADING ROUTE DATA FOR TRACKING.");
					//updateRouteServerStatus = false;	
					routeCollection = [];		
					$("#no_content_error_message").slideDown().fadeIn();
					$("#map_view_tab").hide();
					$("#loading").fadeOut();					
					$("#map_view_tab_container").fadeIn();
					//for map invalid display						
					setTimeout(function(){map.invalidateSize()},500);
					setTimeout(function(){map.invalidateSize()},1000);
					setTimeout(function(){map.invalidateSize()},3000);
					setTimeout(function(){map.invalidateSize()},4000);
					
				},
				done : function(e) {
					console.log("DONE");
					//updateRouteServerStatus = true;
				}
			});
		},600);
		
	
		
		//#######################################################################################
	  }	  
	  loadData();
	  
	  
	  //################################SERVER CODES ######################################


	  //this variable holds the flagged and not flagged vehicle information
	  var activeVehiclesCollection = [];
	  var flaggedVehiclesCollection = [];
	  
	  console.log("ranjit: "+activeVehiclesCollection.length);
	  
	  //this fucntion gets all the vehicle for particular routee.
	  function getVehiclesFromServer(type, routeName, refresh){	

		console.log("Getting vehicle data. "+ activeVehiclesCollection.length);
		setTimeout(function(){
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getVehicles",
				data : routeName,
				dataType : 'text',
				timeout : 300000,
				success : function(result) {
					console.log("SUCCESS LOADING VEHICLES FOR TRACKING.");
					
					var data = JSON.parse(result);
					activeVehiclesCollection = data.activeVehicles;		
					flaggedVehiclesCollection = data.flaggedVehicles;
					console.log(activeVehiclesCollection.length);
					
					if(type==1){
						console.log("First time data load.");
						afterVehicleDataDownload(true,  routeName);						
					}else{
						console.log("Background vehicle location update.");
						afterIntervalledUpdate(true, refresh, routeName);
					}
				},
				error : function(e) {
					console.log("ERROR WHILE LOADING VEHICLES FOR TRACKING.");
					if(type==1){
						console.log("First time data load.");
						afterVehicleDataDownload(false, routeName);						
					}else{
						console.log("Background vehicle location update.");
						afterIntervalledUpdate(false, refresh, routeName);
					}
				},
				done : function(e) {
					console.log("DONE");
					//updateRouteServerStatus = true;
				}
			});
		},200);
	  }
	  
	  	  
	//this function sends a vehicle to server to flag it.
	function flagVehicleToServer(vehicleName, vehicle){
		console.log("Flagging vehicle.");
		setTimeout(function(){
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : "flag_vehicle",
				data : vehicleName,
				dataType : 'text',
				timeout : 300000,
				success : function(result) {
					console.log("SUCCESS LOADING VEHICLES FOR TRACKING :"+result);	
					if(result='true' || result==true){						
						afterFlagAction(true, vehicle, vehicleName);
					}else{						
						afterFlagAction(false, vehicle, vehicleName);
					}

				},
				error : function(e) {
					console.log("ERROR WHILE LOADING VEHICLES FOR TRACKING.");
					afterFlagAction(false, vehicle, vehicleName);
				},
				done : function(e) {
					console.log("DONE");
					//updateRouteServerStatus = true;
				}
			});
		},200);
	}
  
  
	  
	  //this function unflag the vehicle
	  function unFlagVehicleToServer(vehicleName, vehicle){
		console.log("Un flagging vehicle.");
		setTimeout(function(){
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : "unflag_vehicle",
				data : vehicleName,
				dataType : 'text',
				timeout : 300000,
				success : function(result) {
					console.log("SUCCESS LOADING VEHICLES FOR TRACKING : "+result);
					afterUnFlagAction(result, vehicle, vehicleName);
					if(result='true' || result==true){	
						afterUnFlagAction(true, vehicle, vehicleName);
					}else{						
						afterUnFlagAction(false, vehicle, vehicleName);
					}

				},
				error : function(e) {
					console.log("ERROR WHILE LOADING VEHICLES FOR TRACKING.");
					afterUnFlagAction(false, vehicle, vehicleName);
				},
				done : function(e) {
					console.log("DONE");
					//updateRouteServerStatus = true;
				}
			});
		},200);
	  }
	  
	  
	  
	  //######################################################################################
	  
	  
	  
	  
	  
	  
	  
	  //########################MAP VIEW TAB SECTION####################################################

	  
	  //this function activate the tracking option for the selected route.
	  //@parameter need to be route name.
	  
	  function activateTracking(routeName){
		 //Checking if the route have a route way or not.
		/* var route_way_available_status = false;	//initially routeway is not available
		jQuery.each(routeCollection, function(i, routeObject){
			//alert(JSON.stringify(routeObject.wayLine));
			if(routeObject.name==routeName && routeObject.wayLine.length!=0){	
				route_way_available_status = true;
			}			
		});	*/
		  
		//alert(route_way_available_status);
		  
		//first get all the active and inactive vehicles lists.
			
		//emptying the old table as well.
		$("#active_vehicle_side_table_list tbody").empty();
		$("#flagged_vehicle_side_table_list tbody").empty();
		
		
		//##############SERVER CODE TO DOWNLOAD VEHICLE DETAILS ############################################
		
		getVehiclesFromServer(1, routeName, null);
	
		//##################################################################################################
	  }
	  
	  function afterVehicleDataDownload(serverStatus, routeName){
		  		
			if(serverStatus==true){
			//checking and adding the vehicle to the page left panel table.
			
			console.log("apple");
				if(activeVehiclesCollection.length==null){
					console.log("ball");
				$("#active_vehicle_side_table_list_not_available_message").fadeIn();
				$("#active_vehicle_side_table_list").hide();		//hiding the table
					$("#active_vehicle_count").text(0);
				  }
				  else{
				  
					//writing the active vehicle name to the table.
					jQuery.each(activeVehiclesCollection, function(i, vehicle){				
						$("#active_vehicle_side_table_list tbody").append('<tr tabindex="1"><td>'+parseInt(i+1)+'</td><td><span style="padding-top:4px">'+vehicle.name+'</span> <span style="margin-left:8px;margin-right:8px;float:right; color:green; cursor:pointer; display:nones" data-toggle="tooltip" data-placement="top" title="Flag This" class="glyphicon glyphicon-flag" onmouseover="displayTooltip(this)" onclick="flagVehicle(this)"></span><a><span style="float:right; margin-left:8px;; margin-right:8px; cursor:pointer; display:nones"  class="glyphicon glyphicon-globe" data-toggle="tooltip" data-placement="top" title="View on Map" onmouseover="displayTooltip(this)" onclick="viewSingleVehicleInMap(this)"></span></a><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:18px;width:18px;background-size: 18px 18px;background-repeat: no-repeat;"></span></td></tr>');
					});
					
					$("#active_vehicle_side_table_list_not_available_message").slideUp().fadeOut();
					$("#active_vehicle_side_table_list").fadeOut().delay(400).slideDown(1000).fadeIn();
					//setting the count
					$("#active_vehicle_count").text(activeVehiclesCollection.length);
					
					//for list view tabl section table
					
					//displaying the active vehicle list data.
					$("#loading1").fadeIn();
					setTimeout(function(){						
						displayListViewTable();
						$("#loading1").fadeOut();
						$("#list_view_tab_header_route_name").text(routeName);
					},600);
				  }
				  
				  
					//if no flagged vehicle available.
				  if(flaggedVehiclesCollection.length==0){
					$("flagged_vehicle_side_table_not_available_message").fadeIn();
					$("#active_vehicle_side_table_list").hide();		//hiding the table
					$("#flagged_vehicle_count").text(0);
				  }
				  else{
					//then adding the flagged vehicle list to the side table.
					jQuery.each(flaggedVehiclesCollection, function(i, vehicle){				
						$("#flagged_vehicle_side_table_list tbody").append('<tr tabindex="1"><td>'+parseInt(i+1)+'</td><td><span>'+vehicle.name+'</span> <span style="float:right; color:red; cursor:pointer;margin-left:8px;margin-right:8px;" data-toggle="tooltip" data-placement="top" title="UnFlag This" class="glyphicon glyphicon-flag" onmouseover="displayTooltip(this)" onclick="unFlagVehicle(this)"></span><a><span style="float:right; margin-left:8px;margin-right:8px; cursor:pointer" class="glyphicon glyphicon-globe" data-toggle="tooltip" data-placement="top" title="View on Map" onmouseover="displayTooltip(this)" onclick="viewSingleVehicleInMap(this)"></span></a><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:18px;width:18px;background-size: 18px 18px;background-repeat: no-repeat;"></span></td></tr>');
					});
					
					$("#flagged_vehicle_side_table_not_available_message").slideUp().fadeOut();
					$("#flagged_vehicle_side_table_list").fadeOut().delay(400).slideDown(1000).fadeIn();
					
					//setting the count
					$("#flagged_vehicle_count").text(flaggedVehiclesCollection.length);
					
					//displaying the flagged vehicle list data.
					$("#loading1").fadeIn();
					setTimeout(function(){						
						displayFlaggedTable();
						$("#loading1").fadeOut();
						$("#flagged_tab_header_route_name").text(routeName);
					},600);
				  }
				  
				//setting the map. displaying the route.
				displayRouteOnMap(routeName);
				//displaying all vehicle of that route.
				//displayAllVehiclesOnMap(routeName);	this is already inside displayRouteOnMap().		
			}
			else{			
				 $("#loading").fadeOut();
				$("#alert_modal_title").text("ERROR OCCURED");
				$("#alert_modal_content").text("Something went wrong. Cannot download the vehicle list at the moment. Please, try again later.");
				$("#alert_modal").modal('show');				
			}
			  
			  
			//setting the header description.
			//alert(routeName);
			$("#header_description_route_name").text(routeName);
			$("#header_description_active_count").text(activeVehiclesCollection.length);
			$("#header_description_flagged_count").text(flaggedVehiclesCollection.length);
	  }
	  
	  
	  //this funciton display the tooltip on parameter componenet
	  function displayTooltip(component){
		$(component).tooltip('show');
	  }
	  
	  
			
		//this function shifts the row to flagged list vehicle
		function shiftRowToFlaggedList(row, vehicleName){	
				$(row).parent().parent().focus();				
				$(row).parent().parent().fadeOut(500, function(){
					$(this).remove();
					if($("#flagged_vehicle_side_table_list tbody").children().length==0){
						$("#flagged_vehicle_side_table_not_available_message").fadeIn();
						$("#flagged_vehicle_side_table_list").hide();		//hiding the table
						$("#flagged_vehicle_count").text(0);
					}
				});
			
				var i = $("#flagged_vehicle_side_table_list tbody").children().length;						
				//Adding the row to the NOT ADDED Table				
				$("#flagged_vehicle_side_table_list tbody").delay(200).append('<tr tabindex="1"><td>'+parseInt(i+1)+'</td><td><span>'+vehicleName+'</span> <span style="float:right; color:red; cursor:pointer;margin-left:8px;margin-right:8px;" data-toggle="tooltip" data-placement="top" title="UnFlag This" class="glyphicon glyphicon-flag" onmouseover="displayTooltip(this)" onclick="unFlagVehicle(this)"></span><a><span style="float:right; margin-left:8px;margin-right:8px; cursor:pointer" class="glyphicon glyphicon-globe" data-toggle="tooltip" data-placement="top" title="View on Map" onmouseover="displayTooltip(this)" onclick="viewSingleVehicleInMap(this)"></span></a><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:18px;width:18px;background-size: 18px 18px;background-repeat: no-repeat;"></span></td></tr>').fadeIn();
				$("#flagged_vehicle_side_table_list tbody tr:last").focus().css({color:"#673AB7"});				
		}
		
		
		//this function shifts the row to active list vehicle.
		function shiftRowToActiveList(row, vehicleName){	
				$(row).parent().parent().focus();				
				$(row).parent().parent().fadeOut(500, function(){
					$(this).remove();
					if($("#active_vehicle_side_table_list tbody").children().length==0){
						$("#active_vehicle_side_table_list_not_available_message").fadeIn();
						$("#active_vehicle_side_table_list").hide();		//hiding the table
						$("#active_vehicle_count").text(0);
					}
				});
			
				var i = $("#active_vehicle_side_table_list tbody").children().length;						
				//Adding the row to the NOT ADDED Table				
				$("#active_vehicle_side_table_list tbody").delay(200).append('<tr tabindex="1"><td>'+parseInt(i+1)+'</td><td><span style="padding-top:4px">'+vehicleName+'</span> <span style="margin-left:8px;margin-right:8px;float:right; color:green; cursor:pointer; display:nones" data-toggle="tooltip" data-placement="top" title="Flag This" class="glyphicon glyphicon-flag" onmouseover="displayTooltip(this)" onclick="flagVehicle(this)"></span><a><span style="float:right; margin-left:8px;; margin-right:8px; cursor:pointer; display:nones"  class="glyphicon glyphicon-globe" data-toggle="tooltip" data-placement="top" title="View on Map" onmouseover="displayTooltip(this)" onclick="viewSingleVehicleInMap(this)"></span></a><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:18px;width:18px;background-size: 18px 18px;background-repeat: no-repeat;"></span></td></tr>').fadeIn();
				$("#active_vehicle_side_table_list tbody tr:last").focus().css({color:"#673AB7"});				
		}
		
		
		//this function flags a particular vehicle when clicked 
		function flagVehicle(vehicle){
			var vehicleName = $(vehicle).parent().find("span:nth-child(1)").text();
			//alert(vehicleName);
			
			//hiding the option and displaying the loading animation.
			$(vehicle).parent().find("span:nth-child(2)").hide();
			$(vehicle).parent().find("a").hide();
			$(vehicle).parent().find("span:last").fadeIn();		///loading animation
			
			setTimeout(function (){
				//###############SERVER CODE TO FLAG VEHICLE ###############################
				//send the flag to server to flag it.
				flagVehicleToServer(vehicleName, vehicle);
				
				//##########################################################################
		
			},800);			
		}
		
		//triggered from ajax.
		function afterFlagAction(serverStatus, vehicle, vehicleName){
				if(serverStatus==true){
					//shifting the row to flagged list.
					shiftRowToFlaggedList(vehicle, vehicleName);
										
					//adding vehicle to flagged local array and removing it from active array.
					//alert(JSON.stringify(activeVehiclesCollection));
					//alert(JSON.stringify(flaggedVehiclesCollection));
					
					jQuery.each(activeVehiclesCollection, function(i, vehicle){
						//alert(JSON.stringify(vehicle));
						if(vehicle.name==vehicleName){
						//alert("aoole");
							flaggedVehiclesCollection.push(vehicle);	//adding it to flagged vehicle list.
							activeVehiclesCollection.splice(activeVehiclesCollection.indexOf(vehicle),1);	//removing it fro m active.
							
							//change the marker color too..
							changeMarkerFlagStatus(vehicle, "flag");
							
							
							//changing the vehicle count on badgees.
							$("#active_vehicle_count").text(activeVehiclesCollection.length);
							$("#flagged_vehicle_count").text(flaggedVehiclesCollection.length);
														
							$("#header_description_active_count").text(activeVehiclesCollection.length);
							$("#header_description_flagged_count").text(flaggedVehiclesCollection.length);
	
							return false;
						}
					});					
					//alert(JSON.stringify(activeVehiclesCollection));
					//alert(JSON.stringify(flaggedVehiclesCollection));
					
				}
				else{				
					$(vehicle).parent().find("span:last").fadeOut();  //loading animation hide
					$(vehicle).parent().find("span:nth-child(2)").fadeIn();
					$(vehicle).parent().find("a").fadeIn();
					
					
					$("#vehicle_flag_unflag_server_error").hide();
					$("#vehicle_flag_unflag_server_error strong").text("ERROR OCCURED");
					$("#vehicle_flag_unflag_server_error small").text(" Something went wrong. Cannot flag vehicle at the moment. Please, try again later.");
					$("#vehicle_flag_unflag_server_error").slideDown().fadeIn();
					setTimeout(function(){					
						$("#vehicle_flag_unflag_server_error").slideUp().fadeOut();
					},5000);
				}	
		}
		
		
		//this funciton unflag a particular vehicle
		function unFlagVehicle(vehicle){		
			var vehicleName = $(vehicle).parent().find("span:nth-child(1)").text();
			//alert(vehicleName);
			
			//hiding the option and displaying the loading animation.
			$(vehicle).parent().find("span:nth-child(2)").hide();
			$(vehicle).parent().find("a").hide();
			$(vehicle).parent().find("span:last").fadeIn();		///loading animation
			
			setTimeout(function (){
				//###############SERVER CODE TO FLAG VEHICLE ###############################
				//send the flag to server to flag it.
				var serverStatus = unFlagVehicleToServer(vehicleName, vehicle);
				
				//##########################################################################
			
			},800);	
		}
		
		
		function afterUnFlagAction(serverStatus, vehicle, vehicleName){
			if(serverStatus==true){
					//shifting the row to flagged list.
					shiftRowToActiveList(vehicle, vehicleName);
					
					//adding vehicle to flagged local array and removing it from active array.
					//alert(JSON.stringify(activeVehiclesCollection));
					//alert(JSON.stringify(flaggedVehiclesCollection));
					
					jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
						//alert(JSON.stringify(vehicle));
						if(vehicle.name==vehicleName){
						//alert("aoole");
							activeVehiclesCollection.push(vehicle);	//adding it to flagged vehicle list.
							flaggedVehiclesCollection.splice(flaggedVehiclesCollection.indexOf(vehicle),1);	//removing it fro m active.
							
							//alert(flaggedVehiclesCollection.length);
							//change the marker color too..
							changeMarkerFlagStatus(vehicle, "active");
							
							//changing the vehicle count on badgees.
							$("#active_vehicle_count").text(activeVehiclesCollection.length);
							$("#flagged_vehicle_count").text(flaggedVehiclesCollection.length);
														
							$("#header_description_active_count").text(activeVehiclesCollection.length);
							$("#header_description_flagged_count").text(flaggedVehiclesCollection.length);
								
							return false;
						}
					});					
					//alert(JSON.stringify(activeVehiclesCollection));
					//alert(JSON.stringify(flaggedVehiclesCollection));
					
				}
				else{				
					$(vehicle).parent().find("span:last").fadeOut();  //loading animation hide
					$(vehicle).parent().find("span:nth-child(2)").fadeIn();
					$(vehicle).parent().find("a").fadeIn();
					
					
					$("#vehicle_flag_unflag_server_error").hide();
					$("#vehicle_flag_unflag_server_error strong").text("ERROR OCCURED");
					$("#vehicle_flag_unflag_server_error small").text(" Something went wrong. Cannot flag vehicle at the moment. Please, try again later.");
					$("#vehicle_flag_unflag_server_error").slideDown().fadeIn();
					setTimeout(function(){					
						$("#vehicle_flag_unflag_server_error").slideUp().fadeOut();
					},5000);
				}
		}
		
		
		//creating group layer for route and vehicle.
		var routeMarkersLayer = L.layerGroup();	
		var vehicleMarkersLayer = L.layerGroup();		
		
		//this funciton display or focus the particular (parameter added) vehicle on the map.
		function viewSingleVehicleInMap(vehicle){			
			var vehicleName = $(vehicle).parent().parent().find("span:nth-child(1)").text();
						
			//clearing the previous selected/displayed marker if the map view mode option is single view.
			if(mapViewModeSelectedOption==4){			
				vehicleMarkersLayer.clearLayers();
				//searching in both collection/ Im lazy enough to get the type (active. or flagged) from the row, it would be possible though but lengthy.
				
				jQuery.each(activeVehiclesCollection, function(i, vehicle){
					if(vehicle.name == vehicleName){
						addMarkerInMap(vehicleMarkersLayer, vehicle, 'green');
						return false;
					}
				});
				jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
					if(vehicle.name == vehicleName){
					//alert("flagged found");
						addMarkerInMap(vehicleMarkersLayer, vehicle, 'cadetblue');
						return false;
					}
				});
			}
			
			vehicleMarkersLayer.eachLayer(function (layer) {
				if(layer.options.icon.options.name==vehicleName){
					layer.openPopup();
					setRouteWayMapView([ layer.options.icon.options.latitude,layer.options.icon.options.longitude], 18, true, true);	
				}
			});
		}
		
		
		
		//this variable holds the current displayed route name, this variable is especially used by changeMapViewMode() method to call displayAllVehiclesOnMap() function.
		var currentDisplayedRoute;
		
		var mapWayLine;  		/// so that route way can be explitly removed later.
		//this funciton display route on the map, takes route name as parameter.
		function displayRouteOnMap(routeName){
			//setting the value 
			currentDisplayedRoute = routeName;
			
			//clearing any previous layers.
			routeMarkersLayer.clearLayers();
			vehicleMarkersLayer.clearLayers();
			
			//map.removeLayer(mapWayLine);
						
			var wayLine;
			var stops;

			//alert(route+"---ranjit--"+route);
			//getting wayline and stops for the selected route.
			jQuery.each(routeCollection, function(i, routeObject){
				//alert(JSON.stringify(routeObject.wayLine));
				if(routeObject.name==routeName){					
					wayLine = routeObject.wayLine;					
					//alert(JSON.stringify(wayLine));
					stops = routeObject.stops;				
					//alert(JSON.stringify(stops));
					return false;
				}			
			});	

			//now, extracting only array of longitude and latitude.
			var routeLine = [];
			jQuery.each(wayLine, function(i, node){
				var lngLat = [node.latitude, node.longitude];
				routeLine.push(lngLat);
			});
			
			//checking if wayline is empty or not./i.e. not available or not.
			if(wayLine.length==0){
				$("#vehicle_flag_unflag_server_error").hide();
				$("#vehicle_flag_unflag_server_error strong").text("ROUTE WAY UNAVAILABLE");
				$("#vehicle_flag_unflag_server_error small").text(" Unable to start tracking. Currently, the route way for this route is not available. ");
				$("#vehicle_flag_unflag_server_error").slideDown().fadeIn();
				setTimeout(function(){					
					$("#vehicle_flag_unflag_server_error").slideUp().fadeOut();
				},6000);
				$("#loading").hide();
			}
			else{
				//alert("wayline");
				//adding the wayline to the map.
				mapWayLine = new L.polyline(routeLine);	
				
				var lineWithDirection = L.polylineDecorator(mapWayLine, {
					patterns: [
						{ offset: '5%', repeat: '10%',symbol: L.Symbol.arrowHead({pixelSize: 10, polygon: false, pathOptions: {stroke: true}})}
					]
				});
				
				
				routeMarkersLayer.addLayer(lineWithDirection);
				routeMarkersLayer.addLayer(mapWayLine);
				
				//map.addLayer(mapWayLine);   //note these are working the other way on the comment out code below. why? may be bug?  Ans: worked above way. add both line and direction.
				
				//adding the bus stops to the map.
				jQuery.each(stops, function(i, stop){
					var stopMarker = L.circleMarker([stop.latitude, stop.longitude]).bindLabel(stop.name, { noHide: false, offset:[15,-15],opacity:1});	
					//stopMarker.setZIndexOffset(1);
					routeMarkersLayer.addLayer(stopMarker);
				});

				//now displaying all the available vehicles.
				displayAllVehiclesOnMap(routeName);
					
			}
		}
		
		
		//this funciton displays all the vehicle of a selected route on the map
		function displayAllVehiclesOnMap(routeName){			
			//clearing previous markers
			vehicleMarkersLayer.clearLayers();
			
			if(mapViewModeSelectedOption=="1"){
				//adding active vehicle markers.
				jQuery.each(activeVehiclesCollection, function(i, vehicle){
					addMarkerInMap(vehicleMarkersLayer, vehicle, 'green');
				});
				//adding flagged vehicle markers.
				jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
					addMarkerInMap(vehicleMarkersLayer, vehicle, 'cadetblue');
				});
			}
			else if(mapViewModeSelectedOption=="2"){
				//adding active vehicle markers.
				jQuery.each(activeVehiclesCollection, function(i, vehicle){
					addMarkerInMap(vehicleMarkersLayer, vehicle, 'green');
				});
			}
			else if(mapViewModeSelectedOption=="3"){
			//adding flagged vehicle markers.
				jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
					addMarkerInMap(vehicleMarkersLayer, vehicle, 'cadetblue');
				});
			}
			else if(mapViewModeSelectedOption=="4"){	
				//need to do nothing. map is cleared already. so here is the logic. whenever, this option is selected, the map layer already empty so only one marker is displayed. In addition, when user clicked another marker, a clear vehiclemarkerlayer is triggered on displayRouteOnMap() method. So, this method ie executed everytime a vehicle is clicked and this method will delete any previous marker if the option is single mode.
			}
				
			//downloading vehicle information in every one minute.
			setToIntervalledRefreshAllVehicleData(routeName, 15000);			//one minute interval refresh time.
		}
		
		
		//this function refresh the vehicle data in loop.
		function setToIntervalledRefreshAllVehicleData(routeName, time){
			var refresh = setTimeout(function(){
				//hiding the loading button if this is triggered from the refresh button not automatic.
				$("#map_view_vehicle_list_refresh_loading").hide();
				
				//first downloading data from server.
				//alert("re-downloading data now.");
				//################################################################################################################
				
				
				var serverStatus = getVehiclesFromServer(2, routeName, refresh);
				
				
				//##################################################################################################################
							
			},time);	
		}
		
		//after intervalled update
		function afterIntervalledUpdate(serverStatus, refresh, routeName){
				if(serverStatus==true){				
					displayAllVehiclesOnMap(routeName);
				}
				else{				
					$("#vehicle_data_download_server_error").hide();
					$("#vehicle_data_download_server_error strong").text("ERROR OCCURED");
					$("#vehicle_data_download_server_error small").text(" Something went wrong. Cannot update vehicle position at the moment. Please, try again later.");
					$("#vehicle_data_download_server_error").slideDown().fadeIn();
					//setTimeout(function(){					
						//$("#vehicle_data_download_server_error").slideUp().fadeOut();
						
								
					//displaying and adding listener to refresh button 
					$("#vehicle_data_download_server_error_refresh_button").off();
					$("#vehicle_data_download_server_error_refresh_button").on('click', function(){					
						$("#vehicle_data_download_server_error_refresh_loading").fadeIn();
						setTimeout(function(){						
							$("#vehicle_data_download_server_error_refresh_loading").hide();
							setToIntervalledRefreshAllVehicleData(routeName, 100);
						},3000);
					});
					//},5000);
					clearTimeout(refresh);		//exiting out of loop of re-downloading if error occured.
				}
			
		}
			
		//initializing and creating map object
		var map;
		function initializeMap(){
			map =new L.Map("map", {
				layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true, attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'})]	
			});	
			map.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.
			//displayResetButtonInMap();
			
			setTimeout(function(){map.invalidateSize()},50);	  //must use timeout otherwise not work. since loadBustDetail has timeout 600. must match.
			setTimeout(function(){map.invalidateSize()},500);
			setTimeout(function(){map.invalidateSize()},1000);
			//revalidating again.. in case if page is displayed from add.when there no bus details are available to display. map is directly displayed when adding new bus stop. in this case we need to lately validate the map. otherwise not displayed properly.
			setTimeout(function(){map.invalidateSize()},2000);
			
			//adding the marker layer.
			map.addLayer(routeMarkersLayer);
			map.addLayer(vehicleMarkersLayer);
		}
		initializeMap();
				
				
		//this function set and displays map default location. 
		function setRouteWayMapView(latlng, zoom, animate_option, reset_option){
			var default_position = latlng;
			map.setView([default_position[0],default_position[1]], zoom, {animate: animate_option, reset: reset_option});
			map.zoomIn(1, {animate: true});
		};
		setRouteWayMapView([ 27.707011230127296,85.31444102525711], 13, true, true);	
		
		
		
			
		//this function add the marker in the map 
		function addMarkerInMap(markersGroup, vehicle, color){
		
			//id:name to use as reference.
			markersGroup.addLayer(L.marker([vehicle.latitude,vehicle.longitude], 
				{
					draggable:false,
					icon: L.AwesomeMarkers.icon(
						{
							name:vehicle.name,
							latitude:vehicle.latitude,
							longitude:vehicle.longitude,
							icon: '',
							prefix: 'fa',
							markerColor: color,
							html:('<span><img src="${busIcon}" height="24" width="24" style="margin-top:-2px; padding:2px"></span>')
						}
					)
				}) 
				.setZIndexOffset(999)
				.bindPopup(vehicle.name+", Next Stop: "+vehicle.nextStop+", ETA: "+vehicle.eta+", Current Location: "+vehicle.current_location+", Lng/Lat: "+vehicle.latitude+","+vehicle.longitude).openPopup()
				.bindLabel(vehicle.name, {noHide: true, offset:[-48,-68],opacity:1})
			);	
		}
		
		
		
		
		
		
		
		
		
		
		
		
		//MAP CODES #################################################################################
		
		//this function change the marker color of particular vehicle
		function changeMarkerFlagStatus(vehicle, type){
			vehicleMarkersLayer.eachLayer(function(layer) {
			if(layer.options.icon.options.name==vehicle.name){
				vehicleMarkersLayer.removeLayer(layer);
				if(type=="flag"){
					addMarkerInMap(vehicleMarkersLayer, vehicle, "cadetblue");
				}
				else{
					addMarkerInMap(vehicleMarkersLayer, vehicle, "green");				
				}
				
				//this will resolve the map view freezee when vehicle is flagged or flagged from another tabs.
				if(globalTabName=="map_view"){
					setRouteWayMapView([ vehicle.latitude,vehicle.longitude], 18, true, false);
				}				
			}
			});
		}
		
		
		var mapViewModeSelectedOption = 1;
		//this function is triggered on change state of dropdown of view mode. this functions sets the above variable which will be used when displaying markers on map by displayAllVehiclesOnMap funciton.
		function changeMapViewMode(dropdown){
		if(currentDisplayedRoute==null || currentDisplayedRoute=='undefined'){	
				$("#alert_modal_title").text("VIEW MODE UN-AVAILABLE");
				$("#alert_modal_content").text("Cannot change the view mode. Currently, no Route is selected. Please, select a route and try again.");
				$("#alert_modal").modal('show');	
				$(dropdown).val(1); //setting default mode
			}
			else{			
				mapViewModeSelectedOption = mapViewModeSelectedOption = $(dropdown).val();	
				//displaying vehicle in map
				displayAllVehiclesOnMap(currentDisplayedRoute);
			}
		}
		
		
		
		
		
		//Map view tab on shown listener implementation
		
		//my program have some bug. when a vehicle is flagged unflagged from listview or flagged tab. map get freeze on high level zoom. example in screenshot.computer.
		  $("body").on("shown.bs.tab", "#map_view", function() {
		  
		  
							setTimeout(function(){
			setRouteWayMapView([ 27.707011230127296,85.31444102525711], 13, true, true);
			map.invalidateSize()},50);	  //must use timeout otherwise not work. since loadBustDetail has timeout 600. must match.
			setTimeout(function(){map.invalidateSize()},500);
			setTimeout(function(){map.invalidateSize()},1000);
			//revalidating again.. in case if page is displayed from add.when there no bus details are available to display. map is directly displayed when adding new bus stop. in this case we need to lately validate the map. otherwise not displayed properly.
			setTimeout(function(){map.invalidateSize()},2000);
		  });
		
		
		
		//############################################################################################################################################################
		
		
	  //################################################################### LIST VIEW SECTION ########################################################################	  
	  
	  
	  
	  
	  
	  
	  $("body").on("shown.bs.tab", "#list_view", function() {
		//firstTimeTabLoadinAnimation();
		
		//disabling the dropdown
		$("#map_view_mode_dropdown_select").prop("disabled", true);	
		
		//displaying the active vehicle list data.
		displayListViewTable();
		
		//setting the routename on the header
		if(currentDisplayedRoute==null || currentDisplayedRoute=='undefined'){
			$("#list_view_tab_header_route_name").text("NOT AVAILABLE");		
		}
		else{
			$("#list_view_tab_header_route_name").text(currentDisplayedRoute);
		}
		
		
		//activating refresh button
		$("#list_view_refresh_button").off();
		$("#list_view_refresh_button").on('click',function(){
			$("#loading1").fadeIn();			
		$("#list_view_refresh_button").prop('disabled',true);
			setTimeout(function(){
				setToIntervalledRefreshAllVehicleData(currentDisplayedRoute, 100);
				displayListViewTable();
								
				$("#list_view_refresh_button").prop('disabled',false);
				
				//displaying refresh time
				var date = new Date();
				$("#active_tab_hour").text(date.getHours());
				$("#active_tab_min").text(date.getMinutes());
				$("#active_tab_sec").text(date.getSeconds());
				$("#loading1").fadeOut();
			},1000);
		});
		
		
	  });
	  
	  
	  $("body").on("hidden.bs.tab", "#list_view", function() {
		$("#map_view_mode_dropdown_select").prop("disabled", false);	
	  });
	  
	  //this function write active vehicle data to the table on list view tab
	  function displayListViewTable(){
		if(activeVehiclesCollection.length==0){
			$("#active_vehicle_not_available_status").fadeIn();
			$("#list_view_table").hide();
			$("#list_view_refresh_button").prop('disabled',true);
		}
		else{		
		
			//alert(activeVehiclesCollection.length);
			$("#active_vehicle_not_available_status").hide();
			$("#list_view_table tbody").empty();
			jQuery.each(activeVehiclesCollection, function(i, vehicle){
				$("#list_view_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+vehicle.name+'</td><td>'+vehicle.current_location+'</td><td style="text-align:center">'+vehicle.latitude+'</td><td style="text-align:center">'+vehicle.longitude+'</td><td>'+vehicle.nextStop+'</td><td style="text-align:center">'+vehicle.eta+'</td><td style="text-align:center">'+vehicle.schedule+'</td><td><button type="button" class="btn btn-xs btn-block" style="background:none; border:1px solid black; float:right; margin:0px; padding:0px" onclick="listViewFlagVehicle(this)"><span class="glyphicon glyphicon-flag" aria-hidden="true"></span> <span>Flag It </span><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:12px;width:12px;background-size: 12px 12px;background-repeat: no-repeat;"></span></button></td></tr>');		
			});
			$("#list_view_table").fadeIn();		
			$("#list_view_refresh_button").prop('disabled',false);
		}
	  }
	  
	  
	  //this function flag a particular vehicle in list_view tab.
	  function listViewFlagVehicle(button){
		var vehicleName = $(button).parent().parent().find("td:nth-child(2)").text();
		$(button).parent().find("span:last").fadeIn();
		setTimeout(function(){
			
			jQuery.each(activeVehiclesCollection, function(i, vehicle){
				//alert(JSON.stringify(vehicle));
				if(vehicle.name==vehicleName){
				
					//alert($("#active_vehicle_side_table_list").find("tr:nth-child(" + 2 + ")").find("td:nth-child(2)").text()+"         -        "+vehicleName);
					
					//since the following flagVehicle need a row as paremeter, we need to get that row first.
					//jQuery.each(function(i, val){
					
					//generating the array of vehicle name from the table.
					//var tableVehicleNameList = $("#active_vehicle_side_table_list tbody").children().find("td:nth-child(2)").text();
					//var tableRowIndex = 1;		//initial row count of the table.
					var row;
					for(var i=0; i<$("#active_vehicle_side_table_list tbody").children().length;i++){
						var tableVehicleName = $("#active_vehicle_side_table_list tbody").find("tr:nth-child(" + parseInt(i+1) + ")").find("td:nth-child(2)").text();
						//alert(":"+tableVehicleName+":");
						//alert(":"+vehicleName+":");
						if(tableVehicleName.trim() == vehicleName){
							//alert("true");
							row = $("#active_vehicle_side_table_list").find("tr:nth-child(" + parseInt(i+1) + ")").find("td:nth-child(2) span:nth-child(2)");
							//alert($("#active_vehicle_side_table_list").find("tr:nth-child(" + i + ")"));
							break;
						}
					}
					
					//getting the row index from the table by counting it in loop and matching with out name.
					/*jQuery.each(tableVehicleNameList, function(i, vehicle){
						if(vehicle == vehicleName){
							tableRowIndex = tableRowIndex+i;
							return false;
						}
					});*/
					
					//now getting the row of that table index row.
					//var row = $("#active_vehicle_side_table_list tbody").find("tr:nth-child(" + tableRowIndex + ")");
					flagVehicle(row);
					return false;
				}
			});	
			$(button).parent().find("span:nth-child(2)").text("Flagged").css({"color":"red","font-weight":"bold"});
			$(button).parent().find("span:last").fadeOut();	
			setTimeout(function(){				
				$(button).parent().parent().fadeOut("slow");
				if(activeVehiclesCollection.length==0){
				//alert();
					$("#active_vehicle_not_available_status").fadeIn();
					$("#active_vehicle_table").hide();
					
					$("#list_view_refresh_button").prop('disabled',true);
				}
			},1000);			
		},2000);
	  }
	  
	  
	  
	  
	   //########################FLAGGED SECTION###################################################
	  $("body").on("shown.bs.tab", "#flagged", function() {
		//firstTimeTabLoadinAnimation();
		$("#map_view_mode_dropdown_select").prop("disabled", true);	
		
		//displaying flagged vehicle table 
		displayFlaggedTable();
		
		//setting the routename on the header
		if(currentDisplayedRoute==null || currentDisplayedRoute=='undefined'){
			$("#flagged_tab_header_route_name").text("NOT AVAILABLE");		
		}
		else{
			$("#flagged_tab_header_route_name").text(currentDisplayedRoute);
		}
		
		//activating refresh button
		$("#flagged_refresh_button").off();
		$("#flagged_refresh_button").on('click',function(){
			$("#loading1").fadeIn();			
			$("#flagged_refresh_button").prop('disabled',true);
			setTimeout(function(){
				setToIntervalledRefreshAllVehicleData(currentDisplayedRoute, 100);
				displayFlaggedTable();				
				
				$("#flagged_refresh_button").prop('disabled',false);	
				
				//displaying refresh time
				var date = new Date();
				$("#flagged_tab_hour").text(date.getHours());
				$("#flagged_tab_min").text(date.getMinutes());
				$("#flagged_tab_sec").text(date.getSeconds());
				
				$("#loading1").fadeOut();
			},1000);
		});
		
	  });
	  
	  
	  $("body").on("hidden.bs.tab", "#flagged", function() {
		$("#map_view_mode_dropdown_select").prop("disabled", false);	
	  });
	  
	  
	  //this function write active vehicle data to the table on list view tab
	  function displayFlaggedTable(){
		//alert("ranjit "+flaggedVehiclesCollection.length);
		if(flaggedVehiclesCollection.length==0){
		//alert();
			$("#flagged_vehicle_not_available_status").fadeIn();
			$("#flagged_vehicle_table").hide();
			$("#flagged_refresh_button").prop('disabled',true);
		}
		else{		
			//alert(flaggedVehiclesCollection.length);
			$("#flagged_vehicle_not_available_status").hide();
			$("#flagged_vehicle_table tbody").empty();
			jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
				$("#flagged_vehicle_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+vehicle.name+'</td><td>'+vehicle.current_location+'</td><td style="text-align:center">'+vehicle.latitude+'</td><td style="text-align:center">'+vehicle.longitude+'</td><td style="text-align:center">'+vehicle.schedule+'</td><td><button type="button" class="btn btn-xs btn-block" style="background:none; border:1px solid black; float:right; margin:0px" onclick="flaggedViewUnFlagVehicle(this)"><span class="glyphicon glyphicon-flag" aria-hidden="true"></span> <span>UnFlag It </span><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:6px; height:18px;width:18px;background-size: 18px 18px;background-repeat: no-repeat;"></span></button></td></tr>');		
			});
			$("#flagged_vehicle_table").fadeIn();	
			$("#flagged_refresh_button").prop('disabled',false);	
		}
	  }
	  
	  
	  
	  //this function unflag the vehicle from the flagged view tab.
	  function flaggedViewUnFlagVehicle(button){
		var vehicleName = $(button).parent().parent().find("td:nth-child(2)").text();
		$(button).parent().find("span:last").fadeIn();
		
		setTimeout(function(){			
			jQuery.each(flaggedVehiclesCollection, function(i, vehicle){
				//alert(JSON.stringify(vehicle));
				if(vehicle.name==vehicleName){
					
					//GETTING THE ROW RROM THE TABLE
					var row;
					for(var i=0; i<$("#flagged_vehicle_side_table_list tbody").children().length;i++){
					//alert("dssssssssss");
						var tableVehicleName = $("#flagged_vehicle_side_table_list tbody").find("tr:nth-child(" + parseInt(i+1) + ")").find("td:nth-child(2) span:nth-child(1)").text();
						//alert(tableVehicleName);
						if(tableVehicleName.trim() == vehicleName){
							//alert(tableVehicleName);
							//getting the row to pass to unflagvehicle method.
							row = $("#flagged_vehicle_side_table_list").find("tr:nth-child(" + parseInt(i+1) + ")").find("td:nth-child(2) span:nth-child(2)");
							break;
						}
					}
					unFlagVehicle(row);
					return false;
				}
			});	
			$(button).parent().find("span:nth-child(2)").text("UnFlagged").css({"color":"red","font-weight":"bold"});
			$(button).parent().find("span:last").fadeOut();	
			setTimeout(function(){				
				$(button).parent().parent().fadeOut("slow");

				if(flaggedVehiclesCollection.length==0){
				//alert();
					$("#flagged_vehicle_not_available_status").fadeIn();
					$("#flagged_vehicle_table").hide();
					
					$("#flagged_refresh_button").prop('disabled',true);
				}
			},800);	
		},1000);
	  }
	  
	  
	  
	  
	  
	  
	  
	  /*
	  
	//the map should be loaded last else will not load in webpage.
			var arr = [ 27.71595, 85.28364];
	var map = new L.Map('map', {
		layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true})]	
	}).setView([arr[0],arr[1]], 15, {animate: false, reset: true});
	
	 //Displaying the route information  
    var markerLine = L.polyline([
		[27.71595, 85.28364], [27.70743, 85.28263], [27.69950, 85.28177], [27.69858, 85.28154], [27.69804, 85.28155], [27.69337, 85.28174], [27.69356, 85.28275], [27.69378, 85.28370], [27.69409, 85.28449], [27.69427, 85.28498], [27.69533, 85.28908], [27.69539, 85.28979], [27.69545, 85.29009], [27.69564, 85.29072], [27.69564, 85.29088], [27.69563, 85.29101], [27.69546, 85.29200], [27.69544, 85.29216], [27.69547, 85.29250], [27.69553, 85.29270], [27.69559, 85.29285], [27.69579, 85.29306], [27.69664, 85.29356], [27.69673, 85.29381], [27.69695, 85.29447], [27.69850, 85.29960], [27.69860, 85.30000], [27.69843, 85.30074], [27.69806, 85.30260], [27.69781, 85.30355], [27.69773, 85.30372], [27.69667, 85.30570], [27.69660, 85.30587], [27.69627, 85.30704], [27.69604, 85.30776], [27.69585, 85.30828], [27.69509, 85.31006], [27.69462, 85.31135], [27.69433, 85.31206], [27.69425, 85.31229], [27.69411, 85.31274], [27.69397, 85.31336], [27.69390, 85.31375], [27.69388, 85.31395], [27.69393, 85.31397], [27.69398, 85.31401], [27.69412, 85.31407], [27.69430, 85.31410], [27.69445, 85.31409], [27.69614, 85.31384], [27.69708, 85.31374], [27.69732, 85.31368], [27.69786, 85.31347], [27.69800, 85.31338], [27.69810, 85.31330], [27.69934, 85.31341], [27.69967, 85.31345], [27.70000, 85.31348], [27.70055, 85.31351], [27.70157, 85.31357], [27.70184, 85.31360], [27.70356, 85.31377], [27.70377, 85.31375], [27.70400, 85.31380], [27.70445, 85.31383], [27.70458, 85.31387], [27.70537, 85.31405], [27.70572, 85.31412], [27.70706, 85.31431], [27.70788, 85.31436], [27.70847, 85.31440], [27.70855, 85.31444], [27.70874, 85.31463], [27.70874, 85.31482], [27.70881, 85.31530], [27.70899, 85.31590], [27.70926, 85.31666], [27.70940, 85.31703], [27.70944, 85.31709], [27.70951, 85.31716], [27.70960, 85.31720], [27.70989, 85.31724], [27.71006, 85.31723], [27.71028, 85.31738], [27.71301, 85.31783], [27.71324, 85.31790], [27.71332, 85.31819], [27.71360, 85.31938], [27.71366, 85.31997], [27.71371, 85.32197], [27.71343, 85.32204], [27.71214, 85.32219], [27.71158, 85.32223], [27.71127, 85.32218], [27.71099, 85.32210], [27.71050, 85.32198], [27.71033, 85.32223], [27.71029, 85.32271], [27.71025, 85.32311], [27.71017, 85.32450], [27.71010, 85.32514], [27.71001, 85.32604], [27.70994, 85.32623], [27.70921, 85.32938], [27.70913, 85.32979], [27.70902, 85.33025], [27.70894, 85.33067], [27.70894, 85.33067], [27.70866, 85.33199], [27.70862, 85.33222], [27.70841, 85.33291], [27.70829, 85.33330], [27.70830, 85.33338], [27.70826, 85.33363], [27.70811, 85.33626], [27.70810, 85.33653], [27.70798, 85.33935], [27.70798, 85.33945], [27.70797, 85.33995], [27.70800, 85.34021], [27.70818, 85.34097], [27.70821, 85.34117], [27.70817, 85.34186], [27.70810, 85.34227], [27.70804, 85.34251], [27.70785, 85.34314], [27.70780, 85.34334], [27.70767, 85.34371], [27.70721, 85.34436], [27.70606, 85.34581], [27.70595, 85.34601], [27.70588, 85.34619], [27.70578, 85.34653], [27.70575, 85.34674], [27.70574, 85.34693], [27.70576, 85.34731], [27.70613, 85.34959], [27.70623, 85.35030], [27.70625, 85.35048], [27.70624, 85.35070], [27.70620, 85.35092], [27.70613, 85.35111], [27.70605, 85.35128], [27.70592, 85.35147], [27.70579, 85.35162], [27.70561, 85.35177], [27.70545, 85.35187], [27.70526, 85.35195], [27.70510, 85.35198], [27.70305, 85.35213], [27.70282, 85.35218], [27.70252, 85.35232], [27.70093, 85.35353], [27.70071, 85.35373], [27.70019, 85.35411]
	
	], {}).addTo(map);
	
    var markerPatterns = L.polylineDecorator(markerLine, {
        patterns: [
            { offset: '5%', repeat: '10%',symbol: L.Symbol.arrowHead({pixelSize: 5, pathOptions: {color: '#0000FF', weight: 5, opacity: 0.5}})}
        ]
    }).addTo(map);
	
	//L.circle([27.71595, 85.28364], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Swayambhu Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70743, 85.28263], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Sitapaila Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69337, 85.28174], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Kalanki Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69664, 85.29356], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Soalti Mood Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69835, 85.29960], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Kalimati Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69667, 85.30570], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Teku Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69462, 85.31135], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Tripureshwor 1 Bus Station', { noHide: true }).addTo(map);
	L.circle([27.69397, 85.31336], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Tripureshwor 2 Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70157, 85.31357], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('RNAC Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70926, 85.31666], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Jamal Bus Station', { noHide: true }).addTo(map);
	L.circle([27.71332, 85.31819], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Durbar Marg Bus Station', { noHide: true }).addTo(map);
	L.circle([27.71099, 85.32210], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Hattisar Bus Station', { noHide: true }).addTo(map);
	L.circle([27.71010, 85.32514], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Kamalpokhari Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70866, 85.33199], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Gyaneshwor Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70830, 85.33338], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Maitidevi Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70811, 85.33626], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Ratopul Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70780, 85.34334], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Gaushala Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70613, 85.34959], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Tilganga Bus Station', { noHide: true }).addTo(map);
	L.circle([27.70019, 85.35411], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Airport Bus Station', { noHide: true }).addTo(map);
	
	
	var m = L.marker([27.71595, 85.28364], {draggable:true}).bindLabel('A sweet static label!', { noHide: true })
			.addTo(map);
			
	//showLabel();
	//var marker = L.marker([85.29009, 27.69545,{title: 'Bus no. 3'}]).addTo(map);
	//marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup();

	//issue: if both marker and marker1 has been instantiated then if we make marker 1 co-ordinates as center in set_view then it will not work??? any reason??
	
	//Finding: I realised that the marker that is instantiated on the last which in this case marker will be //shown as center. 
	
	var marker1 = L.marker([ arr[0],arr[1] ]).addTo(map);
	
	var popup = L.popup()
    .setLatLng([ arr[0],arr[1] ])
    .setContent('<p style="background-color:green">Hello world!<br />This is a nice popup.</p>')
    .openOn(map);
	
	*/
	/*
	map.on('click', function(e) {
    alert("Lat, Lon : " + e.latlng.lat + ", " + e.latlng.lng)
});*/

    </script>


</body>
</html>