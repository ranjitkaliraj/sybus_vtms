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
<spring:url value="resources/js/jquery-ui.min.js" var="jqueryUiJs"/>
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
<spring:url value="resources/images/stop1.png" var="stop1Image" />
<spring:url value="resources/images/refresh.gif" var="refreshImage" />


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SY Bus - Vehicle Tracking and Management System for Sajha
	Yatayat</title>
<link rel="shortcut icon" type="image/png" href="${favicon}" />
<!-- Latest compiled and minified CSS -->
<link href="${bootstrapCss}" rel="stylesheet">
<!-- Optional theme -->
<link href="${bootstrapThemeCss}" rel="stylesheet">
<!--css import for sidepanel dashboard-->
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
	height: 97.6%;
	max-width: 100% !important;
	overflow: hidden;
}

::-webkit-scrollbar {
	display: none;
}

#display_bus_stop_table tbody tr:hover {
	background-color: rgba(0, 0, 0, 0.1) !important;
}
</style>
</head>
<body>
	<header class="navbar-inverse navbar-fixed-top" role="banner"
		style="z-index: 10000">
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
							<li><a href="home.html">HOME <span class="sr-only">(current)</span></a></li>
							<li><a href="#">VEHICLE TRACKING</a></li>
							<li class="active"><a href="manage.html">MANAGE</a></li>
							<!--<li class="active" class="dropdown">
                           <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">MANAGE <span class="caret"></span></a>
                           <ul class="dropdown-menu">
                              <li><a id="target" href="#">Manage Routes</a></li>
                              <li><a href="#">Manage Schedules</a></li>
                              <li><a href="#">Manage Fare</a></li>
                              <li><a href="#">Manage Vehicles</a></li>
                           </ul>
                        </li>-->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">REPORTING <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="#">Route with Most Passenger Travelling
											Report</a></li>
									<li><a href="#">Route with Most Traffic Report</a></li>
									<li><a href="#">Time where Most Passenger Ride Bus
											Report</a></li>
									<li><a href="#">Vehicle, Schedule, Fare and Route
											Details Report</a></li>
									<li><a href="#">Registered Passenger Details Report</a></li>
									<li><a href="#">Bus with Highest and Lowest Travelling
											Time Report</a></li>
								</ul></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">Options <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="#">Logout</a></li>
									<li role="separator" class="divider"></li>
									<li><a href="#">Help</a></li>
								</ul></li>
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

		<div class="row" style="height: 100%; width: auto">
			<div class="col-sm-2 col-md-2 sidebar"
				style="margin-bottom: 40px; border-right: 1px solid rgba(0, 0, 0, 0.2)">
				<div style="margin: -22px">
					<!--breachcrumb for sub-navigation info-->
					<ol class="breadcrumb" style="margin-top: -8px">
						<li><a href="home.html" style="color: #595959 !important">Home</a></li>
						<li><a href="manage.html" style="color: #595959 !important">Manage</a></li>
						<li class="active">Route</li>
					</ol>

				</div>


				<ul class="nav nav-sidebar" style="padding: 2px">
					<li><a
						style="color: #000; font-weight: bold; border-top: 1px solid rgba(0, 0, 0, 0.3)"
						href="manage.html">Overview <span class="sr-only">(current)</span></a></li>
					<li class="active"><a
						style="font-weight: bold; background: none; color: #000; border: 1px solid #9E9E9E"
						href="#">MANAGE ROUTE</a></li>
					<li><a style="color: rgba(0, 0, 0, 0.5)"
						href="manage_schedule.html">MANAGE SCHEDULE</a></li>
					<li><a style="color: rgba(0, 0, 0, 0.5)" href="#">MANAGE
							VEHICLE</a></li>
					<li><a style="color: rgba(0, 0, 0, 0.5)" href="#">MANAGE
							FARE</a></li>
				</ul>
			</div>

			<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main"
				style="margin-bottom: 40px; height: 100%; width: 89%">
				<!--<h1 class="page-header" style="margin-top:-10px">Dashboard</h1>-->
				<div
					style="margin-left: -42px; margin-right: -42px; margin-top: -20px; height: 100%; width: 100%">
					<!-- Nav tabs -->
					<!--enclosing this tab menu in container fluid so that there is certain padding and we also dont want to have padding in content e.g. map so exclusively defining only this div that wrap tab section only-->
					<div id="tab_sections" class="container-fluid">
						<ul class="nav nav-tabs" role="tablist">
							<!--<li role="presentation"><a href="manage.html" style="height:36px;padding:8px; color:rgba(0,0,0,0.5)"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span> Back</a></li>-->
							<li role="presentation" class="active"><a
								id="route_tab_header" href="#routes_tab"
								aria-controls="routes_tab" role="tab" data-toggle="tab"
								style="height: 36px; padding: 8px">ROUTE</a></li>
							<li role="presentation"><a id="bus_stop_tab_header"
								href="#bus_stops_tab" aria-controls="bus_stops_tab" role="tab"
								data-toggle="tab" style="height: 36px; padding: 8px">BUS
									STOPS</a></li>
							<li role="presentation"><a id="route_way_tab_header"
								href="#route_way_tab" aria-controls="route_way_tab" role="tab"
								data-toggle="tab" style="height: 36px; padding: 8px">ROUTE
									WAY</a></li>
							<li role="presentation"><a id="stops_distance_tab_header"
								href="#stops_distance_tab" aria-controls="stops_distance_tab"
								role="tab" data-toggle="tab" style="height: 36px; padding: 8px">STOPS
									DISTANCE</a></li>

							<!--add, edit and delete buttons-->
							<div class="btn-group" role="group" aria-label="..."
								style="float: right; margin-right: 18px; margin-top: 2px">
								<button id="add_button" data-toggle="tooltip"
									data-placement="bottom" title="Add"
									style="background: none; padding: 0px; height: 28px; width: 60px"
									type="button" class="btn btn-default pull-left tooltip-bottom"
									title="Add new Route Details">
									<span class="glyphicon glyphicon-plus"></span>
								</button>
								<button id="edit_button" data-toggle="tooltip"
									data-placement="bottom" title="Edit"
									style="background: none; padding: 0px; height: 28px; width: 60px"
									type="button" class="btn btn-default pull-left tooltip-bottom"
									title="Edit and update existing Route Details">
									<span class="glyphicon glyphicon-edit"></span>
								</button>
								<button id="delete_button" data-toggle="tooltip"
									data-placement="bottom" title="Delete"
									style="background: none; padding: 0px; height: 28px; width: 60px"
									type="button" class="btn btn-default pull-left tooltip-bottom"
									title="Delete all or particular Route Details">
									<span class="glyphicon glyphicon-trash"></span>
								</button>
							</div>
						</ul>
					</div>


					<!-- Tab panes to display detail content-->
					<div id="tab_pane" class="tab-content container-fluid"
						style="height: 100%; width: 100%">


						<!--title for the content pane for all three tab. which will be switched accordingly. also this div is fixed.-->
						<div class="page-header row-fluid"
							style="height: 32px; padding-left: 18px; padding-right: 18px; padding-bottom: 0px; margin-bottom: 0px; margin-top: -12px">
							<div id="content_header">
								<h3>
									<span style="color: #4CAF50" id="content_header_title"></span><small
										id="content_header_subtitle"></small>
									<!--Refresh Button-->
									<button id="content_header_button_refresh" type="button"
										class="btn btn-sm" data-toggle="tooltip"
										data-placement="bottom" title="Refresh the list"
										style="display: none; background-color: #FFF; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 28px; width: 80px"
										onClick="refresh()">
										<span id="content_header_icon_refresh"
											class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
										Refresh
									</button>

									<!--Close button used for add form closing action-->
									<button id="content_header_button_close" type="button"
										class="btn btn-sm" data-toggle="tooltip"
										data-placement="bottom" title="Exit"
										style="display: none; background-color: #FFF; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 28px; width: 80px">
										<span class="glyphicon glyphicon-remove-sign"
											aria-hidden="true"></span> Close
									</button>

									<!--save and cancel button for edit/delete mode route edit mode-->
									<button id="content_header_button_exit" type="button"
										class="btn btn-sm"
										style="display: none; float: right; margin-bottom: 5px; background: none; border: 1px solid #9E9E9E; height: 28px; width: 80px; margin-left: 8px"
										onClick="">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										EXIT
									</button>
									<button id="content_header_button_save" type="button"
										class="btn btn-sm"
										style="display: none; float: right; margin-bottom: 5px; background: none; border: 1px solid #9E9E9E; height: 28px; width: 80px"
										onClick="">
										<span class="glyphicon glyphicon-floppy-disk"
											aria-hidden="true"></span> SAVE
									</button>
									<!--saving loading animation-->
									<div id="content_header_loading_icon" data-toggle="tooltip"
										data-placement="bottom" title="Saving..."
										style="float: right; margin-top: -1px; margin-right: 18px; display: none">
										<img src="${actionLoadingIcon}" height="24" width="24">
									</div>

									<!--refresh animation logo-->
									<span id="refresh_animation_logo"
										style="float: right; margin-right: 10px; display: none"><img
										src="refreshImage" height="24" width="24"></span>
								</h3>
							</div>
						</div>




						<!--#####################################################################################################################################-->
						<!--Route section-->
						<!--#####################################################################################################################################-->
						<div role="tabpanel" class="tab-pane fade in active"
							id="routes_tab"
							style="height: 100%; width: 100%; overflow-y: auto !important">

							<span id="route_tab_span_container"> <!--This span is used for hiding the section when reloading or loading-->
								<!--Add new route status message section-->
								<div class="row-fluid container-fluid">
									<div class="col-md-1"></div>

									<!--THis div will be displayed when user cancel or submit the add route form(not close)-->
									<div id="add_route_submit_message_alert" tabindex='1'
										class="alert in fade alert-success col-md-8" role="alert"
										style="margin-left: 48px; margin-top: 20px; display: none; background: none; border: 1px solid #595959">

										<!--<button id="add_button_message_close" type="button" class="close" data-dismiss="alert" aria-label="Close">
				  <span aria-hidden="true">&times;</span>
				</button>-->
										<h2 style="color: #595959;">
											<span style="color: #4CAF50"
												id="add_route_submit_message_alert_title"></span><small
												id="add_route_submit_message_alert_details"></small>
										</h2>
										<div class="col-md-2">
											<button type="button" class="btn btn-sm"
												data-toggle="tooltip" data-placement="bottom"
												title="Add new Route"
												style="background: none; border: 1px solid #9E9E9E; padding: 0px; height: 34px; width: 100px; margin-left: -10px"
												onClick="displayAddRouteForm()">ADD NEW</button>
										</div>

									</div>
								</div> <!--Add edit, delete route Server error message or duplicate data error-->
								<div id="route_section_server_error"
									class="alert alert-warning row-fluid" role="alert"
									style="display: none; font-size: 14px; height: 48px; margin: 8px">
									<strong id="route_section_server_error_title">ERROR
										OCCURED!!!</strong><small id="route_section_server_error_details">
										Something went wrong. Cannot add the Route details at the
										moment. Please try again later.</small>
								</div>

								<div class="row-fluid container-fluid" style="margin-top: 6px">
									<div class="col-md-2"></div>
									<!--add new Route section-->
									<div id="add_route_section"
										class="col-md-7 panel panel-default"
										style="border: 1px solid #BDBDBD; display: none; margin-top: 6px; margin-bottom: 50px; height: auto; font-size: 12px; padding: 0px">
										<div
											style="background-color: #424242; color: #FFF; font-weight: normal; font-size: 16px; text-align: center; padding: 8px; height: 36px">ADD
											NEW ROUTE</div>
										<div class="col-md-12" style="padding: 0px">

											<div class="row-fluid">
												<div class="container-fluid" style="padding: 24px;">

													<!--Add route form-->
													<div class="form-group row-fluid">
														<!--<label class="col-md-3 control-label"  style="margin-top:6px">Add Name:</label>-->
														<div class="input-group col-md-12">
															<span class="input-group-addon" id="basic-addon1"
																style="font-weight: normal; width: 110px; font-size: 12px; color: #000">ROUTE
																NAME </span> <input id="add_button_routeName"
																style="height: 28px; font-size: 12px; color: #000"
																type="text" class="form-control"
																placeholder="Enter Route Name"
																aria-describedby="basic-addon1">
														</div>
													</div>
													<div class="form-group row-fluid">
														<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
														<div class="input-group col-md-12">
															<span class="input-group-addon"
																style="font-weight: normal; font-size: 12px; width: 110px; color: #000">BUS
																STOP</span> <select id="add_button_stop_dropdown"
																style="height: 28px; font-size: 12px; padding: 0px; color: #000"
																class="form-control tooltip-bottom" placeholder="apple"
																title="Select Bus stop from the list.">
																<option id="select_stop_from_list">SELECT BUS
																	STOP</option>
																<!--<option>Kalimati Bus Station</option>
								<option>Soyambhu Bus Station</option>
								<option>Kalanki Bus Station</option>
								<option>SahidGet Bus Station</option>
								<option>SahidGet Bus Station1</option>
								<option>SahidGet Bus Station2</option>
								<option>SahidGet Bus Station3</option>
								<option>SahidGet Bus Station4</option>
								<option>SahidGet Bus Station5</option>
								<option>SahidGet Bus Station6</option>
								<option>SahidGet Bus Station7</option>
								<option>SahidGet Bus Station8</option>
								<option>SahidGet Bus Station9</option>
								<option>SahidGet Bus Station10</option>-->
															</select>
														</div>
													</div>

													<div class="row-fluid form-group">
														<label class="col-md-10 control-label"
															style="margin-top: -5px; margin-left: -10px; font-weight: normal; color: #757575; font-size: 12px">
															Select and add required Bus Stops from the dropdown list.</label>
														<button id="add_busstop_to_route_button" type="button"
															class="btn btn-sm pull-right" data-toggle="tooltip"
															data-placement="bottom" title="Add to Bus Stop List."
															style="border: 1px solid #BDBDBD; background: none; margin-top: -8px; margin-bottom: 12px; height: 24px; width: 52px; padding: 0px">
															<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
														</button>
													</div>



													<div class="form-group row-fluid">
														<div class="panel-heading col-md-12"
															style="font-weight: bold; background: none; border: none; height: 32px; padding: 1px;">
															<h5 style="font-weight: bold">
																BUS STOP LISTS<small> (You can also drag and
																	drop the rows to re-arrange the order.)</small>
															</h5>
														</div>

														<div class="panel panel-default col-md-12"
															style="padding: 0px">
															<!-- Default panel contents to display bus stop list after user select and add the stop from the dropdown-->


															<!-- Table -->
															<table
																class="table table-condensed table-striped table-bordered"
																id="add_button_selected_stop_list"
																style="font-size: 12px">
																<tbody>
																</tbody>
															</table>
														</div>
													</div>
												</div>
												<div class="row-fluid col-md-10"
													style="padding-bottom: 20px; margin-left: 10px; margin-top: -20px; margin-bottom: -24px">
													<div class="col-md-2">
														<button id="add_button_submit_button" type="button"
															class="btn btn-sm"
															style="background: none; border: 1px solid #9E9E9E; margin-bottom: 20px; height: 32px; width: 96px; margin-left: -16px;"
															onClick="submitRouteExtended()">
															<span class="glyphicon glyphicon-plus"></span> ADD
														</button>
													</div>
													<div class="col-md-2">
														<button id="add_button_cancel_button" type="button"
															class="btn btn-sm"
															style="background: none; border: 1px solid #9E9E9E; margin-bottom: 20px; height: 32px; width: 96px; margin-left: 5px"
															onClick="hideAddRouteFormOnly()">
															<span class="glyphicon glyphicon-remove"></span> CANCEL
														</button>
													</div>
													<!--submit animation logo-->
													<span id="route_add_loading_icon" data-toggle="tooltip"
														data-placement="bottom" title="Loading..."
														style="visibility: hidden; float: left; margin-left: 48px; margin-top: 3px"><img
														src="${actionLoadingIcon}" height="24" width="24"></span>


													<div class="col-md-8">
														<button id="add_button_reset_button" type="button"
															data-toggle="tooltip" data-placement="bottom"
															title="Reset" class="btn btn-sm pull-right"
															style="margin-right: -102px; margin-top: -28px; background: none; border: 1px solid #9E9E9E"
															onClick="resetAddRouteForm()">
															<span class="glyphicon glyphicon-repeat"></span>
														</button>
													</div>
												</div>

											</div>
										</div>

									</div>

								</div> <!--Route bus stops map view section-->
								<div tabindex="1" id="route_map_container"
									class="row-fluid container-fluid col-md-12"
									style="display: none; padding-left: 18px; padding-right: 18px; z-index: 9999; margin-top: -6px; margin-bottom: 24px; height: 492px">

									<!--loading animation-->
									<div id="route_map_loading"
										style="display: none; border: 1px solid #BDBDBD; height: 90%; width: 100%; background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center">
									</div>

									<!--main map section-->
									<div id="route_map"
										style="display: none, border:1px solid #BDBDBD; height: 90%; width: 100%">
									</div>


									<div class="panel-heading"
										style="border: 1px solid #BDBDBD; height: 10%; width: 100%; background-color: #424242; padding: 0px; padding-left: 18px; padding-right: 8px">
										<h5 style="font-weight: bold; color: #DDD; margin-top: 6px">
											<span id="route_map_route_name">ROUTE 1</span> <small
												style="color: #BBB; font-size: 11.5px"> Route Stops:
												<span id="route_map_stop_message">Available</span> | Route
												Way: <span id="route_map_way_message">dfsfdsf</span> <br>
												(The BLUE line displays the Route Way and the Green markers
												displays the Bus Stops position.)
											</small>
											<button id="route_map_close_button" type="button"
												class="btn btn-sm"
												style="float: right; background-color: #424242; color: #CCC; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 24px; width: 80px; margin-top: -13px"
												onClick="closeRouteTabMap()">
												<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
												CLOSE
											</button>
										</h5>
									</div>


								</div> <!--this is temporary heading for route display when add route form appears-->
								<div id="temp_route_heading"
									class="page-header row-fluid col-md-12"
									style="display: none; padding-left: 18px; padding-right: 18px; margin-top: -20px; padding-bottom: 0px">
									<h3>
										<span id="temp_route_heading_title" style="color: #4CAF50">CURRENT
											ROUTES</span> <small> List of currently available routes. </small>


										<button id="refresh_button" type="button" class="btn btn-sm"
											style="background-color: #FFF; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 28px; width: 80px"
											onClick="displayLoading(true)" disabled="disabled">
											<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
											Refresh
										</button>
										<!--
				<--refresh animation logo--
				<span id="refresh_icon"style="float:right;margin-right:10px"><img src="refreshImage" height="24" width="24"></span>	
			<--Edit option close button button--
			<button id = "edit_option_exit_button" type="button" class="btn btn-sm" style="float:right;background-color:#FFF; border:1px solid #9E9E9E; height:28px;width:80px" onClick="cancelRouteEditOption()">
				  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
				</button>	
				-->
									</h3>

								</div> <!--Route table list section-->
								<div class="col-md-12 container-fluid"
									style="padding-left: 72px; padding-right: 72px; margin-top: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; height: 100%; width: 100%; overflow-y: auto !important">

									<!--Save edit route detail status message-->
									<div id="route_save_success_message" tabindex="1"
										class="alert alert-success row-fluid" role="alert"
										style="display: none; font-size: 14px; height: 48px; margin-bottom: 6px">
										<strong>Update Successful.</strong><small> New changes
											to the selected Routes has been successfully updated.</small>
									</div>
									<div id="route_save_danger_message" tabindex="1"
										class="alert alert-danger row-fluid" role="alert"
										style="display: none; font-size: 14px; height: 48px; margin-bottom: 6px">
										<strong>Update Failed.</strong><small> Something went
											wrong. New changes to the selected Routes cannot be made at
											the moment.</small>
									</div>
									<div id="route_save_already_saved_error_message" tabindex="1"
										class="alert alert-warning row-fluid" role="alert"
										style="display: none; font-size: 14px; height: 48px; margin-bottom: 6px">
										<strong>Unable to Save.</strong><small> No
											modification has been made to any route details or changes
											are already saved.</small>
									</div>


									<!--delete route detail status message-->
									<div id="route_delete_success_message" tabindex="1"
										class="alert alert-success row-fluid" role="alert"
										style="display: none; font-size: 14px; height: 48px; margin-bottom: 6px">
										<strong>Delete Successful.</strong><small> Selected
											Routes has been successfully deleted.</small>
									</div>
									<div id="route_delete_danger_message" tabindex="1"
										class="alert alert-danger row-fluid" role="alert"
										style="display: none; font-size: 14px; height: 48px; margin-bottom: 6px">
										<strong>Delete Failed.</strong><small> Something went
											wrong. Deletion to the selected Routes cannot be made at the
											moment.</small>
									</div>


									<!--Delete route check box to select all-->
									<div id="display_route_route_delete_select_all_checkbox"
										style="display: none; width: 94px">
										<div style="float: left; margin-top: 3px; font-weight: bold">SELECT
											ALL:</div>
										<div style="float: right">
											<input id="route_delete_select_all_checkbox" type="checkbox"
												aria-label="..." onClick="selectRouteDeleteAllCheckBox()">
										</div>
									</div>


									<!--Display message when there is no-route to display in table.-->
									<div class="col-md-1"></div>
									<div id="display_route_message_alert"
										class="alert in fade alert-success col-md-9" role="alert"
										style="display: none; margin-top: 12px; background: none; border: 1px solid #595959">
										<h2 style="color: #595959;">
											<span style="color: #4CAF50" id="display_route_message_title">Route
												not Available.</span><small id="display_route_message_detail">There
												is nothing to display. Please, add a new route details. Your
												added details will be displayed here.</small>
										</h2>

									</div>

									<table
										class="table table-condensed able-striped table-bordered"
										id="display_route_table" style="display: none">
										<thead>
											<tr
												style="height: 28px; background-color: rgba(0, 0, 0, 0.8); color: #CCC">
												<th style="text-align: center" width="4%">SN</th>
												<th style="text-align: center" width="14%">ROUTE NAME</th>
												<th style="text-align: center" width="82%">BUS STOPS</th>
											</tr>
										</thead>
										<tbody>
											<!-- <tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">Route 1</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station</td>
				
              </tr>
              <tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">Route 1</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station, Sahid Get Bus station</td>
				
              </tr>
              <tr tabindex="1">
                <td>1</td>
                <td tabindex="1" style="text-align:center">Route 1</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station</td>
				
              </tr>
              <tr tabindex="1">
                <td>1</td>
                <td tabindex="1" style="text-align:center">Route 1</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station</td>
				
              </tr>
              <tr tabindex="1">
                <td>1</td>
                <td tabindex="1" style="text-align:center">Route 2</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station</td>
              </tr>
              <tr>
                <td>1</td>
                <td tabindex="1" style="text-align:center">Route 2</td>
                <td>Kalimati Bus station, Kalanki Bus station, Tripureshwor Bus Station, Sahid Get Bus station</td>
              </tr>-->
										</tbody>
									</table>

									<!--Delete button-->
									<div id="delete_route_apply_and_cancel_buttons"
										style="display: none; margin-bottom: 6px; margin-top: -6px">
										<hr>
										<button type="button" class="btn btn-sm"
											style="margin-top: -12px; background-color: #FFF; border: 1px solid #9E9E9E; margin-bottom: 20px; height: 32px; width: 96px"
											onClick="displayRouteDeleteModal()">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
											DELETE
										</button>

										<!--delete option close/cancel button-->
										<button type="button" class="btn btn-sm"
											style="margin-top: -12px; background-color: #FFF; border: 1px solid #9E9E9E; margin-bottom: 20px; margin-left: 5px; height: 32px; width: 96px"
											onClick="cancelRouteDeleteOption()">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
											EXIT
										</button>
									</div>
									<br>
									<br>
									<br>
									<br>
								</div>

							</span>

						</div>

						<!--#####################################################################################################################################-->
						<!--Bus stop tab section-->
						<!--#####################################################################################################################################-->

						<div role="tabpanel" class="tab-pane fade" id="bus_stops_tab"
							style="height: 100%; width: 100%; overflow-y: hidden !important; margin-top: 6px">

							<span id="bus_stop_span_container"> <!--This span is used for hiding the section when reloading or loading-->
								<!--status message to display when no bus stops are available to display.-->
								<div id="bus_stop_display_status_message" style="display: none">
									<div class="col-md-1"></div>
									<div tabindex='1' class="alert in fade alert-success col-md-2"
										role="alert"
										style="height: 156px; width: 800px; margin-top: 12px; margin-left: 60px; background: none; border: 1px solid #595959">

										<h2 style="color: #595959;">
											<span style="color: #4CAF50"
												id="bus_stop_display_status_message_title"> BUS STOPS
												NOT AVAILABLE. </span><br>
											<small id="bus_stop_display_status_message_details">Currently,
												there are no any bus stops details are available to display
												here. You can add new Bus Stop and added Bus stops will be
												displayed here.</small>
										</h2>
									</div>
								</div>

								<div id="bus_stop_tab_main_container"
									class="container-fluid col-md-12"
									style="display: none; height: 88.5%; width: 100%; overflow-y: hidden !important">
									<div class="col-md-7"
										style="height: 100%; padding: 0px; margin: 0px">


										<div id="display_bus_stop_section" class="panel panel-default"
											style="padding: 5px; height: 100%; width: 100%; margin: 0px; overflow-y: hidden !important; overflow-x: hidden !important">

											<!--Bus stop delete status message-->
											<div id="bus_stop_delete_success_message"
												class="alert alert-success row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px;">
												<strong>Delete Successful.</strong><small> The
													selected Bus stop has been successfully deleted.</small>
											</div>
											<div id="bus_stop_delete_danger_message"
												class="alert alert-danger row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px">
												<strong>Delete Failed.</strong><small> Something
													went wrong. Cannot delete Bus Stop at the moment.</small>
											</div>


											<!--Server error message-->
											<div id="bus_stop_server_danger_message"
												class="alert alert-danger row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px">
												<strong id="bus_stop_server_danger_message_title">ERROR
													OCCURED!!!</strong><small id="bus_stop_server_danger_message_detail">
													Something went wrong. Please, try again later.</small>
											</div>


											<!--Check all box for delete section-->
											<div id="delete_bus_stop_route_delete_select_all_checkbox"
												style="display: none; height: 3.5%; border-bottom: 1px dotted #BDBDBD">
												<div style="width: 102px">
													<div
														style="float: left; margin-left: 8px; margin-top: 0px; font-weight: bold; font-size: 12px">SELECT
														ALL:</div>
													<div style="float: right; margin-top: -3px;">
														<input id="bus_stop_delete_select_all_checkbox"
															type="checkbox" aria-label="..."
															onClick="selectBusStopDeleteAllCheckBox()">
													</div>
												</div>
											</div>

											<!--main table section-->
											<div id="bus_stop_main_table_section"
												style="height: 100%; width: 100%; overflow-y: auto !important; overflow-x: hidden !important">

												<!--add bus stop status message.-->
												<div id="add_bus_stop_submit_message_alert" tabindex='1'
													class="alert in fade alert-success" role="alert"
													style="height: 160px; margin: 12px; display: none; background: none; border: 1px solid #595959">
													<button id="add_button_message_close" type="button"
														class="close" data-dismiss="alert" aria-label="Close"
														onclick="closeAddBusStopForm()">
														<span aria-hidden="true">&times;</span>
													</button>

													<h2 style="color: #595959;">
														<span style="color: #4CAF50"
															id="add_bus_stop_submit_message_alert_title"></span><small
															id="add_bus_stop_submit_message_alert_details"></small>
													</h2>
													<div class="col-md-6" style="margin-left: -12px">
														<button type="button" class="btn btn-sm"
															data-toggle="tooltip" data-placement="bottom"
															title="Add new BusStop"
															style="background: none; border: 1px solid #9E9E9E; padding: 0px; height: 34px; width: 100px; margin-right: 8px; float: left"
															onClick="displayAddBusStopForm()">ADD NEW</button>
														<button type="button" class="btn btn-sm"
															data-toggle="tooltip" data-placement="bottom"
															title="Exit Form"
															style="background: none; border: 1px solid #9E9E9E; padding: 0px; height: 34px; width: 100px; float: left"
															onclick="closeAddBusStopForm()">EXIT</button>
													</div>
												</div>

												<!--Bus stop saving status message-->
												<div id="bus_stop_save_success_message"
													class="alert alert-success row-fluid" role="alert"
													style="display: none; font-size: 14px; height: 48px; margin: 8px">
													<strong>Update Successful.</strong><small> New
														changes to the selected Bus stop has been successfully
														updated.</small>
												</div>
												<div id="bus_stop_save_danger_message"
													class="alert alert-danger row-fluid" role="alert"
													style="display: none; font-size: 14px; height: 48px; margin: 8px">
													<strong>Update Failed.</strong><small> Something
														went wrong. Cannot update Bus Stop at the moment.</small>
												</div>
												<div id="bus_stop_save_already_saved_error_message"
													class="alert alert-warning row-fluid" role="alert"
													style="display: none; font-size: 14px; height: 48px; margin: 8px">
													<strong>Unable to Save.</strong><small> No
														modification found on any Bus Stop or changes are already
														saved.</small>
												</div>



												<!--Add new bus stop section-->
												<div id="add_bus_stop_section" class="panel panel-default"
													style="display: none; border: 1px solid #BDBDBD; margin: 12px; margin-left: 72px; margin-right: 72px; height: auto; width: auto; padding: 0px; overflow-y: auto !important; overflow-x: hidden !important">



													<div class="panel-heading"
														style="height: 32px; padding: 6px; background: none; background-color: #424242; color: #FFF; text-align: center">
														<h5 class="panel-title">ADD NEW BUS STOP</h5>
													</div>



													<div class="panel-body" style="padding: 10px 10px 0px 10px">
														<div class="form-group row-fluid">
															<div class="input-group col-md-12">
																<span class="input-group-addon"
																	style="width: 102px; font-size: 12px; color: #000">NAME:
																</span> <input id="add_bus_stop_enter_name" tabindex="1"
																	type="text" class="form-control"
																	placeholder="Enter Bus Stop Name"
																	aria-describedby="basic-addon1"
																	style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
															</div>
														</div>


														<div class="form-group row-fluid"
															style="padding-left: 18px; padding-right: 18px; border: 1px solid #BDBDBD; background-color: #E0E0E0">
															<div class="input-group col-md-12">
																<span class="label label-default"
																	style="display: block; font-size: 12px; height: 42px; padding: 14px; background: none; color: #000;">LOCATION
																	CO-ORDINATES</span>
															</div>

															<div class="form-group row-fluid">
																<div class="input-group col-md-12">
																	<span class="input-group-addon"
																		style="width: 102px; font-size: 12px; color: #000">LONGITUDE:
																	</span> <input id="add_bus_stop_longitude" tabindex="1"
																		type="text" class="form-control"
																		placeholder="longitude co-ordinate"
																		aria-describedby="basic-addon1"
																		style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
																</div>
															</div>
															<div class="form-group row-fluid">
																<div class="input-group col-md-12">
																	<span class="input-group-addon"
																		style="width: 102px; font-size: 12px; color: #000">LATITUDE:
																	</span> <input id="add_bus_stop_latitude" tabindex="1"
																		type="text" class="form-control"
																		placeholder="latitude co-ordinate"
																		aria-describedby="basic-addon1"
																		style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
																</div>
															</div>
														</div>

														<!--submit buttons-->
														<div class="form-group row-fluid"
															style="height: 28px; padding: 0px; margin-bottom: 18px">
															<button id="add_bus_stop_close" type="button"
																class="btn btn-sm"
																style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-left: 10px">
																<span class="glyphicon glyphicon-remove"></span> CANCEL
															</button>
															<button id="add_bus_stop_add" type="button"
																class="btn btn-sm"
																style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
																<span class="glyphicon glyphicon-plus"></span> ADD
															</button>

															<!--submit animation logo-->
															<span id="add_bus_stop_loading_icon"
																data-toggle="tooltip" data-placement="bottom"
																title="Loading..."
																style="display: none; float: left; margin-left: 20px; margin-top: 3px"><img
																src="${actionLoadingIcon}" height="24" width="24"> <span
																style="font-weight: bold; font-size: 11px;"></span></span>
														</div>

													</div>
												</div>


												<!--<div class="panel-heading" style="height:8%; background:none; background-color:rgba(0,0,0,0.7); color:#FFF">
						<h3 class="panel-title">BUS STOP<small> lat/long</small></h3>
					  </div>-->

												<!--Temporary table heading during add new bus stop form shown up-->
												<div id="temp_bus_stop_table_header"
													style="display: none; margin-top: 32px; margin-left: 10px; margin-bottom: -8px">
													<h4>
														<span style="color: #4CAF50">CURRENT BUS STOPS</span><small>
															List of currently available Bus Stops.</small>
													</h4>
												</div>
												<!--No bus stop available message.-->
												<h2 id="display_bus_stop_table_not_available"
													style="display: none; color: #CCC; margin-left: 140px;">Not
													Available</h2>

												<div class="panel-body"
													style="padding: 0px; margin-left: -15px; width: 105%; font-family: Arial, Helvetica, sans-serif; font-size: 12px">


													<!--Bus stop table list section-->
													<div class="container-fluid">

														<table
															class="table table-condensed table-striped table-bordered"
															id="display_bus_stop_table">
															<thead>
																<tr
																	style="background-color: rgba(0, 0, 0, 0.8); color: #CCC">
																	<th style="text-align: center" width="8%">SN</th>
																	<th style="text-align: center" swidth="50%">BUS
																		STOP NAME</th>
																	<th style="text-align: center" width="25%">LONG/LAT</th>
																</tr>
															</thead>
															<tbody style="cursor: pointer">
																<!--<tr tabindex="1" data-toggle="tooltip" data-placement="bottom" title="Click to view location on Map">
							<td>1</td>
							<td style="padding-left:24px">Kalimati Bus Station</td>	
							<td style="text-align:center">85.283671, 27.716623</td>								
						  </tr>
						  <tr tabindex="1" data-toggle="tooltip" data-placement="bottom" title="Click to view location on Map">
							<td>1</td>
							<td style="padding-left:24px">Kalimati Bus Station</td>	
							<td style="text-align:center">85.283671, 27.716623</td>								
						  </tr>-->

															</tbody>
														</table>

													</div>
												</div>


											</div>




											<!--Delete and cancel bus stop button-->
											<div id="delete_bus_stop_apply_and_cancel_buttons"
												style="padding: 3px; margin-top: 5px; height: 10%; width: 100%; display: none; border-top: 1px dotted #BDBDBD">
												<button type="button" class="btn btn-sm"
													style="background-color: #FFF; border: 1px solid #9E9E9E; margin-left: 2px; margin-bottom: 20px; height: 32px; width: 96px"
													onClick="displayBusStopDeleteModal()">
													<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
													DELETE
												</button>

												<!--delete option close/cancel button-->
												<button type="button" class="btn btn-sm"
													style="background-color: #FFF; border: 1px solid #9E9E9E; margin-bottom: 20px; margin-left: 5px; height: 32px; width: 96px"
													onClick="cancelBusStopDeleteOption()">
													<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
													EXIT
												</button>


												<!--delete animation logo-->
												<span id="bus_stop_delete_loading_icon"
													data-toggle="tooltip" data-placement="bottom"
													title="Loading..."
													style="display: none; float: right; margin-right: 306px; margin-top: 3px"><img
													src="${actionLoadingIcon}" height="24" width="24"> <span
													style="font-weight: bold; font-size: 11px;"></span></span>
											</div>
										</div>


									</div>
									<div id="bus_stop_map_container" class="col-md-5"
										style="height: 100%; padding: 0px; margin: 0px">
										<div class="panel panel-default"
											style="padding: 0px; height: 100%; width: 100%">


											<!--Bus stop map section-->
											<div id="bus_stop_map" class="panel-body"
												style="height: 86%; width: 99.6%; visibility: visible; padding: 0px; margin: 1px">

											</div>

											<div class="panel-heading"
												style="height: 14%; background: none; background-color: #212121; color: #CCC">
												<h4 id="bus_stop_display_co_ordinates_on_map_footer"
													class="panel-title" style="margin-top: -2px;">
													BUS STOP: <span id="bus_stop_name">Not Selected</span><br>
													<small>LONGITUDE: <span id="bus_stop_longitude">Not
															Available</span>, LATITUDE: <span id="bus_stop_latitude">Not
															Available</span></small> <br>
													<small>(Select and click on the Bus Stop in the
														table list to view its location here.)</small>
												</h4>
												<h4 id="bus_stop_add_co_ordinates_on_map_footer"
													class="panel-title"
													style="display: none; margin-top: -6px;">
													ADD CO-ORDINATES <br>
													<small>LONGITUDE: <span
														id="add_bus_stop_map_longitude">Not Available</span>,
														LATITUDE: <span id="add_bus_stop_map_latitude">Not
															Available</span></small> <br>
													<small>(Pan around and click to pin location in the
														map)</small>

													<button id="bus_stop_map_footer_pin_location_button"
														type="button" class="btn btn-sm"
														style="background: none; background-color: #212121; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 42px; width: 96px; margin-top: -30px; color: #CCC">
														<span class="glyphicon glyphicon-pushpin"></span> ADD
													</button>
												</h4>
											</div>

										</div>
									</div>
								</div>
							</span>
						</div>

						<!--#####################################################################################################################################-->
						<!--route way section-->
						<!--#####################################################################################################################################-->
						<div role="tabpanel" class="tab-pane fade" id="route_way_tab"
							style="height: 100%; width: 100%">

							<span id="route_way_span_container"> <!--This span is used for hiding the section when reloading or loading-->


								<!--status message to display when no bus stops are available to display.-->
								<div id="route_way_display_status_message" style="display: none">
									<div class="col-md-1"></div>
									<div tabindex='1' class="alert in fade alert-success col-md-2"
										role="alert"
										style="height: 156px; width: 800px; margin-top: 12px; margin-left: 60px; background: none; border: 1px solid #595959">

										<h2 style="color: #595959;">
											<span style="color: #4CAF50"
												id="route_way_display_status_message_title"> ROUTE
												WAYS NOT AVAILABLE. </span><br>
											<small id="route_way_display_status_message_details">Currently,
												there are no any bus stops details are available to display
												here. You can add new Route and added Bus stops will be
												displayed here.</small>
										</h2>
									</div>
								</div>


								<div id="route_way_tab_main_container"
									class="container-fluid col-md-12"
									style="display: nonek; height: 88.5%; width: 100%; overflow-y: hidden !important; margin-top: 6px;">

									<!--Left route list panel -->
									<div class="col-md-3 panel panel-default"
										style="height: 100%; padding: 0px; margin: 0px">


										<!--main table section-->
										<div id="route_way_main_table_section"
											style="height: 100%; width: 100%; padding: 0px; overflow-y: auto !important;">


											<!--Update Success Message-->
											<div id="route_way_update_failed_message"
												class="alert alert-danger row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px; padding: 4px; padding-left: 12px">
												<strong>Update Failed.</strong><small> Something
													went wrong. Cannot update Route Way at the moment.</small>
											</div>

											<div id="route_way_update_success_message"
												class="alert alert-success row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px; padding: 4px; padding-left: 12px">
												<strong>Update Successful.</strong><small> The
													selected Route Way has been successfully updated.</small>
											</div>



											<!--Table heading for added route way list-->
											<div id="temp_route_way_table_header"
												style="display: nones; margin-left: 10px; margin-bottom: -8px">
												<h4>
													<span style="color: #4CAF50">WAYS ADDED</span><br>
													<small> List of currently available Route ways.</small>
												</h4>
											</div>


											<div id="bus_stop_delete_danger_message"
												class="alert alert-danger row-fluid" role="alert"
												style="display: none; font-size: 14px; height: 10%; margin: 5px">
												<strong>Delete Failed.</strong><small> Something
													went wrong. Cannot delete Bus Stop at the moment.</small>
											</div>
											<!--No bus stop available message.-->
											<h2 id="display_route_way_added_table_not_available"
												style="display: none; color: #CCC; margin-left: 32px;">Not
												Available</h2>


											<!--Bus stop table list section-->
											<div class="container-fluid"
												style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">

												<table
													class="table table-condensed table-striped table-bordered"
													id="display_added_route_way_table">

													<tbody>
													</tbody>
												</table>
											</div>


											<hr style="margin-top: 0px">

											<!--Table heading for not added route way list-->
											<div id="temp_route_way_table_header"
												style="display: nones; margin-left: 10px; margin-bottom: -8px">
												<h4>
													<span style="color: #4CAF50">NOT ADDED</span><br>
													<small> Ways are not added in following routes.</small>
												</h4>
											</div>
											<!--No bus stop available message.-->
											<h2 id="display_route_way_not_added_table_not_available"
												style="display: nohne; color: #CCC; margin-left: 32px;">Not
												Available</h2>


											<!--Bus stop table list section-->
											<div class="container-fluid"
												style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">

												<table
													class="table table-condensed table-striped table-bordered"
													id="display_not_added_route_way_table">

													<tbody style="cursor: pointer">

													</tbody>
												</table>
											</div>

											<hr style="margin-top: 0px">
										</div>

									</div>

									<!--Right map view panel-->
									<div id="route_way_map_container" class="col-md-9"
										style="height: 100%; padding: 0px; margin: 0px">
										<div class="panel panel-default"
											style="padding: 0px; height: 100%; width: 99.5%; margin-left: 1px; border: 1px solid #BDBDBD">

											<div style="height: 85%; width: 100%; padding: 0px">
												<!--loading animation-->
												<div id="route_way_map_loading"
													style="display: none; background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: 100%; width: 100%;"></div>

												<!--Bus stop map section-->
												<div id="route_way_map" class="panel-body"
													style="height: 100%; width: 100%; padding: 0px"></div>
											</div>
											<div class="panel-heading"
												style="height: 15%; background: none; background-color: #424242; color: #CCC">


												<!--no mode-->
												<h4 id="route_way_no_mode_footer" class="panel-title"
													style="margin-top: -8px">
													<small style="">MODE: NOT SELECTED</small>
													<hr style="margin: 0px; padding: 3px">
													ROUTE NAME: <span>NOT SELECTED</span> <br>
													<small style="font-size: 11px">(You can select to
														add, edit or view route ways for selected route from left
														panel option menu.)</small>
												</h4>


												<!--view mode-->
												<h4 id="route_way_view_mode_footer" class="panel-title"
													style="display: none; margin-top: -8px">
													<small style="">VIEW MODE</small> <span
														id="route_way_view_mode_exit"
														style="float: right; cursor: pointer; margin-top: 1px"
														data-toggle="tooltip" placement="top" title="Exit Mode"
														class="glyphicon glyphicon-remove-circle"></span>

													<hr style="margin: 0px; padding: 3px; margin-top: 4px">
													ROUTE NAME: <span id="route_way_view_mode_name">Not
														Selected</span>
													<!--<button  id="route_way_view_mode_clear_button" type="button" class="btn btn-sm" style="background:none; color:#CCC; border:1px solid #9E9E9E; padding:0px; height:28px;width:100px;float:right" onClick=""><span class="glyphicon glyphicon-erase"></span> CLEAR MAP</button>-->
													<br>
													<small style="font-size: 11px">(Please, select to
														view Route Way from the option menu for selected Route in
														Ways Added Route Way section left.)</small>
												</h4>

												<!--add mode-->
												<h4 id="route_way_add_mode_footer" class="panel-title"
													style="display: none; margin-top: -6px;">
													<small style="">ADD WAY MODE</small>
													<!--<span id="route_way_add_mode_exit" style="float:right; cursor:pointer; margin-top:1px" data-toggle="tooltip" placement="top" title="Cancel" class="glyphicon glyphicon-remove-circle"></span>-->
													<button id="route_way_add_mode_exit" type="button"
														class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 18px; width: 62px; float: right"
														onClick="">
														<span class="glyphicon glyphicon-remove"></span> EXIT
													</button>


													<span
														style="margin-top: 6px; margin-right: 18px; float: right; font-size: 11px">You
														can add marker following route way in the Map above. Note:
														Click once to add marker and twice to remove it.</span>

													<hr style="margin: 0px; padding: 3px; margin-top: 4px">


													ROUTE NAME: <span id="route_way_add_mode_name">Not
														Selected</span>
													<button id="route_way_add_mode_add_button" type="button"
														class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 28px; width: 100px; float: right; margin-top: 3px"
														onClick="">
														<span class="glyphicon glyphicon-plus"></span> ADD WAY
													</button>

													<button id="route_way_add_mode_way_list_button"
														type="button" class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 28px; width: 100px; float: right; margin-top: 3px"
														onClick="">
														<span class="glyphicon glyphicon-list-alt"></span> RAW
														LIST
													</button>

													<br>
													<small style="font-size: 11px">(Please, select to
														add Route Way from the option menu for selected Route in
														Not Added Route Way section left.)</small>

												</h4>


												<!--edit/update mode-->
												<h4 id="route_way_edit_mode_footer" class="panel-title"
													style="display: none; margin-top: -6px;">
													<small style="">EDIT WAY MODE</small>
													<!--<span id="route_way_add_mode_exit" style="float:right; cursor:pointer; margin-top:1px" data-toggle="tooltip" placement="top" title="Cancel" class="glyphicon glyphicon-remove-circle"></span>-->
													<button id="route_way_edit_mode_exit" type="button"
														class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 18px; width: 62px; float: right"
														onClick="">
														<span class="glyphicon glyphicon-remove"></span> EXIT
													</button>


													<span
														style="margin-top: 6px; margin-right: 18px; float: right; font-size: 11px">You
														can add marker following route way in the Map above. Note:
														Click once to add marker and twice to remove it.</span>

													<hr style="margin: 0px; padding: 3px; margin-top: 4px">


													ROUTE NAME: <span id="route_way_edit_mode_name">Not
														Selected</span>
													<button id="route_way_update_mode_add_button" type="button"
														class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 28px; width: 100px; float: right; margin-top: 3px"
														onClick="">
														<span class="glyphicon glyphicon-arrow-up"></span> UPDATE
														WAY
													</button>

													<button id="route_way_edit_mode_way_list_button"
														type="button" class="btn btn-sm"
														style="background: none; color: #CCC; border: 1px solid #9E9E9E; padding: 0px; height: 28px; width: 100px; float: right; margin-top: 3px"
														onClick="">
														<span class="glyphicon glyphicon-list-alt"></span> RAW
														LIST
													</button>

													<br>
													<small style="font-size: 11px">(Please, select to
														edit Route Way from the option menu for selected Route in
														Added Route Way section left.)</small>

												</h4>
											</div>

										</div>
									</div>
								</div>









							</span>


						</div>



						<!--#####################################################################################################################################-->
						<!--Stops distance section-->
						<!--#####################################################################################################################################-->
						<div role="tabpanel" class="tab-pane fade" id="stops_distance_tab"
							style="height: 100%; width: 100%">

							<span id="stops_distance_span_container"> <!--This span is used for hiding the section when reloading or loading-->


								<!--status message to display when no bus stops are available to display.-->
								<div id="stops_distance_display_status_message"
									style="display: none">
									<div class="col-md-1"></div>
									<div tabindex='1' class="alert in fade alert-success col-md-2"
										role="alert"
										style="height: 156px; width: 800px; margin-top: 12px; margin-left: 60px; background: none; border: 1px solid #595959">

										<h2 style="color: #595959;">
											<span style="color: #4CAF50"
												id="stops_distance_display_status_message_title">
												ROUTE WAYS NOT AVAILABLE. </span><br>
											<small id="stops_distance_display_status_message_details">Currently,
												there are no any bus stops details are available to display
												here. You can add new Route and added Bus stops will be
												displayed here.</small>
										</h2>
									</div>
								</div>


								<div id="stops_distance_tab_main_container"
									class="container-fluid col-md-12"
									style="display: nonek; height: 88.5%; width: 100%; overflow-y: hidden !important; margin-top: 6px;">




									<!--Left route list panel -->
									<div class="col-md-4 panel panel-default"
										style="height: 100%; padding: 0px; margin: 0px">


										<!--main table section-->
										<div id="stops_distance_main_table_section"
											style="height: 100%; width: 100%; padding: 0px; overflow-y: auto !important;">


											<!--Table heading for added route way list-->
											<div id="stops_distance_left_panel_table_header"
												style="display: nones; margin-left: 10px; margin-bottom: -8px">
												<h4>
													<span style="color: #4CAF50">ROUTES</span><br>
													<small> List of currently available Routes.</small>
												</h4>
											</div>

											<!--No bus stop available message.-->
											<h2 id="stops_distance_routes_not_available_msg"
												style="display: none; color: #CCC; margin-left: 32px;">Not
												Available</h2>


											<!--Bus stop table list section-->
											<div class="container-fluid"
												style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px">

												<table
													class="table table-condensed table-striped table-bordered"
													id="stops_distance_route_table">

													<tbody>
													</tbody>
												</table>
											</div>


											<hr style="margin-top: -12px">
										</div>

									</div>

									<!--Right map view panel-->
									<div id="stops_distance_container" class="col-md-8"
										style="height: 100%; padding: 0px; margin: 0px">
										<div class="panel panel-default"
											style="padding: 0px; height: 100%; overflow-y: hidden !important; width: 99.5%; margin-left: 1px; border: 1px solid #BDBDBD">

											<div
												style="display: nones; margin: 0px; margin-left: 10px; height: 9%">
												<h4>
													<span style="color: #4CAF50">STOPS DISTANCE</span> <br>
													<small> List of distance to all the available Bus
														stops from the starting Bus stop for particular Route. </small>

												</h4>
											</div>

											<hr style="margin: 0px">

											<div
												style="height: 91%; width: 100%; padding: 0px; text-align: center; overflow-y: auto !important">
												<!--loading animation-->
												<div id="stops_distance_right_panel_loading"
													style="display: none; background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: 100%; width: 100%; overflow-x: hidden; overflow-y: hidden"></div>


												<!--Table heading for added route way list-->




												<!--Bus stop table list section-->
												<div class="container-fluid"
													style="padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; padding: 18px; margin-top: -12px; overflow-y: auto !important">

													<!--No bus stop available message.-->
													<h5 id="stops_distance_distance_not_set_msg"
														style="display: none; font-size: 11px">Stops distance
														is not set. Please, click to EDIT Button on the left panel
														option menu to add distance.</h5>


													<table
														class="table table-condensed table-striped table-bordered"
														id="stops_distance_table">
														<thead>
															<tr style="background: #424242; color: #CCC">
																<th style="text-align: center" width="5%">SN</th>
																<th style="text-align: center" width="30%">DISTANCE
																	(KM)</th>
																<th style="text-align: center" width="60%">BUS
																	STOPS</th>
															</tr>
														</thead>
														<tbody>
														</tbody>
													</table>

													<!--Stops distance save message-->
													<div id="stops_distance_save_succes_message"
														class="alert alert-success row-fluid" role="alert"
														style="display: none; font-size: 14px; height: 10%; margin: 5px">
														<strong>SAVE SUCCESSFUL.</strong><small> The
															distance between the Bus stops of selected route has been
															successfully saved.</small>
													</div>

													<div id="stops_distance_save_failed_message"
														class="alert alert-danger row-fluid" role="alert"
														style="display: none; font-size: 14px; height: 10%; margin: 5px">
														<strong>Delete Failed.</strong><small> Something
															went wrong. Cannot save Bus Stop distance at the moment.</small>
													</div>



													<!--Update/Add and cancel bus stop button-->
													<div id="stops_distance_save_exit_buttons"
														style="text-align: left; padding: 3px; padding-left: 0px; margin-top: 5px; height: 10%; width: 100%; display: none; float: left; border-top: 1px dotted #BDBDBD">
														<button type="button" class="btn btn-sm"
															style="background-color: #FFF; border: 1px solid #9E9E9E; margin-left: 2px; margin-bottom: 20px; height: 32px; width: 96px"
															onClick="saveStopsDistance()">
															<span class="glyphicon glyphicon-trash"
																aria-hidden="true"></span> SAVE
														</button>

														<!--delete option close/cancel button-->
														<button type="button" class="btn btn-sm"
															style="background-color: #FFF; border: 1px solid #9E9E9E; margin-bottom: 20px; margin-left: 5px; height: 32px; width: 96px"
															onClick="cancelStopsDistanceAdd()">
															<span class="glyphicon glyphicon-remove"
																aria-hidden="true"></span> EXIT
														</button>


														<!--delete animation logo-->
														<span id="stops_distance_save_loading_icon"
															data-toggle="tooltip" data-placement="bottom"
															title="Loading..."
															style="display: none; float: right; margin-right: 306px; margin-top: 3px"><img
															src="${actionLoadingIcon}" height="24" width="24"> <span
															style="font-weight: bold; font-size: 11px;"></span></span>
													</div>

												</div>

												<!--No bus stop available message.-->
												<h1 id="stops_distance_distance_not_available_msg"
													style="display: nonde; color: #CCC; margin-top: 120px">Not
													Available</h1>


											</div>
										</div>
									</div>
								</div>


							</span>


						</div>

					</div>

				</div>
			</div>
		</div>
	</div>


	<!--loading icon animation-->
	<div id="loading_2"
		style="background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: auto; width: auto; position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin-left: 460px; auto; position: absolute; z-index: 9999; display: none"></div>

	<div id="loading_1"
		style="background: url('${loadingIcon}'); background-repeat: no-repeat; background-position: center center; height: auto; width: auto; position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin-left: 120px; position: absolute; z-index: 9999; display: none"></div>


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


	<!--Action Modal-->
	<div id="action_modal" class="modal fade"
		style="margin-top: 120px; padding: 40px">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"
					style="height: 42px; padding: 8px; border-top-left-radius: 5px; border-top-right-radius: 5px; background: #424242; color: #FFF; text-align: center">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="action_modal_title" class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<span style="font-size: 16px" id="action_modal_content"></span>
				</div>
				<div class="modal-footer">
					<button id="action_modal_cancel" type="button" class="btn btn-sm"
						data-dismiss="modal"
						style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-left: 10px">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						CANCEL
					</button>
					<button id="action_modal_delete" type="button" class="btn btn-sm"
						data-dismiss="modal"
						style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						DELETE
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<!--Action Modal Exit-->
	<div id="action_modal_exit" class="modal fade"
		style="margin-top: 120px; padding: 40px">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"
					style="height: 42px; padding: 8px; border-top-left-radius: 5px; border-top-right-radius: 5px; background: #424242; color: #FFF; text-align: center">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="action_modal_exit_title" class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<span style="font-size: 16px" id="action_modal_exit_content"></span>
				</div>
				<div class="modal-footer">
					<button id="action_modal_exit_cancel" type="button"
						class="btn btn-sm" data-dismiss="modal"
						style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-left: 10px">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						CANCEL
					</button>
					<button id="action_modal_exit_ok" type="button" class="btn btn-sm"
						data-dismiss="modal"
						style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> OK
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<!--Modal for displaying edit route form.-->
	<div id="modal_update_route" class="modal fade"
		style="height: 100%; margin-top: 20px;" data-keyboard="false"
		data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header"
					style="height: 38px; padding: 8px; background: #424242; color: #FFF; border-top-left-radius: 5px; border-top-right-radius: 5px; border: 1px solid rgba(255, 255, 255, 0.3); text-align: center">
					<h4 id="modal_update_route_title" class="modal-title">UPDATE
						ROUTE DETAILS</h4>
				</div>
				<div id="edit_route_modal_body" class="modal-body">
					<!--Edit main content-->
					<!--Add route form-->
					<div class="form-group row-fluid">
						<!--<label class="col-md-3 control-label"  style="margin-top:6px">Add Name:</label>-->
						<div class="input-group col-md-12">
							<span class="input-group-addon" id="basic-addon1"
								style="font-weight: normal; font-size: 12px; width: 110px; color: #000">ROUTE
								NAME</span> <input id="modal_update_route_routeName" tabindex="1"
								type="text" class="form-control" placeholder="Enter Route Name"
								aria-describedby="basic-addon1"
								style="font-size: 12px; padding-left: 10px; color: #000;">
						</div>
					</div>
					<div class="form-group row-fluid">
						<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
						<div class="input-group col-md-12">
							<span class="input-group-addon"
								style="font-weight: normal; font-size: 12px; width: 110px; color: #000">BUS
								STOP</span> <select id="modal_update_route_stop_dropdown"
								class="form-control tooltip-bottom" placeholder="apple"
								title="Select Bus stop from the list."
								style="height: 28px; font-size: 12px; padding: 0px; color: #000">
								<option id="update_select_stop_from_list">SELECT BUS
									STOP</option>
								<!--<option>Kalimati Bus Station</option>
										<option>Soyambhu Bus Station</option>
										<option>Kalanki Bus Station</option>
										<option>SahidGet Bus Station</option>
										<option>SahidGet Bus Station1</option>
										<option>SahidGet Bus Station2</option>
										<option>SahidGet Bus Station3</option>
										<option>SahidGet Bus Station4</option>
										<option>SahidGet Bus Station5</option>
										<option>SahidGet Bus Station6</option>
										<option>SahidGet Bus Station7</option>
										<option>SahidGet Bus Station8</option>
										<option>SahidGet Bus Station9</option>
										<option>SahidGet Bus Station10</option>-->
							</select>
						</div>
					</div>


					<div class="row-fluid form-group">
						<label class="col-md-10 control-label"
							style="margin-top: -5px; margin-left: -10px; font-weight: normal; color: #757575; font-size: 12px">
							Select and add required Bus Stops from the dropdown list.</label>
						<button id="modal_button_add_busstop_to_list" type="button"
							class="btn btn-sm pull-right" data-toggle="tooltip"
							data-placement="bottom" title="Add to Bus Stop List."
							style="border: 1px solid #BDBDBD; background: none; margin-top: -8px; margin-bottom: 12px; height: 24px; width: 52px; padding: 0px"
							onClick="addFromDropDownToStopList()">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</div>



					<div class="form-group row-fluid">
						<div class="panel-heading col-md-12"
							style="font-weight: bold; background: none; border: none; height: 32px; padding: 1px;">
							<h5 style="font-weight: bold">
								BUS STOP LISTS<small> (You can also drag and drop the
									rows to re-arrange the order.)</small>
							</h5>
						</div>

						<div class="panel panel-default col-md-12" style="padding: 0px">
							<!-- Default panel contents to display bus stop list after user select and add the stop from the dropdown-->


							<!-- Table -->
							<table class="table table-condensed table-striped table-bordered"
								id="modal_update_route_selected_stop_list"
								style="font-size: 12px">
								<tbody>
								</tbody>
							</table>
						</div>
					</div>

					<!--Edit content end-->
				</div>
				<div class="modal-footer"
					style="margin-top: 12px; margin-bottom: -10px">

					<div class="form-group row-fluid">
						<button id="route_update_close_button" type="button"
							class="btn btn-sm" data-dismiss="modal"
							style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-left: 10px">
							<span class="glyphicon glyphicon-remove"></span> CLOSE
						</button>
						<button id="route_update_submit_button" type="button"
							class="btn btn-sm"
							style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
							<span class="glyphicon glyphicon-circle-arrow-left"></span>
							UPDATE
						</button>

						<!--submit animation logo-->
						<span id="route_update_loading_icon" data-toggle="tooltip"
							data-placement="bottom" title="Loading..."
							style="display: none; float: left; margin-left: 20px; margin-top: 3px"><img
							src="${actionLoadingIcon}" height="24" width="24"> <span
							style="font-weight: bold; font-size: 11px;"></span></span>
					</div>

				</div>

				<!--Status messages-->
				<div class="form-group container-fluid" style="padding-bottom: 28px">
					<div id="route_update_success_message"
						class="alert alert-success row-fluid" role="alert"
						style="display: none; height: 48px; margin-bottom: -8px">
						<strong>Update Successful.</strong><small> New changes to
							the selected Route has been successfully updated.</small>
					</div>
					<div id="route_update_error_message"
						class="alert alert-danger row-fluid" role="alert"
						style="display: none; height: 48px; margin-bottom: -8px">
						<strong>Update Failed.</strong><small> Error occured while
							making updating the new changes of selected Route.</small>
					</div>
					<div id="route_update_warning_message" tabindex="1"
						class="alert alert-warning row-fluid" role="alert"
						style="display: none; height: 48px; margin-bottom: -8px">
						<strong>Information Invalid.</strong><small> --set by
							javascript--</small>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->



	<!-- Modal for Bus stop Edit and Update -->
	<div class="modal fade" id="modal_update_bus_stop"
		style="height: 100%; margin-top: 20px;" data-keyboard="false"
		data-backdrop="static" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header"
					style="height: 38px; padding: 8px; background: #424242; color: #FFF; border-top-left-radius: 5px; border-top-right-radius: 5px; border: 1px solid rgba(255, 255, 255, 0.3); text-align: center">
					<h4 id="modal_update_route_title" class="modal-title">UPDATE
						BUS STOP DETAILS</h4>
				</div>
				<div class="modal-body">

					<!--############################# FORM SECTION-->
					<div class="panel-body"
						style="border: 1px solid #BDBDBD; height: 152px; margin: -8px">
						<div class="form-group row-fluid" style="margin-top: -8px">
							<div class="input-group col-md-12">
								<span class="input-group-addon"
									style="width: 102px; font-size: 12px; color: #000">NAME:
								</span> <input id="update_bus_stop_enter_name" tabindex="1" type="text"
									class="form-control" placeholder="Enter Bus Stop Name"
									aria-describedby="basic-addon1"
									style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
							</div>
						</div>


						<div class="form-group row-fluid"
							style="padding-left: 18px; padding-right: 18px; border: 1px solid #BDBDBD; background-color: #E0E0E0; height: 96px; margin-top: -6px">
							<div class="input-group col-md-12" style="margin-top: -6px">
								<span class="label label-default"
									style="display: block; font-size: 12px; height: 28px; padding: 14px; background: none; color: #000;">LOCATION
									CO-ORDINATES</span>
							</div>

							<div class="form-group row-fluid">
								<div class="input-group col-md-12">
									<span class="input-group-addon"
										style="width: 102px; font-size: 12px; color: #000">LONGITUDE:
									</span> <input id="update_bus_stop_longitude" tabindex="1" type="text"
										class="form-control" placeholder="longitude co-ordinate"
										aria-describedby="basic-addon1"
										style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
								</div>
							</div>
							<div class="form-group row-fluid" style="margin-top: -10px">
								<div class="input-group col-md-12">
									<span class="input-group-addon"
										style="width: 102px; font-size: 12px; color: #000">LATITUDE:
									</span> <input id="update_bus_stop_latitude" tabindex="1" type="text"
										class="form-control" placeholder="latitude co-ordinate"
										aria-describedby="basic-addon1"
										style="height: 28px; font-size: 12px; border: 1px solid #BDBDBD; color: #000">
								</div>
							</div>
						</div>

					</div>


					<!--############################# MAP SECTION-->
					<div id="bus_stop_update_map"
						style="height: 280px; margin-top: 16px; margin-left: -7px; margin-right: -7px; border: 1px solid #BDBDBD">

					</div>
					<div class="panel-heading"
						style="height: 42px; background: none; background-color: #212121; color: #CCC; margin-bottom: -10px; margin-left: -7px; margin-right: -7px">
						<h5 id="bus_stop_update_co_ordinates_on_map" class="panel-title"
							style="margin-top: -6px;">
							ADD CO-ORDINATES <br>
							<small>LONGITUDE: <span
								id="update_bus_stop_map_longitude">Not Available</span>,
								LATITUDE: <span id="update_bus_stop_map_latitude">Not
									Available</span></small>

							<button id="update_bus_stop_map_footer_pin_location_button"
								type="button" class="btn btn-sm"
								style="background: none; background-color: #212121; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-top: -16px; color: #CCC">
								<span class="glyphicon glyphicon-pushpin"></span> ADD
							</button>
						</h5>
					</div>

				</div>
				<div class="modal-footer" style="height: 40px; padding: 5px">
					<div class="form-group row-fluid">
						<button id="bus_stop_update_close_button" type="button"
							class="btn btn-sm" data-dismiss="modal"
							style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px; margin-left: 10px">
							<span class="glyphicon glyphicon-remove"></span> CLOSE
						</button>
						<button id="bus_stop_update_submit_button" type="button"
							class="btn btn-sm"
							style="background: none; border: 1px solid #9E9E9E; float: right; padding: 0px; height: 32px; width: 96px">
							<span class="glyphicon glyphicon-circle-arrow-left"></span>
							UPDATE
						</button>

						<!--submit animation logo-->
						<span id="bus_stop_update_loading_icon" data-toggle="tooltip"
							data-placement="bottom" title="Loading..."
							style="display: none; float: left; margin-left: 20px; margin-top: 3px"><img
							src="${actionLoadingIcon}" height="24" width="24"> <span
							style="font-weight: bold; font-size: 11px;"></span></span>
					</div>
				</div>
				<!--Status messages-->
				<div class="form-group container-fluid">
					<div id="bus_stop_update_warning_message" tabindex="1"
						class="alert alert-danger row-fluid" role="alert"
						style="display: none; height: 48px; margin-bottom: -8px; margin-left: -7px; margin-right: -7px; margin-top: 5px">
						<strong>Information Invalid.</strong><small> --set by
							javascript--</small>
					</div>
				</div>
			</div>
		</div>
	</div>



	<br>
	<!-- Footer -->
	<div class="navbar-header"
		style="position: fixed; bottom: 0; width: 100%; height: 40px; background: #212121">
		<div style="text-align: center; font-size: 11px; color: #DDD">
			<div class="container" style="margin-top: 5px">
				<span><strong style="color: #4CAF50">Copyright
						&copy; sybus.com 2015 </strong><br> SAJHA YATAYAT VEHICLE TRACKING AND
					MANAGEMENT SYSTEM (SYBUS) </span>
			</div>
		</div>
	</div>
	<!--Javascript section-->
	<!-- Latest compiled JQuery JavaScript -->
	<script src="${jqueryJs}"></script>
	<script src="js/jquery-ui.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="${bootstrapJs}"></script>

	<!--Leaflet javascript imports-->
	<script src='${leafletJs}'></script>
	<script src='${leafletLabelJs}'></script>
	<script src='${leafletZoomdisplayJs}'></script>
	<script src='${leafletPolylineDecoratorJs}'></script>
	<script src="${leafletAwesomeMarkersJs}"></script>
	<script src="leaflet/leaflet_numbered_markers.js"></script>
	<script src="${leafletEasyButtonJs}"></script>

	<script src='${leafletLabelJs}'></script>

	<script type="text/javascript">
	
	
	  //start route tab section javascript codes.
	  //Hide the route add section when page is loaded and display it if add is clicked or hide is if hide it clicked.
			//initially disabling the various buttons / in case of reload during edit mode these buttons will remains as disabled in firefox so to avoid this problem using this.
			
						$("#add_button").prop("disabled", false);  //re enabling the add button
						$("#edit_button").prop("disabled", false);  //re enabling the edit button
						$("#delete_button").attr("disabled", false); //re enabling the delete button  
						$("#content_header_button_refresh").attr("disabled", false);   
			
			
			var globalTabName = "route";		//initial tab when page load is route
			
			$(document).ready(function() {	
			//original state of the add route form. so that it can use when it is closed the filled form will not appear when re-opening/adding new route.
			//var originalStateOfAddRouteForm = $("#add_route_section").clone();
			
			//page utilities javascripts

			//bootstrap tooltip activation
			$('[data-toggle="tooltip"]').tooltip();
			$('button').click(function(){$(this).tooltip('hide')});
			$('tr').click(function(){$(this).tooltip('hide')});
			
			//bootstrap popover activation
			$('[data-toggle="popover"]').popover();
			
			//setting header title first when page is loaded.
			//initially setting route tab header.
			setTabHeader("CURRENT ROUTES", " List of currently available Routes.");
			activateHeaderButton("refresh");  //initially setting refresh button
			//Now setting header according tab click
			$("#route_tab_header").click(function (){
				setTabHeader("CURRENT ROUTES", " List of currently available Routes.");
				globalTabName = "route";
			});
			$("#bus_stop_tab_header").click(function (){
				setTabHeader("CURRENT BUS STOPS", " List of currently available Bus Stops.");
				globalTabName = "bus_stop";				
				//loadBusStopData();
			});
			$("#route_way_tab_header").click(function (){
				setTabHeader("CURRENT ROUTE WAYS", " List of currently available Route Ways for Map.");
				globalTabName = "route_way";
			});
			
			$("#stops_distance_tab_header").click(function (){
				setTabHeader("STOPS DISTANCE", " List of distances between currently available Route's stops.");
				globalTabName = "stops_distance";
			});

			
			//displaying no rows message if no routes are available
			//displayRouteDetailAlertMessage();

			
				//if the + button on top clicked show the add route form.
				$("#add_button").click(function(){
					//alert(globalTabName);
					if(globalTabName=="route"){
						displayAddRouteForm();
					}
					else if(globalTabName=="bus_stop"){
						displayAddBusStopForm();
					}
					else if(globalTabName=="route_way"){
					
					}
					
				});//if the edit button on top clicked show the edit action.
				$("#edit_button").click(function(){					
					if(globalTabName=="route"){
						displayEditRouteOption();
					}
					else if(globalTabName=="bus_stop"){
						displayEditBusStopOption();
					}
					else if(globalTabName=="route_way"){
					
					}
				});//if the delete button on top clicked show the delete action
				$("#delete_button").click(function(){				
					if(globalTabName=="route"){
						displayDeleteRouteOption();
					}
					else if(globalTabName=="bus_stop"){
						displayBusStopDeleteOption();
					}
					else if(globalTabName=="route_way"){
					
					}
				});
				//closing the add route div
				/*$("#content_header_button").click(function(){	
					exitAddRouteForm();
				});*/
				
				//Add route detail section
				//getting the bus stop name from dropdown and adding it to the table view of the form.
				$("#add_busstop_to_route_button").click(function(){
					addStopsToAddRouteFormStopList();
				});
				
				//THis function close the alert modal
				/*$("#alert_modal_close").click(function (){
					$('#alert_modal').modal('hide');
				});*/
			});
			
			//Setting header and title Javascript codes
			function setTabHeader(title, subtitle){				
				$("#content_header_title").text(title);
				$("#content_header_subtitle").text(subtitle);	
				$("#content_header").hide();				
				$("#content_header").fadeIn(500);
			}
			
			//this function sets the header action button either close or refresh.
			function activateHeaderButton(name){
				if(name=="close"){	
					$("#content_header_button_close").fadeIn("slow");
					$("#content_header_button_refresh").hide();
					$("#content_header_button_save").hide();
					$("#content_header_button_exit").hide();
				}
				else if(name=="refresh"){	
					$("#content_header_button_refresh").fadeIn("slow");	
					$("#content_header_button_close").hide();	
					$("#content_header_button_save").hide();	
					$("#content_header_button_exit").hide();					
				}
				else if(name=="edit"){		
					$("#content_header_button_save").fadeIn("slow");
					$("#content_header_button_exit").fadeIn("slow");	
					$("#content_header_button_close").hide();
					$("#content_header_button_refresh").hide();				
				}
			
			}
			
			//this function disable the add, edit and delete buttons on the top
			function disableAddEditDeleteButtons(){
				
						$("#add_button").prop("disabled", true);  //re enabling the add button
						$("#edit_button").prop("disabled", true);  //re enabling the edit button
						$("#delete_button").attr("disabled", true); //re enabling the delete button
			}
			
						
			//this function disable the add, edit and delete buttons on the top
			function enableAddEditDeleteButtons(){
				
						$("#add_button").prop("disabled", false);  //re enabling the add button
						$("#edit_button").prop("disabled", false);  //re enabling the edit button
						$("#delete_button").attr("disabled", false); //re enabling the delete button
			}

			//refresh button for refreshing the main content only.
			function refresh(){	
				$("#loading_1").fadeIn();			
				if(globalTabName=="route"){
					//$("#route_tab_header").hide();
					//setTimeout(function(){						
					//	$("#route_tab_header").fadeIn(100);
					//},2000);
				/*
					$("#loading_1").fadeIn();
					$("#routes_tab").hide();
					$("#refresh_icon").fadeIn();
					alert(document.URL);
					setTimeout(function(){
						$("#routes_tab").load( document.URL +  ' #routes_tab', function(){
							$("#loading_1").fadeOut();							
							$("#refresh_icon").fadeOut();
							$("#routes_tab").show();
						});										
					},1000);
				*/
					//hiding the page untill the data is loaded.
					$("#route_tab_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#route_tab_span_container").fadeIn();
					},2000);
					
					//removing all the table data.
					$("#display_route_table tbody").empty();
					
					//loading the new data from the server.
					loadRouteData();		
				}
				else if(globalTabName=="bus_stop"){
				
				//IF HIDE THIS BUS STOP TAB THE ROUTE WAY TAB WILL NOT DISPLAYED MAY BE BUG>>>>
				
					$("#bus_stop_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#bus_stop_span_container").fadeIn();
					},2000);
					
					//removing all the table data.
					$("#display_bus_stop_table tbody").empty();
					
					//loading the new data from the server.
					loadBusStopData();	
					setDefaultMapState();
				}
				else if(globalTabName=="route_way"){
					
					$("#route_way_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#route_way_span_container").fadeIn();
					},2000);
					
					//removing all the table data added and not added both.
					$("#display_added_route_way_table tbody").empty();
					$("#display_not_added_route_way_table tbody").empty();
						
					//resetting map
					setDefaultRouteWayMapFooter(); 	//setting default map footer
					setRouteWayMapView(true, true);	//setting default view on map.
					wayMarkersGroup.clearLayers();	//clearing the all markers
					map_route_way.removeLayer(wayMarkersGroup);	//clearing the all markers
					markerIndex = 1;//resetting teh index	
					
					//reloading data and setting it
					loadRouteWayData();			//loading the routeway data.
					loadRouteWayDataToPage();	//adding loaded data to page.
				}
				else if(globalTabName=="stops_distance"){
				
				
					$("#stops_distance_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#stops_distance_span_container").fadeIn();						
					},2000);
					
					loadStopsDistanceData();
					
					$("#stops_distance_table tbody").empty();					
					
					//resetting focus color of other rows.
						$("#stops_distance_route_table tbody").find("tr").each(function(){
					$(this).find("td").css({"color":"#424242","font-weight":"normal"});
					
					$("#stops_distance_distance_not_available_msg").fadeIn();
				});
				
				}
			}
			
			//this function displays loading animation when each tab is loaded for the first time only.
			var first_time_route_tab_loaded = false;
			var first_time_bus_stop_tab_loaded = false;
			var first_time_route_way_tab_loaded = false;
			var first_time_stops_distance_tab_loaded = false;
			
			function firstTimeTabLoadinAnimation(){
				//route tab section			
				if(first_time_route_tab_loaded==false && globalTabName=="route"){			
					$("#loading_1").fadeIn();
					$("#route_tab_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#route_tab_span_container").fadeIn();
					},800);
					first_time_route_tab_loaded=true;
				}
				//bus stop tab section
				else if(first_time_bus_stop_tab_loaded==false && globalTabName=="bus_stop"){			
					$("#loading_1").fadeIn();	
					$("#bus_stop_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#bus_stop_span_container").fadeIn();
					},800);
					first_time_bus_stop_tab_loaded=true;
				}
				//route way tab section
				if(first_time_route_way_tab_loaded==false && globalTabName=="route_way"){			
					$("#loading_1").fadeIn();	
					$("#route_way_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#route_way_span_container").fadeIn();
					},800);
					first_time_route_way_tab_loaded=true;
				}
				//route way tab section
				if(first_time_stops_distance_tab_loaded==false && globalTabName=="stops_distance"){			
					$("#loading_1").fadeIn();	
					$("#stops_distance_span_container").hide();
					setTimeout(function(){						
						$("#loading_1").fadeOut();					
						$("#stops_distance_span_container").fadeIn();
					},800);
					first_time_stops_distance_tab_loaded=true;
				}
			}
			
			//###############ROUTE SECTION###########################################
			
			//this doesnot work at all....
			/*$("body").on("shown.bs.tab", "#route_tab_header", function() {
				//tab loading animation 
				firstTimeTabLoadinAnimation();
			});*/
			firstTimeTabLoadinAnimation();
			
			//example codes JSON OBJECTS
			var route1 = {name:"Route 1", stops:[{name:"Swayambhu Bus Station", latitude:27.71595, longitude:85.28364},{name:"Sitapaila Bus Station", latitude:27.70743, longitude:85.28263},{name:"Kalanki Bus Station", latitude:27.69337, longitude:85.28174},{name:"SoaltiMood Bus Station", latitude:27.69664, longitude:85.29356},{name:"Kalimati Bus Station", latitude:27.69835, longitude:85.29960},{name:"Teku Bus Station", latitude:27.69667, longitude:85.30570},{name:"Tripureshwor1 Bus Station", latitude:27.69462, longitude:85.31135},{name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336},{name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357},{name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666},{name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819},{name:"Hattisar Bus Station", latitude:27.71099, longitude:85.32210},{name:"Kamalpokhari Bus Station", latitude:27.71010, longitude:85.32514},{name:"Gyaneshwor Bus Station", latitude:27.70866, longitude:85.33199},{name:"Maitidevi Bus Station", latitude:27.70830, longitude:85.33338},{name:"Ratopul Bus Station", latitude:27.70811, longitude:85.33626},{name:"Gaushala Bus Station", latitude:27.70780, longitude:85.34334},{name:"Tilganga Bus Station", latitude:27.70613, longitude:85.34959},{name:"Airport Bus Station", latitude:27.70019, longitude:85.35411}]};
			
			var route2 = {name:"Route 2", stops:[{name:"Swayambhu Bus Station", latitude:27.71595, longitude:85.28364},{name:"Sitapaila Bus Station", latitude:27.70743, longitude:85.28263},{name:"Kalanki Bus Station", latitude:27.69337, longitude:85.28174},{name:"SoaltiMood Bus Station", latitude:27.69664, longitude:85.29356},{name:"Kalimati Bus Station", latitude:27.69835, longitude:85.29960},{name:"Teku Bus Station", latitude:27.69667, longitude:85.30570},{name:"Tripureshwor1 Bus Station", latitude:27.69462, longitude:85.31135},{name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336},{name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357},{name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666},{name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819}]};
			
			var route3 = {name:"Route 3", stops:[{name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336},{name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357},{name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666},{name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819},{name:"Hattisar Bus Station", latitude:27.71099, longitude:85.32210},{name:"Kamalpokhari Bus Station", latitude:27.71010, longitude:85.32514},{name:"Gyaneshwor Bus Station", latitude:27.70866, longitude:85.33199},{name:"Maitidevi Bus Station", latitude:27.70830, longitude:85.33338}]};
			
			var route4 = {name:"Route 4", stops:[{name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336},{name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357},{name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666},{name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819},{name:"Hattisar Bus Station", latitude:27.71099, longitude:85.32210},{name:"Kamalpokhari Bus Station", latitude:27.71010, longitude:85.32514},{name:"Gyaneshwor Bus Station", latitude:27.70866, longitude:85.33199},{name:"Maitidevi Bus Station", latitude:27.70830, longitude:85.33338}]};
			
			
			
			//this variable array holds the all the route data retrived from the server. also added updated and deleted route will be updated here as well
			var routeCollection = [];	

			var routeMapStopsCollection = [];
			
			//this function get the route list when the page is first loaded.\\\
			function loadRouteData(){
				//$("#loading_1").show();			
				//$("#display_route_table").hide();
				//$(#"loading").show();
				
				
				//loading from server code here  example is route 1 route 2 and route 3 and route 4
				routeCollection.push(route1);
				routeCollection.push(route2);
				routeCollection.push(route3);
				routeCollection.push(route4);
				
				
				if (routeCollection.length==0){
					$("#display_route_message_alert").fadeIn();	
					$("#display_route_table").hide();	
					//cancelRouteDeleteOption();
				}
				else{
					//adding data to page table
					jQuery.each(routeCollection, function(i, route){
						var stopsName = [];
						jQuery.each(route.stops, function(j, stop){
							stopsName.push([stop.name]);
						});
						//stopsName.push(route.stops);
						loadRouteDataToTable(route.name, stopsName);
					});	
									
					//making the table font color to black since it is changed by to blue by loadRouteDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
					$("#display_route_table tbody").find("tr").css({"color":"#424242","font-weight":"normal"});				

					$("#display_route_message_alert").hide();									
					$("#display_route_table").fadeIn();
				}
				//	$("#loading_1").hide();	
				//},600);				
			}						
			loadRouteData();
			
			
			
		//#################SERVER CODE ROUTE SECTION ############################################
		
		function addRouteToServer(route_name, stop_lists){
			var routeObject = {name:route_name, stops:stop_lists};
			return true;
		}
		
		function updateRouteToServer(routeLists){
			//alert(routeLists);
			//the updated route list comes with original route name.
			//format {original:"Route 1", updated:"Route 12",stops:[{name:'baneswhoer Bus station', latitude:'32.232323', latitude:'43.4444'}]};
			//or check with this. alert(JSON.stringify(routeLists));
			return true;
		}
		
		
		
		
		function deleteRouteToServer(routeNames){
			//alert(routeNames);
			return true;
		}

		//#########################################################################
						
						
	
			
			
			function loadRouteDataToTable(name, stop_lists){
				var index = $("#display_route_table tbody").children().length;
				index = parseInt(index)+1;
				//adding to the table list.
				$("#display_route_table tbody").append('<tr style="color:#673AB7; font-weight:bold" tabindex="1"><td>'+index+'</td><td style="text-align:center">'+name+'</td><td><span style="float:left">'+stop_lists+'</span><span style="background-color:rgba(0,0,0,0.1); padding:1px; float:right; cursor:pointer" data-toggle="tooltip" data-placement="top" title="View Route In Map" onclick="displayRouteOnMap(this)"><span class="glyphicon glyphicon-globe"></span> MAP VIEW</span></td></tr>');
			}
			
	  
			
			
			//#############ROUTE MAP SECTION###############################################
			
				//creating group layer.
				var stopsLayerGroup = L.layerGroup();
			
			//This function displays the map on the route tab
			function displayRouteOnMap(row){
				//clearing the layers on map
				stopsLayerGroup.clearLayers();
				//setting the view
				//alert();
				var routeName = $(row).parent().parent().find("td:nth-child(2)").text();
				//var stopList = $(row).parent().parent().find("td:nth-child(3) span:nth-child(1)").text().split(",");
				
				//alert(routeName+stopList);
				//getting the route's stop's co-ordinates
				//alert(routeName);
				var stopsLngLat = getRouteStopsCoordinates(routeName);
				//alert(stopsLngLat);
				//alert(JSON.stringify(stopsLngLat));
				
				//adding to map.				
				map_route.addLayer(stopsLayerGroup);
				//alert(stopsLngLat.length);
				//adding stop to map
				for(var i=0;i<stopsLngLat.length;i++){
					var x = stopsLngLat[i];
					//alert(x.name);
					//var stop = L.circle([x.latitude, x.longitude], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel(x.name, { noHide: true }).addTo(stopsLayerGroup);
					//stopsLayerGroup.addLayer(stop);
					stopsLayerGroup.addLayer(L.marker([x.latitude,x.longitude], 
					{
						draggable:false,
						icon: L.AwesomeMarkers.icon(
							{
								icon: '',
								prefix: 'fa',
								markerColor: 'green',
								html:('<span><img src="stop1Image" height="24" width="24" style="margin-top:-2px"></span>')
							}
						)
					}).bindLabel(x.name, {noHide: true, offset:[18,-36],opacity:0.8})
					);
					
					
					/*div style="border-radius:6px; border:1px solid #CCC; height:24px; margin-left:6px;width:200px; background-color:rgba(0,0,0,0.5);min-width:100px; max-width:300px; display: inline-block"><span><img src="stop1Image" height="24" width="24" style="margin-top:-2px; float:left"></span><span style="float:left;">' +x.name+'</span></div>*/
					//console.log(getStackTrace().join('\n'));				
				}
				
				//L.Marker([27.71595, 85.28364], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Swayambhu Bus Station', { noHide: true }).addTo(map_route);
				//new L.circle([27.71595, 85.28364], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).addTo(map_route);
				
				//adding the map data 
				//checking and getting the route way data from ROUTE WAY TAB section routeWayCollection array.
				//in case if array is empty of corrupt due to system failure.
				/*if(routeWaysCollection.length==0){
					$("#alert_modal_title").text("WARNING!!! ERROR OCCURED.");
					$("#alert_modal_content").text(" Something went wrong. Cannot display the Route in Map at the moment. Please, try again later.");
					$("#alert_modal").modal('show');
				}
				else{*/
				//Loading the route way data.
				var wayData = getRouteWayData(routeWaysCollection, routeName);
				
				//if the way data is not available then display Route way Not Available message in the Map footer.
				if(wayData==null){					
					//$("#alert_modal_title").text("WARNING!!! ERROR OCCURED.");
					//$("#alert_modal_content").text(" Something went wrong. Cannot display the Route in Map at the moment. Please, try again later.");
					//$("#alert_modal").modal('show');
					//alert(wayData);
					$("#route_map_way_message").text("Not Available");
				}
				else{
					$("#route_map_way_message").text("Available");
					stopsLayerGroup.addLayer(L.polyline(wayData));			//adding the way data line in map.
					/*stopsLayerGroup.addLayer(L.polylineDecorator(L.polyline(wayData), {
						patterns: [
							{ offset: '5%', repeat: '10%',symbol: L.Symbol.arrowHead({pixelSize: 5, pathOptions: {color: '#0000FF', weight: 5, opacity: 0.5}})}
						]
					}).addTo(map_route));*/	
				}				
				//}	
				$("#route_map_container").slideDown().fadeIn();
				$("#route_map_container").focus();
				$("#route_map_container").blur();
				$("#route_map_loading").fadeIn();
				$("#route_map").hide();
				
				reInvalidateMapArea(); 
				setRouteTabMapView(false, true);
				
				setTimeout(function(){
				//alert();
					$("#route_map_loading").hide();
					$("#route_map_container").show();
					$("#route_map").fadeIn();
				},600);
			}
			
			
			
			//This function initialize map for route section.
			//initializing and creating map object for add bus stop 
				//var map_route = null;
				(function initializeRouteTabMap(){
					//if (map_route==null){
						map_route =new L.Map("route_map", {
							layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true, attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'})]	
						});	
						
						map_route.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.\
						
						/*var viewStopsNameButton = L.easyButton( 'glyphicon-map-marker', function(){				
							displayBusStopNames();
						});
						viewStopsNameButton.addTo(map_route);*/
					//}
				})();
				
				

				function reInvalidateMapArea(){
										//reinvalidating the map size to avoid error.
						setTimeout(function(){map_route.invalidateSize()},50);	  //must use timeout otherwise not work. since loadBustDetail has timeout 600. must match.
						setTimeout(function(){map_route.invalidateSize()},500);
						setTimeout(function(){map_route.invalidateSize()},1000);
						//revalidating again.. in case if page is displayed from add.when there no bus details are available to display. map is directly displayed when adding new bus stop. in this case we need to lately validate the map. otherwise not displayed properly.
						setTimeout(function(){map_route.invalidateSize()},2000);
				}
				
				
				
			//this function set and displays map default location. 
				function setRouteTabMapView(animate_option, reset_option){
					var default_position = [ 27.70549, 85.32028 ];
					map_route.setView([default_position[0],default_position[1]], 13, {animate: animate_option, reset: reset_option});
					//map_route.zoomIn(2, {animate: true});
					//map_route.on('click',function(e){alert(e.latlng)});
				};
				
		
				
				
		
			//this function retrieve bus stop long lat from bus stop collection of BUS STOP TAB section.
			//return a stop object with co-ordinates
			function getRouteStopsCoordinates(stop_name){
				searchStatus = false;
				for(var i=0; i<routeCollection.length; i++) {
				//alert("sdfsfdsf: "+routeCollection[i].name+" dsdsdfsfds: "+stop_name);
					if (routeCollection[i].name == stop_name){
						//var longitude = routes[i].longitude;
						//var latitude = routes[i].latitude;
						//alert("Dfdfd");
						var co_ordinates = [];
						for(var j=0; j<routeCollection[i].stops.length;j++){
							co_ordinates.push(routeCollection[i].stops[j]);	//adding the stop object
						}
						searchStatus = true;						
						//creating object
						//var stop = {name:stop_name, latitude:latitude, longitude:longitude};
						return co_ordinates;
					}
				}
				if(searchStatus == false){
					return null;
				}				
			}



			//this function close the route tab map 
			function closeRouteTabMap(){
				$("#route_map_container").slideUp().fadeOut();				
				//setRouteTabMapView(true, true);
				stopsLayerGroup.clearLayers();
			}
			
			
		
			
			
			
			
			//##########################ADD route###################################################






			
			//This function exits the add route form div.
			function exitAddRouteForm(){								
						//re-storing the saved form state
						//$("#add_route_section").replaceWith(originalStateOfAddRouteForm);
						//$("#content_header").slideUp().fadeOut();
						setTabHeader("CURRENT ROUTES", " List of currently available Routes.");		
						setTimeout(function (){$("#temp_route_heading").hide();	  //hide temp route heading	
						},300);						
						activateHeaderButton("refresh");
						$("#add_route_submit_message_alert").slideUp().fadeOut();
						$("#add_route_section").slideUp().fadeOut();
						enableAddEditDeleteButtons();
									
						resetAddRouteForm();	//reseting the textfields of form			
			}
			
			//this function add the selected stop name from the dropdown of add route form to the route list display table.
			//when user add a new route. then user need to select a bus stop list from the drop down as much as needed. this funciotn will trigger that method.
			function addStopsToAddRouteFormStopList(){				
					//alert("hello");
					var seq = 0;
					if($("#add_button_selected_stop_list").find("tbody").children().length==0){		
						seq = 1;
					}
					else{			
						// only work if the number column is not text input. .html cannot get input.textfield value. var i = $("#add_button_selected_stop_list tr:last").find("td").eq(0).html();		//find 0 index of last row value. i.e. serial no.
						var i = $("#add_button_selected_stop_list").find("tbody").children().length;
						seq = parseInt(i)+1;
					}
					var selected_stop = $('#add_button_stop_dropdown :selected').text();
					//if the user did not select the bus stop
					if(selected_stop=="SELECT BUS STOP"){
						//alert("Please, Select a Bus Stop from the List.");
						$("#alert_modal_title").text("BUS STOP NOT SELECTED");
						$("#alert_modal_content").text("Please, select a bus stop from the dropdown list.");						
						$("#alert_modal").modal('show');
					}
					else{
						var status = true;
						//checking if the selected bus stop is already selected or not if yes display error message
						if($("#add_button_selected_stop_list").find("tbody").children().length!=0){						
						var stops = [];
							//getting the second column data from the table and storing to the stops array
							$("#add_button_selected_stop_list tbody tr td:nth-child(2)").each(function(i,v){
								stops.push( $(this).text() ); 
							});
							//alert(stops+stops.length);
							for(var z=0;z<stops.length;z++){
								if (selected_stop==stops[z]){
									$("#alert_modal_title").text("BUS STOP ALREADY SELECTED");
									$("#alert_modal_content").text("The bus stop is already selected. Please, select a unique bus stop from the dropdown list.");
									$("#alert_modal").modal('show');
									status=false;
									break;
								}
								else{status=true}
							}						
						}
						//adding the stops detail to the list . i.e. add route bus stop lists.
						if(status){	
						$("#add_button_selected_stop_list tbody").append('<tr><td style="width:42px;margin:0px; padding:8px" class="index">'+parseInt(seq)+'</td><td>'+selected_stop+'</td><td style="width:12px"><button type="button" class="btn btn-xs" data-toggle="tooltip" data-placement="bottom" title="remove" onclick="removeBusStopFromRow(this)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td></tr>');
						}	
					}
			}

			
			//THis function display add route form
			function displayAddRouteForm(){	
					$("#add_route_submit_message_alert").slideUp().fadeOut();	
					activateHeaderButton("close");
					setTabHeader("ADD ROUTE", " Add a new Route details.");				
					$("#temp_route_heading").show();			//display another header for route table when table slides down
					//setHeaderButton("close");
					$("#content_header_button_close").click(function (){
						exitAddRouteForm();	
					});
					
					//$("#content_header").slideDown().show();
					$("#add_route_section").slideDown().show();
					disableAddEditDeleteButtons();
					
					enableDragAndDrop($("#add_button_selected_stop_list tbody"));	

					//adding bus stop data to add route list.
					jQuery.each(busStopCollection, function(i, stop){
						//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
						$('#add_button_stop_dropdown').append($('<option>', { 
							value: i,
							text : stop.name 
						}));
					});
			}
			
			
						
			//this function removes the the added bus stop list from the add route form. 
			function removeBusStopFromRow(row) {
				$(row).parent().parent().remove();
				revalidateIndexNumber($("#add_button_selected_stop_list tbody tr td:nth-child(1)"));
				revalidateIndexNumber($("#modal_update_route_selected_stop_list tbody tr td:nth-child(1)"));
			}
			
			//this function revalidate index number in the bus stop list after delete any item on list.
			function revalidateIndexNumber(td_index){
				$(td_index).each(function(i,v){
					$(this).hide().text(i+1); 
					$(this).fadeIn();
				});
			}
			
			
			
			//this function reset the add route form
			function resetAddRouteForm(){
				//$("#content_header_title").text("ADD ROUTE");				
				//$("#content_header_subtitle").text(" Add new Route Details.");
				$("#add_button_routeName").val("");
				var default_text = $("#select_stop_from_list").text();
				$("#add_button_stop_dropdown").val(default_text);
				$("#add_button_selected_stop_list tbody").empty();
				//$("#add_button_submit_button").text("ADD");  		//in case if the form is enabled by edit button reset it to default add name.
			}
			
			//this function hides the add route form but keeps the space. i.e. do not close it completely.
			//triggered by cancel button of add route form.
			function hideAddRouteFormOnly(){
				resetAddRouteForm();
				$("#add_route_section").slideUp().fadeOut();
				
							$("#add_route_submit_message_alert_title").text("CANCELLED.");
							$("#add_route_submit_message_alert_details").text("You have selected to cancel the new route detail submission.");
							$("#add_route_submit_message_alert").fadeIn();							
							$("#routes_tab").scrollTop($('#add_route_submit_message_alert').position().top-100);
			}
			
			
			
			//This function executes on clicking the add route button and submittin gdata.
			//loading icon display while loading map when view map button is clicked as well.			
			function submitRouteDetails(name, stop_lists){	
				//server code here
				
				//loading and updating the data to the page table
				loadRouteDataToTable(name, stop_lists);				
			}
			
			
			
			
					
			//This function checks the submit form are properly filled or not.
			
			
			//Extended submit. added some time delay while submitting, validation etc.
			function submitRouteExtended(){
				var route_name = capitalizeFirstLetter($("#add_button_routeName").val());
				var stop_lists = [];
				$("#add_button_selected_stop_list tbody tr").each(function(i, val){
					stop_lists[i] = $(val).find("td:nth-child(2)").text();
				});
				//alert(stop_lists);
				if (route_name==""){				
					$("#alert_modal_title").text("WARNING!!! EMPTY ROUTE NAME");
					$("#alert_modal_content").text("The Route name is invalid or empty. Please, enter route name and submit again.");
					$("#alert_modal").modal('show');						
						
					$("#alert_modal").on("hidden.bs.modal", function(){	
						$("#add_button_routeName").focus();
					});
				}
				else if(stop_lists.length==0){	
					$("#alert_modal_title").text("WARNING!!! EMPTY BUS STOPS LIST");
					$("#alert_modal_content").text("The bus stops list is empty. Please, add bus stops from dropdown and submit again.");
					$("#alert_modal").modal('show');						
							
					$("#alert_modal").on("hidden.bs.modal", function(){	
						$("#add_button_stop_dropdown").focus();
					});
				}
				else if(checkForDuplicateRouteEntry(route_name)==true){				
					//displaying server error message.
					$("#route_section_server_error_title").text("DUPLICATE ENTRY!!!");
					$("#route_section_server_error_details").text(" Duplicate entry found. The Route you are adding is already exist. Please, change try again later.");
					$("#route_section_server_error").slideDown().fadeIn();
					setTimeout(function(){								
						$("#route_section_server_error").slideUp().fadeOut();
					},4000);
				}
				else{
					$("#add_button_submit_button").prop("disabled", true);
					$("#add_button_cancel_button").prop("disabled", true);
					$("#route_add_loading_icon").css({visibility:"visible"});
					
				

					//submitting the data to the server.
					///#####################SERVER CODDE###############################
					
					var serverStatus = addRouteToServer(route_name, stop_lists);
					
					
					
					//################################################################
				
					
					
					//some time delay effect while submitting
					setTimeout(function(){	
	
						//if the add is successful.
						if(serverStatus==true){
							//submitRouteDetails(route_name, stop_lists);	
						
							//adding the new data to the local array
							var stopsWithLngLat = [];
							jQuery.each(stop_lists, function(i, stop){
								jQuery.each(busStopCollection, function(i, stopObject){
									if(stopObject.name == stop){
										stopsWithLngLat.push(stopObject);		//adding the object itself.
										return true;	//exitting out of the loop.
									}
								});
							});
							
							//now adding to local array.
							routeCollection.push({name:route_name, stops:stopsWithLngLat});
							//alert(JSON.stringify(routeCollection));
							
							//var eee = stopsWithLngLat;
							//var rrr = stopsWithLngLat;
							
							/*if(eee===rrr){
								alert("cjor");
							}
							else{
							alert("geda");
							}*/
							//loading and updating the data to the page table
							loadRouteDataToTable(route_name, stop_lists);	
							
							$("#route_add_loading_icon").css({visibility:"hidden"});					
							$("#add_button_submit_button").prop("disabled", false);
							$("#add_button_cancel_button").prop("disabled", false);
							
							resetAddRouteForm();
							$("#add_route_section").slideUp().fadeOut();
							
							//$("#loading").fadeOut(200);
							$("#add_route_submit_message_alert_title").text("Successful.");
							$("#add_route_submit_message_alert_details").text("You have successfully added new route details. Please, navigate to ROUTE WAY to add GPS co-ordinates.");
							$("#add_route_submit_message_alert").fadeIn();
							//location.href = "#add_route_submit_message_alert";
							//alert($('#add_route_submit_message_alert').offset().left );
							//$("#routes_tab").animate({ scrollTop: $('#add_route_submit_message_alert').offset().top }, 'slow');
							$("#routes_tab").scrollTop($('#add_route_submit_message_alert').position().top-100);
							//$('#add_route_submit_message_alert').focus();
							//$('#add_route_submit_message_alert').css({outline-color:"#595959"});
							//});	
						}
						else{
						//alert();						
							$("#route_add_loading_icon").css({visibility:"hidden"});					
							$("#add_button_submit_button").prop("disabled", false);
							$("#add_button_cancel_button").prop("disabled", false);
							//displaying server error message.
							$("#route_section_server_error_title").text("ERROR OCCURED!!!");
							$("#route_section_server_error_details").text(" Something went wrong. Cannot add the Route at the moment. Please, try again later.");
							$("#route_section_server_error").slideDown().fadeIn();
							setTimeout(function(){								
								$("#route_section_server_error").slideUp().fadeOut();
							},4000);
						}
					}					
					,2000);
				}
			}
		
			
			
			//this method check for duplicate data during adding or updating schedule details
			function checkForDuplicateRouteEntry(route_name){
				var isDuplicate = false;
				for(var i=0; i<routeCollection.length;i++){
					if(routeCollection[i].name.toLowerCase()==route_name.toLowerCase()){
						isDuplicate= true;
						return true;
					}				
				}
				return isDuplicate;
			}
			
			
			
			
			//###############################################################
			//DELETE Routes
			
			//delete routes
			//This function add the checkbox to the route table list.
			function addCheckBoxInTable(){
				$("#display_route_table thead tr").prepend('<th>MARK</th>');
				//var total_item = $("#display_route_table thead tr").find("tbody").children().length;
				//for(var i=0; i<total_item;i++){
					$("#display_route_table tbody tr").prepend('<td style="padding:0px; margin:0px"><span style="background:none;border:none" class="input-group-addon"><input type="checkbox" aria-label="..." onclick="unTickRouteDeleteSelectAllCheckBox()"></span></td>');				
				//}
			}
			

			//Action of select all checkbox on delete route details option. the function will return either the checkbox is checked or not.
			//triggered by select all checkbox.
				function selectRouteDeleteAllCheckBox(){
					if($("#route_delete_select_all_checkbox").is(":checked")){					
					//alert("checked");
					//checking all the input checkboxes in the list.
					$("#display_route_table tbody tr").find("input:checkbox").prop('checked', true);
					}
					else{
						//alert("not checked");					
						$("#display_route_table tbody tr").find("input:checkbox").prop('checked', false);
					}
				}
				
			//This function unselect the select all Checkbox. This is to make the main select all tick box unticked when any of all selected boxes are manually unchecked during deletion.
			function unTickRouteDeleteSelectAllCheckBox(){
				$("#route_delete_select_all_checkbox").prop('checked', false);
			}
			
			
			//this function removes the checkbox from the route delete option
			function removeCheckBoxInRouteTable(){
				$("#display_route_table thead tr th:first").remove();
				$("#display_route_table tbody tr td:nth-child(1)").each(function(){
					(this).remove();
				});
			}
			
			//this function display the delete interface. e.g. mark row, delete button etc.
			function displayDeleteRouteOption(){
				<!--if there is no route available then delete mode must is unavailable-->
				if($("#display_route_table").find("tbody").children().length==0){
					$("#display_route_table").css({
						display:"none"
					});
					
					$("#display_route_message_alert").hide();	
					$("#display_route_message_title").text("Delete un-available.");						
					$("#display_route_message_detail").text("Currently, no routes are available to delete.");	
					$("#display_route_message_alert").fadeIn();	
					
					setTimeout(function(){	
					$("#display_route_message_alert").slideUp().fadeOut();						
						$("#display_route_message_title").text("Routes un-available.");						
						$("#display_route_message_detail").text("There is nothing to display. Please, add a new route details. Your added details will be displayed here.");
					$("#display_route_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{	
					setTabHeader("DELETE ROUTES", " Please, check the rows that you want to delete.");
					//$("#temp_route_heading_title").text("DELETE ROUTE");
					//$("#temp_route_heading h3 small").text("Please, check the rows that you want to delete.");
					$("#display_route_table").hide();
					addCheckBoxInTable();
					$("#delete_route_apply_and_cancel_buttons").fadeIn();
					$("#display_route_route_delete_select_all_checkbox").slideDown().fadeIn();
					disableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", true);
					$("#display_route_table").fadeIn('slow');
				}
			}
			
			//this function get out of the delete option mode
			function cancelRouteDeleteOption(){	
				setTabHeader("CURRENT ROUTES", " List of currently available Routes.");	
				
					$("#display_route_table").hide();					
					$("#loading_1").fadeIn();
				//$("#temp_route_heading_title").text("CURRENT ROUTE");
				//$("#temp_route_heading h3 small").text("List of currently available routes.");
				removeCheckBoxInRouteTable();
				$("#delete_route_apply_and_cancel_buttons").hide();
				$("#display_route_route_delete_select_all_checkbox").hide();
				enableAddEditDeleteButtons();
				$("#content_header_button_refresh").prop("disabled", false);
				setTimeout(function(){					
					$("#display_route_table").fadeIn();					
					$("#loading_1").fadeOut();
				},400);
			}
			
			//this function delete route rows
			function deleteRouteRows(){	
				$("#display_route_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						$(row).find("td:nth-child(3)").parent().remove();
					}
				});
			}
			
			
			//this function get the route name to delete
			function getRouteNameToDelete(){
				var routes_to_delete = [];
				$("#display_route_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						//alert("checked");
						routes_to_delete.push($(row).find("td:nth-child(3)").text());
						//$(row).find("td:nth-child(3)").parent().remove();
						//count = count+1;
						//alert(routes_to_delete[i]);
					}
				});	
				//alert(routes_to_delete);
				//alert(routes_to_delete.length);
				
				return routes_to_delete;
			}
			
			
			function deleteRouteRowsExtended(){				
				$("#loading_1").fadeIn();
				
				//getting routes to delete
				var toDeleteRoutes = getRouteNameToDelete();
				
				//######################SERVER CODE ###############################
				
				var serverStatus = deleteRouteToServer(toDeleteRoutes);
				
				
				//##################################################################
				
				
				
				if(serverStatus==true){
					setTimeout(function(){
					
						//alert(JSON.stringify(routeCollection));
						//deleting the data from the local array.
						for(var i=0; i<toDeleteRoutes.length;i++){
							for(var j=0; i<routeCollection.length;j++){
								if(routeCollection[j].name==toDeleteRoutes[i]){
									routeCollection.splice(routeCollection.indexOf(routeCollection[j]),1);
									break;
								}
							}
						};						
						//alert(JSON.stringify(routeCollection));
						
						//deleting the row from the page.
						deleteRouteRows();		
						$("#loading_1").fadeOut();
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayRouteDetailAlertMessage()==false){										
						//displaying status message
							$("#route_delete_success_message").slideDown().fadeIn();
							$("#route_delete_success_message").focus();
							$("#route_delete_success_message").blur();
							setTimeout(function(){
								$("#route_delete_success_message").slideUp().fadeout();
							},5000);
						}

					},1000);				
				}
				else{				
					//displaying server error message.
					$("#route_section_server_error_title").text("ERROR OCCURED!!!");
					$("#route_section_server_error_details").text(" Something went wrong. Cannot add the Route at the moment. Please, try again later.");
					$("#route_section_server_error").slideDown().fadeIn();
					setTimeout(function(){								
						$("#route_section_server_error").slideUp().fadeOut();
					},4000);
				}
			}
			
			//this function displays modal to ask user to delete the selected rows and then delete.
			function displayRouteDeleteModal(){	
				var routes_to_delete = [];				
				var count = 0;
				$("#display_route_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						//routes_to_delete[i] = $(row).find("td:nth-child(3)").text();
						//$(row).find("td:nth-child(3)").parent().remove();						
						count = count+1;
					}
				});
				if (count==0){					
					$("#alert_modal_title").text("DELETE ROUTE");
					$("#alert_modal_content").text("Nothing is selected.");
					$("#alert_modal").modal('show');
				}
				else{
					$("#action_modal_title").text("DELETE ROUTE");
					$("#action_modal_content").text("Are you sure want to delete this route detail?");
					$("#action_modal").modal('show');
					
					$('#action_modal_delete').off();
					$('#action_modal_delete').click(function (e) {
					  // deleting the route rows.
					  deleteRouteRowsExtended();
					})
				}
			}
			
			//this message either display the empty route table message when there is no route rows to display or table.
			function displayRouteDetailAlertMessage(){
				if($("#display_route_table").find("tbody").children().length==0){
					$("#display_route_message_title").text("Routes un-available.");						
					$("#display_route_message_detail").text("There is nothing to display. Please, add a new route details. Your added details will be displayed here.");	
					$("#display_route_message_alert").fadeIn();	
					//cancel button unhide the table so hiding table below it.
					//cancelRouteDeleteOption();	
					setTabHeader("CURRENT ROUTES", " List of currently available Routes.");	
					//$("#temp_route_heading_title").text("CURRENT ROUTE");
					//$("#temp_route_heading h3 small").text("List of currently available routes.");
					removeCheckBoxInRouteTable();
					$("#delete_route_apply_and_cancel_buttons").hide();
					$("#display_route_route_delete_select_all_checkbox").hide();
					enableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", false);

				
					$("#display_route_table").hide();
					return true;
				}	
				else{
					$("#display_route_message_alert").css({
						display:"none"
					});	
					$("#display_route_table").fadeIn();
					return false;
				}
			}
			
			//#####################Edit Route Javascripts######################################
			

	  
			//This function adds edit button edit button in each row of the route details table. This function is triggered on onclick event of edit button.
			function displayEditRouteOption(){	
					var saveStatus = false; 		//status for either updates are saved or not
					var original_table = $("#display_route_table").clone();		//clonning original table
					
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_route_table").find("tbody").children().length==0){
					$("#display_route_table").css({
						display:"none"
					});					
					$("#display_route_message_alert").hide();	
					$("#display_route_message_title").text("Edit un-available.");						
					$("#display_route_message_detail").text("Currently, no routes are available to edit.");	
					$("#display_route_message_alert").slideDown().fadeIn();	
					setTimeout(function(){	

					$("#display_route_message_alert").slideUp().fadeOut();						
						$("#display_route_message_title").text("Routes un-available.");						
						$("#display_route_message_detail").text("There is nothing to display. Please, add a new route details. Your added details will be displayed here.");
					$("#display_route_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{		
					//hiding the view map button
					$("#display_route_table tbody").find("tr td:nth-child(3) span:nth-child(2)").hide();
					
					//$("#edit_option_exit_button").fadeIn();				
					$("#display_route_table").hide();
					activateHeaderButton("edit");
					
					//removing previous events bind to this buttons					
					$("#content_header_button_exit").off();
					$("#content_header_button_save").off();
					
					//hiding buttons to imitate fade in effect
					$("#content_header_button_exit").hide();
					$("#content_header_button_save").hide();
					//adding click listener to save button.
					$("#content_header_button_save").click(function(){
						saveUpdatedRoutesDetail();
						saveStatus = true;
					});
					$("#content_header_button_exit").click(function(){
						$("#loading_1").fadeIn();					
						$("#display_route_table").hide();
						
						//reverting to original table on exit if changes are not saved.
						if(saveStatus==false){
							$("#display_route_table").replaceWith(original_table);
						}
						cancelRouteEditOption();
						
						
						setTimeout(function(){					
							$("#display_route_table").fadeIn(100);
							$("#loading_1").hide();
						},600);
					});
					setTabHeader("EDIT ROUTES", " Please, click on edit button of any row to edit its details.");
					//$("#temp_route_heading_title").text("EDIT ROUTE");
					//$("#temp_route_heading h3 small").text("Please, click on edit button of any row to edit its details.");
					addEditButtonOnRouteDisplayTableRow();
					disableAddEditDeleteButtons();
					$("#loading_1").fadeIn();
					setTimeout(function(){	
					$("#content_header_button_exit").fadeIn();	
					$("#content_header_button_save").fadeIn();							
						$("#display_route_table").fadeIn(100);
						$("#loading_1").hide();
					},600);
				}
			}

			//add edit button on each row of route detail list table
			function addEditButtonOnRouteDisplayTableRow(){
				$("#display_route_table thead tr").append('<th style="text-align:center">ACTION</th>');
				$("#display_route_table tbody tr").append('<td style="padding:1px; margin:0px"><button type="button" class="btn btn-xs btn-block" style="background:none; border:1px solid #424242; float:right; margin:0px" onClick="openEditRouteModal(this)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> EDIT </button></td>');		
			}
			
			//remove edit button on each row of route detail list table
			function removeRouteDisplayRowEditButton(){
				$("#display_route_table thead tr th:nth-child(4)").remove();
				$("#display_route_table tbody tr td:nth-child(4)").each(function(){
					$(this).remove();
				});	
			}
			
			//this function revert back the text color to default black which has been changed in edit mode after update.
			function changeDefaultTextColorOfRouteRow(){
				$("#display_route_table tbody tr").each(function(){
					$(this).css({"font-weight":"normal", "color":"#000"});
				});
			}
			
			//this option exit out of edit mode of route details
			function cancelRouteEditOption(){		
				//emptying the updated value.
				updated_Routes = [];
				
				$("#loading_1").fadeIn();
				$("#display_route_table").hide();
				
				setTabHeader("CURRENT ROUTES", " List of currently available Routes.");
				
				removeRouteDisplayRowEditButton();
				changeDefaultTextColorOfRouteRow();	
				enableAddEditDeleteButtons();
				activateHeaderButton("refresh");
				
				setTimeout(function(){					
					$("#display_route_table").hide();				
					$("#loading_1").fadeOut();
				},400);
				
			}

			//this variable holds the currently opened/to edit its value route's route name as a reference, which will be used to update the changes in local array and server.
			var tempStoredRouteNameToUpdate = null;
			//This function get the data from row of displayed route list table and set it to the edit form. This funciton is triggered from the edit button.
			function openEditRouteModal(route){
			
			//resetAddRouteForm(); //reseting form in case if it is opened by any previous action or edit button.			
			//$("#add_route_section").slideDown().fadeOut();	//and hiding it so that when it re-enabled it will be focused on screen.
			
				//$("#content_header_title").text("UPDARE ROUTE");				
				//$("#content_header_subtitle").text(" Update existing Route Details.");
			//displayAddRouteForm();
				//$(route).modal({backdrop: 'static', keyboard: false});
				
				//getting the route name from the table row.
				var route_name = $(route).parent().parent().find("td:nth-child(2)").text();
				
				tempStoredRouteNameToUpdate = route_name; 		//storing to current temp variable.
				
				//alert(route_name);
				var stops = [];
				var stops_String = $(route).parent().parent().find("td:nth-child(3)").text();
				//alert(stops_String);
				/*stops = stops_String.split(',');
				var lastStop = stops[stops.length].replace("MAP VIEW", "");
				stops.splice(stops.length, 1, lastStop);
				alert(stops);*/
				jQuery.each(routeCollection, function(i, route){
					if(route.name==route_name){
						jQuery.each(route.stops, function(i, stop){
							stops.push(stop.name);
						});
						
						return true;
					}
				});
				
				//alert(stops);
					
					//adding bus stop list to add route list dropdown.
					jQuery.each(busStopCollection, function(i, stop){
						//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
						$('#modal_update_route_stop_dropdown').append($('<option>', { 
							value: i,
							text : stop.name 
						}));
					});
					
				//adding the data to the edit form.  
				$("#modal_update_route_routeName").val(route_name);
				//$("#add_button_submit_button").text("UPDATE");
				
				//clear the stop list first if there is any old list added by previous edit functions.
				$("#modal_update_route_selected_stop_list tbody").empty();
				
				jQuery.each(stops, function(i,val){		
					i+=1;
					$("#modal_update_route_selected_stop_list tbody").append('<tr><td style="width:42px; padding:8px" class="index">'+i+'</td><td>'+val+'</td><td style="width:12px"><button type="button" class="btn btn-xs" onclick="removeBusStopFromRow(this)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td></tr>');
								//$(this).find("tr td:nth-child(1)").val(i);
								//$(this).find("tr td:nth-child(2)").val(val);
							});
				//now data is imported in form. simply submit will update the data.
				
				//$("#add_route_section").slideDown();
				//this is causing tab to hide.
				//$(location).attr('href', '#add_route_section');  //this is jquery version of below
				//location.href = "#add_route_section";		//this will navigate inside the page itself. 
				$('#modal_update_route').modal('show');
				
				
				//adding click listener to the close button of modal
				$("#route_update_close_button").off(); //first removing previous event handler
				$("#route_update_close_button").click(function(){
					$(route).parent().parent().focus();
				});
				
				//adding click listener to the update button of modal
				$("#route_update_submit_button").off(); //first removing previous event handler
				$("#route_update_submit_button").click(function(){
					//updating the table row value when modal update button is clicked. and other update mechanism
					updateEditRouteTable($(route).parent().parent());  //passing a row as parameter
				});
				
				//initializing the drag and drop sort
				enableDragAndDrop($("#modal_update_route_selected_stop_list tbody"));						
			}
			
			//this function enable drag and drop in the bus stop list on edit modal box.
			//get table id as parameter
			function enableDragAndDrop(tableId){
				var fixHelperModified = function(e, tr) {
				var $originals = tr.children();
				var $helper = tr.clone();
				$helper.children().each(function(index) {
					$(this).width($originals.eq(index).width())
					$(this).parent().css({background:"#E0E0E0"});					
					$(this).parent().css({'cursor':"move"});
				});
				return $helper;
				},
				updateIndex = function(e, ui) {
					$('td.index', ui.item.parent()).each(function (i) {
						$(this).html(i + 1);
					});
				};				
				$(tableId).sortable({
					helper: fixHelperModified,
					stop: updateIndex
				}).disableSelection();
			}
			
			
			//This function add the stop name from edit route detail's stop dropdownlist to the bus stop list table while updating the existing route.
			function addFromDropDownToStopList(){
				//reseting the modal form first.
				//$("#modal_update_route_routeName").val("");
				//var default_text = $("#update_select_stop_from_list").text();
				//$("#modal_update_route_stop_dropdown").val(default_text);
				//$("#modal_update_route_selected_stop_list tbody").empty();
				//getting the bus stop name from dropdown and adding it to the table view of the form.
				//$("#modal_button_add_busstop_to_list").click(function(){
					//alert("hello");
					var seq = 0;
					if($("#modal_update_route_selected_stop_list").find("tbody").children().length==0){		
						seq = 1;
					}
					else{			
						// only work if the number column is not text input. .html cannot get input.textfield value. var i = $("#add_button_selected_stop_list tr:last").find("td").eq(0).html();		//find 0 index of last row value. i.e. serial no.
						var i = $("#modal_update_route_selected_stop_list").find("tbody").children().length;
						seq = parseInt(i)+1;
					}
					var selected_stop = $('#modal_update_route_stop_dropdown :selected').text();
					//if the user did not select the bus stop
					if(selected_stop=="SELECT BUS STOP"){
						//alert("Please, Select a Bus Stop from the List.");
						$("#route_update_warning_message small").text(" You did not select any Bus Stop from 'Select Stops' dropdown.");
						$("#route_update_warning_message").show();
						$("#route_update_warning_message").focus();
						$('#modal_update_route').scrollTop($('#modal_update_route').height());
						setTimeout(function(){	
							$("#route_update_warning_message").slideUp().fadeOut();
						}
						,5000);
					}
					else{
						var status = true;
						//checking if the selected bus stop is already selected or not if yes display error message
						if($("#modal_update_route_selected_stop_list").find("tbody").children().length!=0){						
						var stops = [];
							//getting the second column data from the table and storing to the stops array
							$("#modal_update_route_selected_stop_list tbody tr td:nth-child(2)").each(function(i,v){
								stops.push( $(this).text() ); 
							});
							//alert(stops+stops.length);
							for(var z=0;z<stops.length;z++){
								if (selected_stop==stops[z]){									
									$("#route_update_warning_message small").text(" The Bus Stop you are trying to add is already added on the list.");
									$("#route_update_warning_message").show();
									$("#route_update_warning_message").focus();
							//$("#routes_tab").scrollTop($('#add_route_submit_message_alert').position().top-100);
							//alert($('#add_route_submit_message_alert').height());alert($('#add_route_submit_message_alert').scrollTop());
							//$("#routes_tab").scrollTop($('#add_route_submit_message_alert').height());
							//$('#modal_update_route').scrollTop($('#modal_update_route').height());
							//animated version
							
							//$('#modal_update_route').resize();
							//$("#modal_update_route").animate({ scrollTop: $(window).height() }, 300);
							
							//alert($("#modal_update_route").outerHeight()));
							
									setTimeout(function(){	
										$("#route_update_warning_message").slideUp().fadeOut();
									}
									,5000);
									status=false;
									//break;
								}
								else{status=true}
							}						
						}
						//adding the stops detail to the list
						if(status){	
						$("#modal_update_route_selected_stop_list tbody").append('<tr tabindex="1"><td style="width:42px; padding:8px">'+parseInt(seq)+'</td><td>'+selected_stop+'</td><td style="width:12px"><button type="button" class="btn btn-xs" onclick="removeBusStopFromRow(this)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td></tr>');
						$("#modal_update_route_selected_stop_list tbody tr:last").focus();
						}	
					}	
			}
			
			//This function writes updated routes details to the edit mode table which will later saved after save button clicked.
			function updateEditRouteTable(route_row){
				var route_name = capitalizeFirstLetter($("#modal_update_route_routeName").val());				
				//validate route name:
				if (route_name==""){
					$("#route_update_warning_message small").text(" The Route name is invalid or empty. Please, check and submit again.");				
					$("#route_update_warning_message").show();	
					$("#route_update_warning_message").focus();
					setTimeout(function(){	
						$("#route_update_warning_message").slideUp().fadeOut();
					}
					,5000);
					$("#modal_update_route_routeName").focus();
				}
				else if(checkForDuplicateRouteEntry(route_name)==true){	
					$("#route_update_warning_message small").text(" Duplicate entry found. The Route you are adding is already exist. Please, change try again later.");				
					$("#route_update_warning_message").show();
					$("#route_update_warning_message").focus();
					setTimeout(function(){	
						$("#route_update_warning_message").slideUp().fadeOut();
					}
					,5000);
				}
				else{
					if($("#modal_update_route_selected_stop_list").find("tbody").children().length!=0){													
						var stops = [];	//array of bus stops
						//getting the second column data from the table and storing to the stops array
						$("#modal_update_route_selected_stop_list tbody tr td:nth-child(2)").each(function(i,v){
							//stops.push( $(this).text() ); 
							stops[i] = ( $(this).text() );  //this is also same.							
						});
						
						//alert(route_name);
						//alert(stops);
						//creating an object of route
						var route = {original:tempStoredRouteNameToUpdate, updated:route_name, stops:stops};
						
						tempStoredRouteNameToUpdate = null; 		//emptying the temp .
						
						//now adding the stops list to main array collection.
						//var index = updated_Routes.length;
						//updated_Routes[index] = route;
						updated_Routes.push(route);
						
						//everythins is okay.. now submit form
						//submit codes. to server
					
						$("#route_update_loading_icon").fadeIn();
						$("#route_update_submit_button").prop("disabled", true);						
					
						setTimeout(function(){							
							//changing the updated route text color to green and making font bold						
							$(route_row).css({
							"font-weight":"bold",
							"color":"#673AB7"
							});
							
							//now updating the stops list in the main table.
							$(route_row).find("td:nth-child(2)").text(route_name);
							$(route_row).find("td:nth-child(3)").text(stops);
							/*
							$("#route_update_success_message").fadeIn();
							//hiding the success message after 5 seconds.
							setTimeout(function(){						
								$("#route_update_success_message").slideUp().fadeOut();
							}
							,5000);*/
							
							$("#route_update_loading_icon").fadeOut();					
							$("#route_update_submit_button").prop("disabled", false);
							//alert(stops);
							$("#modal_update_route").modal('hide');
							$(route_row).focus();
						}
						,1000);
					}
					
					else{
						$("#route_update_warning_message small").text(" The Bus Stop list is empty. Please, add the Bus Stops and try again.");	
						$("#route_update_warning_message").show();
						
							
						setTimeout(function(){						
						$("#route_update_warning_message").slideUp().fadeOut();
						}
						,5000);						
					}
				}
			}
			
			//this variable is to store as collection of all route details individual array.
			var updated_Routes = [];
			
			//This function saves all the updated route details to the database
			function saveUpdatedRoutesDetail(){
				if(updated_Routes.length==0){					
					$("#route_save_already_saved_error_message").slideDown().fadeIn();
					setTimeout(function(){
						$("#route_save_already_saved_error_message").slideUp().fadeOut();
					},5000);
				}
				else{
					//disabling the save or exit button during saving data
					$("#content_header_button_save").prop("disabled",true);
					$("#content_header_button_exit").prop("disabled",true);
					//enabling the loading animation				
					$("#content_header_loading_icon").fadeIn();
					setTimeout(function(){					
						//jQuery.each(updated_Routes, function(i, val){						
							//alert(i+" , "+val.name+" , "+val.stops);
						//####################################################################################

							//NOW UPDATING / SERVER CODES
							
						var	serverStatus = updateRouteToServer(updated_Routes);
							
							
							
						//####################################################################################	

						if(serverStatus==true){
							//updating the local array as well.
							//alert(JSON.stringify(routeCollection));
							jQuery.each(updated_Routes, function(i,updatedRoute){
								jQuery.each(routeCollection, function(i,oldRoute){
									if(oldRoute.name==updatedRoute.original){			//FORMAT {original:tempStoredRouteNameToUpdate, updated:route_name, stops:stops};
										oldRoute.name=updatedRoute.updated;
										oldRoute.stops=updatedRoute.stops;
										//oldRoute.time=updatedRoute.time;
										return true;
									}
								});
							});
							
							//alert(JSON.stringify(routeCollection));
							//delete updated routes array collection
							updated_Routes = [];
							
							$("#route_save_success_message").slideDown().fadeIn();
							$("#route_save_success_message").focus();
							$("#route_save_success_message").blur();
							setTimeout(function(){
								$("#route_save_success_message").slideUp().fadeOut();
							},5000);
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfRouteRow();
							
						}
						else{
						$("#route_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#route_save_danger_message").slideUp().fadeOut();
							},5000);
						}							
						//re-enabling the save or exit button during saving data
						$("#content_header_button_save").prop("disabled",false);
						$("#content_header_button_exit").prop("disabled",false);
						//disabling the loading animation				
						$("#content_header_loading_icon").fadeOut();
						
					},2000);
				}
			}
			
			
			

			//<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
							//BUS STOP TAB CODES START HERE
				




			//example data.
			var busStop1 ={name:"Swayambhu Bus Station", latitude:27.71595, longitude:85.28364};
			var busStop2 ={name:"Sitapaila Bus Station", latitude:27.70743, longitude:85.28263};
			var busStop3 ={name:"Kalanki Bus Station", latitude:27.69337, longitude:85.28174};
			var busStop4 ={name:"SoaltiMood Bus Station", latitude:27.69664, longitude:85.29356};
			var busStop5 ={name:"Kalimati Bus Station", latitude:27.69835, longitude:85.29960};
			var busStop6 ={name:"Teku Bus Station", latitude:27.69667, longitude:85.30570};
			var busStop7 ={name:"Tripureshwor1 Bus Station", latitude:27.69462, longitude:85.31135};
			var busStop8 ={name:"Tripureshwor2 Bus Station", latitude:27.69397, longitude:85.31336};
			var busStop9 ={name:"RNAC Bus Station", latitude:27.70157, longitude:85.31357};
			var busStop10={name:"Jamal Bus Station", latitude:27.70926, longitude:85.31666};
			var busStop11={name:"DurbarMarg Bus Station", latitude:27.71332, longitude:85.31819};
			var busStop12={name:"Hattisar Bus Station", latitude:27.71099, longitude:85.32210};
			var busStop13={name:"Kamalpokhari Bus Station", latitude:27.71010, longitude:85.32514};
			var busStop14={name:"Gyaneshwor Bus Station", latitude:27.70866, longitude:85.33199};
			var busStop15={name:"Maitidevi Bus Station", latitude:27.70830, longitude:85.33338};
			var busStop16={name:"Ratopul Bus Station", latitude:27.70811, longitude:85.33626};
			var busStop17={name:"Gaushala Bus Station", latitude:27.70780, longitude:85.34334};
			var busStop18={name:"Tilganga Bus Station", latitude:27.70613, longitude:85.34959};
			var busStop19={name:"Airport Bus Station", latitude:27.70019, longitude:85.35411};
			
			
			//this variable holds all the bus stop retrieved from the server. In addition, it act as main data to local data manipulation e.g. edit update etc.
			var busStopCollection = [];
			
			//this function get the route list when the page is first loaded.\\\
			//var loaded_status = false;
			function loadBusStopData(){
				//only loading if the data is not loaded already. i.e. only loading for first time. if user page through tab, then every time data will not retrive from server but only for first time.
				//if(loaded_status==false){
					//$("#loading_1").show();			
					//$(#"loading").show();
					
					
					//###########################################load data from the server#######################################################
					
					
					
					busStopCollection.push(busStop1, busStop2, busStop3, busStop4, busStop5, busStop6, busStop7, busStop8, busStop9, busStop10, busStop11, busStop12, busStop13, busStop14, busStop15, busStop16, busStop17, busStop18, busStop19);
					
					
					
					//###########################################################################################################################
					
					//now setting to table.
					jQuery.each(busStopCollection, function(i,stop){						
						addBusStopToTableList(stop.name, stop.longitude, stop.latitude);
					});
					
					//making the table font color to black since it is changed by to blue by loadRouteDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
					$("#display_bus_stop_table tbody").find("tr").css({"color":"#424242"});
					
					//setTimeout(function(){
						//get bus stop codes and set to table						
						//if($("#display_bus_stop_table").find("tbody").children().length==0){
						if(busStopCollection.length==0){
						$("#display_bus_stop_table").hide();
						$("#bus_stop_display_status_message_title").text("BUS STOPS NOT AVAILABLE. ");
						$("#bus_stop_display_status_message_details").text("Currently, there are no any bus stops details are available to display here. You can add new Bus Stop and added Bus stops will be displayed here.");
						$("#bus_stop_display_status_message").fadeIn();	
						}	
						else{
							$("#bus_stop_display_status_message").slideUp().fadeOut().css({display:"none"});						
							$("#bus_stop_tab_main_container").fadeIn();
						}
						//$("#loading_1").hide();	
						//loaded_status = true;
					//},600);					
				//}				
			}			
			loadBusStopData();
			
			
									
		//#################SERVER CODE BUS STOP SECTION ############################################
		
		function addBusStopToServer(busStop){
			//you can alert to know the format. JSON.stringify
			return true;
		}
		
		function updateBusStopToServer(busStopLists){
			//alert(routeLists);
			//the updated route list comes with original route name.
			//format {original:"Route 1", updated:"Route 12",stops:[{name:'baneswhoer Bus station', latitude:'32.232323', latitude:'43.4444'}]};
			//or check with this. alert(JSON.stringify(routeLists));
			return true;
		}
		
		
		
		
		function deleteBusStopToServer(stopNames){
			//alert(routeNames);
			return true;
		}
		//#########################################################################################
			
			
			
			
			//###################MAP SECTION ###############################################################
			
			
			
			
				var marker1; //marker to display location when user click row from bus stop list table.
				var marker2; //market to display and pin location during add bus stop when user pan and select bus stop location manually.
				
				//initializing and creating map object for add bus stop 
				var map =new L.Map("bus_stop_map", {
					layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true, attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'})]	
				});	
				map.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.

				
				//this variable helps to find whether map is in add bus stop or not so that onclick to pin location only work with add bus stop mode.
				var map_add_bus_stop_status = false;		

				//Codes will execute only when bus stop tab is opened.
				$("body").on("shown.bs.tab", "#bus_stop_tab_header", function() {
					/*to avoid error Leaflet map not displayed properly inside tabbed panel using invalidateSize.
					answer: http://stackoverflow.com/questions/10762984/leaflet-map-not-displayed-properly-inside-tabbed-panel*/
										
					//loadBusStopData();
					setTimeout(function(){map.invalidateSize()},500);
					setTimeout(function(){map.invalidateSize()},800);
					setTimeout(function(){map.invalidateSize()},1000);
					setTimeout(function(){map.invalidateSize()},1400);
					setTimeout(function(){map.invalidateSize()},1800);	  //must use timeout otherwise not work. since loadBustDetail has timeout 600. must match.
					//revalidating again.. in case if page is displayed from add.when there no bus details are available to display. map is directly displayed when adding new bus stop. in this case we need to lately validate the map. otherwise not displayed properly.
					setTimeout(function(){map.invalidateSize()},2000);
					
					//tab loading animation
					firstTimeTabLoadinAnimation();
				});
				
				//this function set and displays map default location. 
				function setMapView(){
					var default_position = [ 27.707011230127296,85.31444102525711];
					map.setView([default_position[0],default_position[1]], 17, {animate: true, reset: true});
				};
				
				setMapView();		
				
				//this function displays the selected row/bus stop position in the map
				(function displayBusStopPositionInMap(){
					$("#display_bus_stop_table tbody").children().on("click",function(){
						if(map_add_bus_stop_status==false){
							var name = $(this).find("td:nth-child(2)").text();
							var lngLatStr = $(this).find("td:nth-child(3)").text();
							var lngLat = lngLatStr.split(",");
							var lng = lngLat[0];
							var lat = lngLat[1];
							
							//adding name and lng lat to footer.
							setBusStopNameAndLatLng(name, lng, lat);
							
							//alert(lngLat);
							//previous marker will be removed so that user can pin marker anywhere they click
							removeMarker(marker1);
							
							marker1 = new L.marker([ lat, lng ], {draggable:false});
							map.addLayer(marker1);	
							map.setView([ lat, lng ], 17, {animate: true, reset: false});
						}
					});
				})();	
		
				//this function set bus stop name and location lat/lng on footer when user click and view its location on map on display mode.
				function setBusStopNameAndLatLng(name, lat, lng){
					$("#bus_stop_name").text(name);
					$("#bus_stop_longitude").text(lng);
					$("#bus_stop_latitude").text(lat);					
				}
				
				//this function gets the longitude and latitude of clicked location on map and set to map footer tab
				(function setLongLatAndMarkerOnClick(){
					//when the user single click on map the marker will displayed.
					map.on('click', function(e) {	
						if(map_add_bus_stop_status){
							//longitude and latitude variable 
							var lng = e.latlng.lng.toFixed(6);		//tofixed() to round to 6 decimal.
							var lat = e.latlng.lat.toFixed(6);				
							
							//adding long/lat value to footer.
							setLatLngOnFooter(lat, lng);
							//$("#add_bus_stop_map_longitude").text(lng);
							//$("#add_bus_stop_map_latitude").text(lat);
							
							//previous marker will be removed so that user can pin marker anywhere they click and previous pinned marker will not display.
							removeMarker(marker2);
							
							marker2 = new L.marker(e.latlng, {draggable:true});
							map.addLayer(marker2);
							map.setView(e.latlng, 18, {animate: true, reset: false});
							
							//getting the location even after dragging the marker. i.e getting the location on drag event.
							marker2.on("dragend", function(e){
								var latlng = e.target.getLatLng();		//using target for drag event.
								lng = latlng.lng.toFixed(6);
								lat = latlng.lat.toFixed(6);
								
								//adding the long/lat value on footer.
								setLatLngOnFooter(lat, lng);
								//$("#add_bus_stop_map_longitude").text(lng);
								//$("#add_bus_stop_map_latitude").text(lat);
							});
							//setting the color or add button
							$("#bus_stop_map_footer_pin_location_button").css({color:"#FFF",border:"2px solid #CCC"});
							//adding the long lat on "add bus stop form" inputfield.
							$("#bus_stop_map_footer_pin_location_button").click(function(){
								$("#add_bus_stop_longitude").val(lng);
								$("#add_bus_stop_latitude").val(lat);
							});
						}
					});
				})();
			
				//this function set location lat/lng on footer when user click on map during add bus stop mode.
				function setLatLngOnFooter(lat, lng){
					$("#add_bus_stop_map_longitude").text(lng);
					$("#add_bus_stop_map_latitude").text(lat);						
				}
				
				//This function removes the added marker from the map.
				function removeMarker(marker){					
					if(marker!=null){					
						map.removeLayer(marker);
					}
				}
	
				//Set the map to the default state 
				function setDefaultMapState(){
					removeMarker(marker1);
					removeMarker(marker2);
					setMapView();
				};
			
			
					
					
			//##############ADD BUS STOP SECTION ###########################################################################

			
			
				//This function displays the add bus stop form
				function displayAddBusStopForm(){
					//checking if the bus stop tab container is hidden or not if hidden then unhiding it.
					disableAddEditDeleteButtons();
					
					//enabling the bus stop cntainer if status message is previously displayed.
					if($("#display_bus_stop_table").find("tbody").children().length==0){   //i;e. no row available.						
						$("#bus_stop_display_status_message").slideUp();	
						$("#bus_stop_tab_main_container").delay(100).fadeIn(500);
						$("#display_bus_stop_table").hide();
						$("#display_bus_stop_table_not_available").fadeIn();
					}
					
					$("#add_bus_stop_submit_message_alert").slideUp().fadeOut();
					$("#content_header_button_refresh").attr("disabled", true); 					
					$("#temp_bus_stop_table_header").fadeIn();
					$("#bus_stop_display_co_ordinates_on_map_footer").slideUp().fadeOut();
					$("#bus_stop_add_co_ordinates_on_map_footer").slideUp().fadeIn();
					
					setTabHeader("ADD BUS STOP", " Add a new bus stop details. You can add the stop location using map below.");
					//setting map interaction on during adding bus.
					map_add_bus_stop_status = true;
					setDefaultMapState();
			
					//loading the form.
					$("#add_bus_stop_section").slideDown();
					//adding the click event to the add button in add new bus stop form.
					$("#add_bus_stop_add").off();
					$("#add_bus_stop_add").on("click",function(){
						addBusStopDetails();
					});	
					
					//adding the click event to the add button in add new bus stop form.
					$("#add_bus_stop_close").off();
					$("#add_bus_stop_close").on("click",function(){
						closeAddBusStopForm();
					});					
				}
				
				
				
				//This function close the add bus stop form
				function closeAddBusStopForm(){	
					//reseting the form
					resetAddBusStopForm();
					//removing the alert message if present.
					$("#add_bus_stop_submit_message_alert").slideUp().fadeOut();
					//checking if user cancel without adding bus stop in case no-bus stop are available to display. in this case the status must be displayed and bus stop tabl container must be hidden.
					if($("#display_bus_stop_table").find("tbody").children().length==0){   //i;e. no row added.						
						$("#bus_stop_display_status_message").fadeIn();	
						$("#bus_stop_tab_main_container").slideUp().fadeOut().css({display:"none"});
						//$("#display_bus_stop_table").css({display:"none"});						
						$("#display_bus_stop_table_not_available").fadeOut();
					}
					enableAddEditDeleteButtons();
					$("#content_header_button_refresh").attr("disabled", false);  				
					$("#temp_bus_stop_table_header").fadeOut(); 
					$("#add_bus_stop_section").slideUp();
					$("#display_bus_stop_table").fadeIn();
					$("#bus_stop_add_co_ordinates_on_map_footer").slideDown().fadeOut();
					$("#bus_stop_display_co_ordinates_on_map_footer").slideDown().fadeIn();
					setTabHeader("CURRENT BUS STOPS", " List of currently available Bus Stops.");
					//setting map interaction off during adding bus.
					map_add_bus_stop_status = false;	
					setDefaultMapState();
					setBusStopNameAndLatLng("Not Selected", "Not Available","Not Available");
					setLatLngOnFooter("Not Available","Not Available");						
					$("#bus_stop_map_footer_pin_location_button").css({color:"#CCC", border:"1px solid #CCC"});
				}	
				
				//This function reset the add bus stop form
				function resetAddBusStopForm(){					
					$("#add_bus_stop_enter_name").val("");
					$("#add_bus_stop_longitude").val("");
					$("#add_bus_stop_latitude").val("");
				}
	
				//This function add the bus stop details to the server.
				function addBusStopDetails(){
					var name = capitalizeFirstLetter($("#add_bus_stop_enter_name").val());
					var lng = $("#add_bus_stop_longitude").val();
					var lat = $("#add_bus_stop_latitude").val();
					//checking for input is empty or not.
					if(name==""){
						$("#alert_modal_title").text("WARNING!!! EMPTY INPUT");
						$("#alert_modal_content").text("Error Occured. Bus Stop name is not Entered. Please, enter an appropriate Bus Stop name and then try again.");						
						$("#alert_modal").modal('show');
						$("#alert_modal").on("hidden.bs.modal", function(){							
							$("#add_bus_stop_enter_name").focus();
						});
					}
					else if(lng==""){						
						$("#alert_modal_title").text("WARNING!!! EMPTY INPUT");
						$("#alert_modal_content").text("Error Occured. Longitude is not Entered. Please, enter an appropriate longitude value and then try again.");						
						$("#alert_modal").modal('show');
						$("#alert_modal").on("hidden.bs.modal", function(){	
							$("#add_bus_stop_longitude").focus();
						});
					}
					else if(lat==""){						
						$("#alert_modal_title").text("WARNING!!! EMPTY INPUT");
						$("#alert_modal_content").text("Error Occured. Latitude is not Entered. Please, enter an appropriate latitude value and then try again.");						
						$("#alert_modal").modal('show');
						$("#alert_modal").on("hidden.bs.modal", function(){	
							$("#add_bus_stop_latitude").focus();
						});
					}					
					//checking if long and lat are number or not.
					else if(isNaN(lng) || isNaN(lat)){							
						$("#alert_modal_title").text("WARNING!!! WRONG INPUT TYPE");
						$("#alert_modal_content").text("Error Occured. Please, enter an appropriate latitude/longitude value and then try again.");		
						$("#alert_modal").modal('show');
						if(isNaN(lat)){							
							$("#alert_modal").on("hidden.bs.modal", function(){	
								$("#add_bus_stop_latitude").focus();
							});
						}
						else{
							$("#alert_modal").on("hidden.bs.modal", function(){	
								$("#add_bus_stop_longitude").focus();
							});						
						}
					}
					//checking for duplicate entry
					else if(checkForDuplicateBusStopEntry(name)==true){					
						$("#alert_modal_title").text("WARNING!!! DUPLICATE ENTRY");
						$("#alert_modal_content").text(" The Bus Stop that you are trying to add is already exist. Please, check and try again.");						
						$("#alert_modal").modal('show');
						$("#alert_modal").on("hidden.bs.modal", function(){	
							$("#add_bus_stop_latitude").focus();
						});						
					}
					//all are correct
					else{
						//now submitting the values.
						$("#add_bus_stop_loading_icon").fadeIn();
						
						var busStop = {name:name, latitude:lat, longitude:lng};
						setTimeout(function(){
						
							//##################SEnding to server ##############################################################################
							
							
							
							var serverStatus = addBusStopToServer(busStop);
														
														
														
							//#################################################################################################################
							
							if(serverStatus == true){
								//alert(JSON.stringify(busStopCollection));
								//adding the data to local array.
								busStopCollection.push(busStop);
								//alert(JSON.stringify(busStopCollection));
								
								//adding data to page table
								addBusStopToTableList(busStop.name, busStop.longitude, busStop.latitude);
																
								//alert("submitted"+name+lat+lng);
								$("#add_bus_stop_loading_icon").fadeOut();									
								$("#add_bus_stop_section").slideUp();							
								//resetting the form
								resetAddBusStopForm();
								$("#add_bus_stop_submit_message_alert_title").text("Successful. ");
								$("#add_bus_stop_submit_message_alert_details").text("The Bus Stop details has been successfully added.");
								$("#add_bus_stop_submit_message_alert").slideDown().fadeIn();								
							}
							else{							
								$("#bus_stop_server_danger_message_title").text("ERROR OCCURED!!!");
								$("#bus_stop_server_danger_message_detail").text(" Something went wrong while adding the Bus Stop detail. Please, try again later.");
								$("#bus_stop_server_danger_message").slideDown().fadeIn();
								setTimeout(function(){
									$("#bus_stop_server_danger_message").slideUp().fadeOut();
									$("#add_bus_stop_loading_icon").fadeOut();	
								},4000);
							}
						},3000);
					}					
				}
				
				
				//This method checks on duplicate entry during bus stop add.
				function checkForDuplicateBusStopEntry(name){
					var isDuplicate = false;
					for(var i=0; i<busStopCollection.length;i++){	
						//alert(scheduleCollection[i].route+route + scheduleCollection[i].vehicle+vehicle +Number(time[0])+Number(hour) + Number(time[1])+Number(min));
						if(busStopCollection[i].name.toLowerCase()==name.toLowerCase()){
							//alert();
							isDuplicate= true;
							return true;
						}				
					}
					return isDuplicate;				
				}
				
		
				//this function adds the bus stop row to the display table..
				function addBusStopToTableList(name, lng, lat){
					var index = $("#display_bus_stop_table tbody").children().length;
					//alert(index);
					
					index = parseInt(index)+1;
					$("#display_bus_stop_table tbody").append('<tr tabindex="1" style="height:32px;color:#673AB7" data-toggle="tooltip" data-placement="bottom" title="Click to view location on Map"><td>'+index+'</td><td style="padding-left:24px;">'+name+'</td><td style="text-align:center">'+lng+', '+lat+'</td></tr>');
				}

			
			

			
			//#######################################################################################################################
			//UPDATE BUS STOP Details
			
			
			
			
			
			//this function checks and then display edit option for bus stop tab.
				function displayEditBusStopOption(){
					var saveStatus = false; 		//status for either updates are saved or not
					var original_table = $("#display_bus_stop_table").clone();		//clonning original table  since changes are already made in table as highligheed color before update if user choose to cancel or server error occured. the original table need to be replaced.
					var updated_table;		//clonning updated table. note it is only to enable tooltip.
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_bus_stop_table").find("tbody").children().length==0){					
						$("#display_bus_stop_table").hide();						
						$("#bus_stop_display_status_message").hide();
						$("#bus_stop_display_status_message_title").text("EDIT NOT AVAILABLE. ");
						$("#bus_stop_display_status_message_details").text("Currently, there are no any bus stops details are available to edit. You can add new Bus Stop and added Bus stops will be displayed here to edit and update.");
						$("#bus_stop_display_status_message").slideDown().fadeIn();	
						
					setTimeout(function(){	

					$("#bus_stop_display_status_message").slideUp().fadeOut();
						$("#bus_stop_display_status_message_title").text("BUS STOPS NOT AVAILABLE. ");
						$("#bus_stop_display_status_message_details").text("Currently, there are no any bus stops details are available to display here. You can add new Bus Stop and added Bus stops will be displayed here.");
						$("#bus_stop_display_status_message").slideDown().fadeIn();
					},3000);
				}
				else{
					//making map unclickable the map
					$("#bus_stop_map_container").css({'pointer-events':'none','filter':'alpha(opacity=60)', 'opacity':'0.6'});
					//$("#edit_option_exit_button").fadeIn();				
					$("#bus_stop_tab_main_container").hide();
					activateHeaderButton("edit");
					
					//removing previous events bind to this buttons					
					$("#content_header_button_exit").off();
					$("#content_header_button_save").off();
					
					//hiding buttons to imitate fade in effect
					$("#content_header_button_exit").hide();
					$("#content_header_button_save").hide();
					
					//adding click listener to save button.
					$("#content_header_button_save").click(function(){
						saveUpdatedBusStopDetail();
						saveStatus = true;		//setting save status to true.
						updated_table = $("#display_bus_stop_table").clone();		//backing up even after update and saving in order to enable tooltip
					});
					$("#content_header_button_exit").click(function(){
					
						
					//making map clickable the map
					$("#bus_stop_map_container").css({'pointer-events':'auto','filter':'alpha(opacity=100)', 'opacity':'1'});
					
						//hiding the status messages--
						$("#bus_stop_save_success_message").hide();
						$("#bus_stop_save_danger_message").hide();
						$("#bus_stop_save_already_saved_error_message").hide();
						
						$("#loading_1").fadeIn();					
						$("#bus_stop_tab_main_container").hide();
							
						//revert to original only if the changes are not saved. avoid not displaying updated row.
						if(saveStatus==false){
							//changing table to original state
							$("#display_bus_stop_table").replaceWith(original_table);
						}
						else{
							$("#display_bus_stop_table").replaceWith(updated_table);  
						}
						
						disableTooltip(false);
						changeCursor("pointer");
						disableRowClick(false);
						
						cancelBusStopEditOption();
												
						setTimeout(function(){					
							$("#bus_stop_tab_main_container").fadeIn(100);
							$("#loading_1").hide();
						},600);
					});
					setTabHeader("EDIT BUS STOP", " Please, click on edit button of any row to edit its details.");
					//$("#temp_route_heading_title").text("EDIT ROUTE");
					//$("#temp_route_heading h3 small").text("Please, click on edit button of any row to edit its details.");
					addEditButtonOnBusStopDisplayTableRow();
					disableTooltip(true);
					disableRowClick(true);
					changeCursor("auto");		//changing cursor to default browser type
					disableAddEditDeleteButtons();
					$("#loading_1").fadeIn();
					setTimeout(function(){	
					$("#content_header_button_exit").fadeIn();	
					$("#content_header_button_save").fadeIn();							
						$("#bus_stop_tab_main_container").fadeIn(100);
						$("#loading_1").hide();
					},600);
				}
			}
			
			//this function add edit button on each row
			function addEditButtonOnBusStopDisplayTableRow(){
				$("#display_bus_stop_table thead tr").append('<th width="15%"style="text-align:center">ACTION</th>');
				$("#display_bus_stop_table tbody tr").append('<td style="padding:2px; margin:0px"><button type="button" class="btn btn-xs btn-block" style="background:none; border:1px solid #424242; float:right; margin:0px; height:28px" onClick="openEditBusStopModal(this)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> EDIT </button></td>');				
			}
			
			//This function disable or enable tooltip in each row of bus stop row.
			function disableTooltip(condition){
				//if disable command is true
				if (condition){
					$("#display_bus_stop_table tbody tr").each(function(i, val){
						$(val).prop('title','Click to view location on Map').tooltip('fixTitle');
					});
				}
				else{
					$("#display_bus_stop_table tbody tr").each(function(i, val){
						//http://stackoverflow.com/questions/9501921/change-twitter-bootstrap-tooltip-content-on-click
						
						$(val).prop('title','Click to view location on Map').tooltip();
					});				
				}
			}
			//this function change row cursor of bus stop table
			function changeCursor(type){
				$("#display_bus_stop_table tbody").css({cursor:type});
			}
			
			//this function disable row click during edit bus stop.
			//if true then it will avoid click on the bus stop table row and if false then it will add functionality that if we clicked on row it will display its location on map.
			function disableRowClick(condition){
				//if condition is true
				if(condition==true){
					$("#display_bus_stop_table tbody tr").off();
				}
				else{
					//executing the display bus stop in map function to regain click function
					//displayBusStopPositionInMap();
					$("#display_bus_stop_table tbody").children().on("click",function(){
						if(map_add_bus_stop_status==false){
							var name = $(this).find("td:nth-child(2)").text();
							var lngLatStr = $(this).find("td:nth-child(3)").text();
							var lngLat = lngLatStr.split(",");
							var lng = lngLat[0];
							var lat = lngLat[1];
							
							//adding name and lng lat to footer.
							setBusStopNameAndLatLng(name, lng, lat);
							
							//alert(lngLat);
							//previous marker will be removed so that user can pin marker anywhere they click
							removeMarker(marker1);
							
							marker1 = new L.marker([ lat, lng ], {draggable:false});
							map.addLayer(marker1);	
							map.setView([ lat, lng ], 18, {animate: true, reset: false});
						}
					});
				}
			}
			
			//this function cancel the bus stop edit option
			function cancelBusStopEditOption(){	
				//emptying the updated value
				updated_BusStops = [];
				
				setTabHeader("CURRENT BUS STOPS", " List of currently available Bus Stops.");	
				removeBusStopRowEditButton();
				changeDefaultTextColorOfBusStopRow();	
				enableAddEditDeleteButtons();
				activateHeaderButton("refresh");
			}
			
			//this function revert back the text color to default black which has been changed in edit mode after update.
			function changeDefaultTextColorOfBusStopRow(){
				$("#display_bus_stop_table tbody tr").each(function(){
					$(this).css({"font-weight":"normal", "color":"#000"});
				});
			}
			
			//this function removes edit button from each row of bus stop row.
			function removeBusStopRowEditButton(){			
				$("#display_bus_stop_table thead tr th:nth-child(4)").remove();
				$("#display_bus_stop_table tbody tr td:nth-child(4)").each(function(){
					$(this).remove();
				});	
			}
			
			
			//this variable holds the name of the row/table/bus stop and holds temporarily so that it can be used ad reference to updated bus stop when adding to temp array. updatedBusStops[];
			var originalBusStopNameBeforeUpdate = null;
			//This function get the data from row of displayed bus stop list table and set it to the edit form. This funciton is triggered from the edit button in the action column.
			function openEditBusStopModal(bus_stop){
				//getting the name and co-ordinates from the bus stop row.
				var stop_name = $(bus_stop).parent().parent().find("td:nth-child(2)").text();
				//alert(route_name);
				
				//adding stop name to the temp original name.
				originalBusStopNameBeforeUpdate = stop_name; 
				
				var co_ordinates = [];
				var co_ordinates_string = $(bus_stop).parent().parent().find("td:nth-child(3)").text();
				//alert(stops_String);
				co_ordinates = co_ordinates_string.split(',');
				
				//alert(stop_name);
				//adding the data to the edit form.  
				$("#update_bus_stop_enter_name").val(stop_name);				
				$("#update_bus_stop_longitude").val(co_ordinates[0]);
				$("#update_bus_stop_latitude").val(co_ordinates[1]);
				
				$('#modal_update_bus_stop').modal('show');
				
				
				//adding click listener to the close button of modal to focus on row when closed
				$("#bus_stop_update_close_button").off(); //first removing previous event handler
				$("#bus_stop_update_close_button").click(function(){
					$(bus_stop).parent().parent().focus();			//focusing on the selected row
				});
				
				//adding click listener to the update button of modal
				$("#bus_stop_update_submit_button").off(); //first removing previous event handler
				$("#bus_stop_update_submit_button").click(function(){
					//updating the table row value when modal update button is clicked. and other update mechanism
					updateEditBusStopTable($(bus_stop).parent().parent());  //passing a row as parameter
				});		

				//initializing map
				var map =new L.Map("bus_stop_update_map", {
					layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true, attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'})]	
				});
				map.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.

						if(marker!=null){					
								map_object.removeLayer(marker);
							}
							
				//first setting the default marker position . the variable is from setModalLongLatAndMarkerOnClick() above variable
				marker = new L.marker([co_ordinates[1],co_ordinates[0]], {draggable:true});
							map.addLayer(marker);
							map.setView([co_ordinates[1],co_ordinates[0]], 17, {animate: true, reset: false});
							
							//getting the location even after dragging the marker. i.e getting the location on drag event.
							marker.off();
							marker.on("dragend", function(e){
								var latlng = e.target.getLatLng();		//using target for drag event.
								lng = latlng.lng.toFixed(6);
								lat = latlng.lat.toFixed(6);
								
								//adding the long/lat value on footer.								
								$("#update_bus_stop_map_longitude").text(lng);
								$("#update_bus_stop_map_latitude").text(lat);
							});
							
							
				setModalLongLatAndMarkerOnClick(map);
				//marker = new L.marker([co_ordinates[1],co_ordinates[0]], {draggable:true});
				//map.addLayer(marker);				
				//map.setView([co_ordinates[1],co_ordinates[0]], 18, {animate: true, reset: true});
				
				map_object.invalidateSize();
			}
			
				//marker for the update bus stop modal map
				var marker;
				//this function gets the longitude and latitude of clicked location on map and set to map footer tab
				function setModalLongLatAndMarkerOnClick(map_object){
					
					//when the user single click on map the marker will displayed.
					map_object.off();
					map_object.on('click', function(e) {
							
							map_object.invalidateSize();
							
							//longitude and latitude variable 
							var lng = e.latlng.lng.toFixed(6);		//tofixed() to round to 6 decimal.
							var lat = e.latlng.lat.toFixed(6);				
							
							$("#update_bus_stop_map_longitude").text(lng);
							$("#update_bus_stop_map_latitude").text(lat);
							
							//previous marker will be removed so that user can pin marker anywhere they click and previous pinned marker will not display.
							if(marker!=null){					
								map_object.removeLayer(marker);
							}
									
							marker = new L.marker(e.latlng, {draggable:true});
							map_object.addLayer(marker);
							map_object.setView(e.latlng, 18, {animate: true, reset: false});
							
							//getting the location even after dragging the marker. i.e getting the location on drag event.
							marker.off();
							marker.on("dragend", function(e){
								var latlng = e.target.getLatLng();		//using target for drag event.
								lng = latlng.lng.toFixed(6);
								lat = latlng.lat.toFixed(6);
								
								//adding the long/lat value on footer.								
								$("#update_bus_stop_map_longitude").text(lng);
								$("#update_bus_stop_map_latitude").text(lat);
							});
							//setting the color on add button
							$("#update_bus_stop_map_footer_pin_location_button").css({color:"#FFF",border:"2px solid #CCC"});
							//adding the long lat on "add bus stop form" inputfield.
							$("#update_bus_stop_map_footer_pin_location_button").click(function(){
								$("#update_bus_stop_longitude").val(lng);
								$("#update_bus_stop_latitude").val(lat);
							});
					});
				};
				
				
			
			//array to store all updated bus stop object.
			var updated_BusStops = [];
			//This function writes updated routes details to the edit mode table which will later saved after save button clicked.
			//in addition this function saves the updated value in the updated Bus stop array.
			function updateEditBusStopTable(row){
				var stop_name = capitalizeFirstLetter($("#update_bus_stop_enter_name").val());	
				var lng = $("#update_bus_stop_longitude").val();	
				var lat = $("#update_bus_stop_latitude").val();					
				//validate bus stop name:
				if (stop_name==""){
					$("#bus_stop_update_warning_message small").text(" The Bus stop name is invalid or empty. Please, check and submit again.")				
					$("#bus_stop_update_warning_message").show();
					setTimeout(function(){	
						$("#bus_stop_update_warning_message").slideUp().fadeOut();
					}
					,5000);
					$("#update_bus_stop_enter_name").focus();
				}
				else if(lng=="" || isNaN(lng)){
					$("#bus_stop_update_warning_message small").text(" The longitude is invalid. Please, check the value is not empty and is a Number.")				
					$("#bus_stop_update_warning_message").show();
					setTimeout(function(){	
						$("#bus_stop_update_warning_message").slideUp().fadeOut();
					}
					,5000);
					$("#update_bus_stop_longitude").focus();
				
				}
				else if(lat=="" || isNaN(lat)){
					$("#bus_stop_update_warning_message small").text(" The latitude is invalid. Please, check the value is not empty and is a Number.")				
					$("#bus_stop_update_warning_message").show();
					setTimeout(function(){	
						$("#bus_stop_update_warning_message").slideUp().fadeOut();
					}
					,5000);
					$("#update_bus_stop_latitude").focus();
				
				}
				//checking for duplicate entry
				else if(checkForDuplicateBusStopEntry(stop_name)==true){	
					$("#bus_stop_update_warning_message small").text(" The Bus Stop that you are trying to add is already exist. Please, check and try again.")				
					$("#bus_stop_update_warning_message").show();
					setTimeout(function(){	
						$("#bus_stop_update_warning_message").slideUp().fadeOut();
					}
					,5000);				
				}
				else{
					//creating an object of bus stop
					var bus_stop = {original:originalBusStopNameBeforeUpdate, updated:stop_name, longitude:lng, latitude:lat};
					
					//now adding the bus stop object list to main array collection.
					//var index = updated_BusStops.length;
					//updated_BusStops[index] = bus_stop;
					updated_BusStops.push(bus_stop);
					
					
					$("#bus_stop_update_loading_icon").fadeIn();
					$("#bus_stop_update_submit_button").prop("disabled", true);						
				
					setTimeout(function(){							
						//changing the updated route text color to green and making font bold						
						$(row).css({
						"font-weight":"bold",
						"color":"#673AB7"
						});
						
						//now updating the bus stop list in the main table.
						$(row).find("td:nth-child(2)").text(stop_name);
						$(row).find("td:nth-child(3)").text(lng+", "+lat);
						
						$("#bus_stop_update_loading_icon").fadeOut();					
						$("#bus_stop_update_submit_button").prop("disabled", false);
						//alert(stops);
						$("#modal_update_bus_stop").modal('hide');
						$(row).focus();
					}
					,600);
				}
			}
			
			
			//This function saves the updated value to the database server
			function saveUpdatedBusStopDetail(){
				if(updated_BusStops.length==0){					
					$("#bus_stop_save_already_saved_error_message").slideDown().fadeIn();
					setTimeout(function(){
						$("#bus_stop_save_already_saved_error_message").slideUp().fadeOut();
					},5000);
				}
				else{
					//disabling the save or exit button during saving data
					$("#content_header_button_save").prop("disabled",true);
					$("#content_header_button_exit").prop("disabled",true);
					//enabling the loading animation				
					$("#content_header_loading_icon").fadeIn();
					setTimeout(function(){					
					
					
						
						//###################################################################################
						//saving status from server.
						
						
						//updated_Schedules need to send to serve.rad
						
						var serverStatus = updateBusStopToServer(updated_BusStops);
						
						
						//###################################################################################	
						
						
						if(serverStatus==true){
							//adding the update to local array
							
							//alert(JSON.stringify(busStopCollection));
							//modify the changes from the local array too.
							jQuery.each(updated_BusStops, function(i,updated_stop){
								jQuery.each(busStopCollection, function(i,old_stop){
									if(old_stop.name==updated_stop.original){
										old_stop.name=updated_stop.updated;
										old_stop.longitude=updated_stop.longitude;
										old_stop.latitude=updated_stop.latitude;
										return true;
									}
								});
							});
							//alert(JSON.stringify(busStopCollection));
							//empty updated routes array collection
							updated_BusStops = [];
							
							$("#bus_stop_save_success_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#bus_stop_save_success_message").slideUp().fadeOut();
							},5000);
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfBusStopRow();
							
						}
						else{
							$("#bus_stop_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#bus_stop_save_danger_message").slideUp().fadeOut();
							},5000);
						}
						
						//jQuery.each(updated_BusStops, function(i, val){						
						//	alert(i+" , "+val.name+" , "+val.longitude+", "+val.latitude);
							
						//re-enabling the save or exit button during saving data
						$("#content_header_button_save").prop("disabled",false);
						$("#content_header_button_exit").prop("disabled",false);
						//disabling the loading animation				
						$("#content_header_loading_icon").fadeOut();
						//});
					},2000);
				}
			}
			
			
			//##########################DELETE BUS STOP SECTION###################################
			
			//saving original table since changes are already made in table as highligheed color before update if user choose to cancel or server error occured. the original table need to be replaced.
			var original_bus_stop_table;

			//this function displays the delete option for bus stop
			function displayBusStopDeleteOption(){
					
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_bus_stop_table").find("tbody").children().length==0){					
						$("#display_bus_stop_table").hide();						
						$("#bus_stop_display_status_message").hide();
						$("#bus_stop_display_status_message_title").text("DELETE NOT AVAILABLE. ");
						$("#bus_stop_display_status_message_details").text("Currently, there are no any bus stops details are available to edit. You can add new Bus Stop and added Bus stops will be displayed here to edit and update.");
						$("#bus_stop_display_status_message").slideDown().fadeIn();	
						
					setTimeout(function(){	

					$("#bus_stop_display_status_message").slideUp().fadeOut();
						$("#bus_stop_display_status_message_title").text("BUS STOPS NOT AVAILABLE. ");
						$("#bus_stop_display_status_message_details").text("Currently, there are no any bus stops details are available to display here. You can add new Bus Stop and added Bus stops will be displayed here.");
						$("#bus_stop_display_status_message").slideDown().fadeIn();
					},3000);
				}
				else{
					original_bus_stop_table = $("#display_bus_stop_table").clone();
					//making map faded and unclickable
					$("#bus_stop_map_container").css({'pointer-events':'none','filter':'alpha(opacity=60)', 'opacity':'0.6'});
					
					disableTooltip(true);
					changeCursor("auto");
					disableRowClick(true);
						
					$("#bus_stop_main_table_section").css({height:"87.5%"});
					//$("#edit_option_exit_button").fadeIn();				
					$("#bus_stop_tab_main_container").hide();
					activateHeaderButton("delete");
					
					//adding tick input in the table.					
					$("#display_bus_stop_table thead tr").prepend('<th width="8%">MARK</th>');
					$("#display_bus_stop_table tbody tr").prepend('<td style="padding:0px; margin:0px"><span style="background:none;border:none" class="input-group-addon"><input type="checkbox" aria-label="..." onclick="unTickBusStopDeleteSelectAllCheckBox()"></span></td>');		
					
					
					$("#delete_bus_stop_apply_and_cancel_buttons").fadeIn();
					$("#delete_bus_stop_route_delete_select_all_checkbox").fadeIn();
					disableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", true);									
					
					$("#loading_1").fadeIn();
					setTimeout(function(){
						$("#loading_1").fadeOut();
						$("#bus_stop_tab_main_container").fadeIn('slow');
					},200);
				}
			}
			
			//Action of select all checkbox on delete bus stop details option. the function will return either the checkbox is checked or not.
			//triggered by select all checkbox.
				function selectBusStopDeleteAllCheckBox(){
					if($("#bus_stop_delete_select_all_checkbox").is(":checked")){					
					//alert("checked");
					//checking all the input checkboxes in the list.
					$("#display_bus_stop_table tbody tr").find("input:checkbox").prop('checked', true);
					}
					else{
						//alert("not checked");					
						$("#display_bus_stop_table tbody tr").find("input:checkbox").prop('checked', false);
					}
				}
				
			//This function unselect the select all Checkbox. This is to make the main select all tick box unticked when any of all selected boxes are manually unchecked during deletion.
			function unTickBusStopDeleteSelectAllCheckBox(){
				$("#bus_stop_delete_select_all_checkbox").prop('checked', false);
			}
			
			
			//this function removes the checkbox from the bus stop delete option
			function removeCheckBoxInBusStopTable(){
				$("#display_bus_stop_table thead tr th:first").remove();
				$("#display_bus_stop_table tbody tr td:nth-child(1)").each(function(){
					(this).remove();
				});
			}
			
			
		//this function get out of the delete option mode
			function cancelBusStopDeleteOption(){	
				//replacing with updated table only if some item has been deleted and table is updated else do nothing.
				if(isUpdated_table){
					$("#display_bus_stop_table").replaceWith(updated_bus_stop_table);
					removeCheckBoxInBusStopTable();
				}
				else{
					$("#display_bus_stop_table").replaceWith(original_bus_stop_table);
				}
				
				setTabHeader("CURRENT BUS STOPS", "  List of currently available Bus Stops.");	
					//map opacity to 1.
					$("#bus_stop_map_container").css({'pointer-events':'auto','filter':'alpha(opacity=100)', 'opacity':'1'});
					
					disableTooltip(false);
					changeCursor("pointer");
					disableRowClick(false);
					
					
					$("#bus_stop_main_table_section").css({height:"100%"});
					
					$("#bus_stop_tab_main_container").hide();					
					$("#loading_1").fadeIn();
				$("#delete_bus_stop_apply_and_cancel_buttons").hide();
				$("#delete_bus_stop_route_delete_select_all_checkbox").hide();
				enableAddEditDeleteButtons();
				$("#content_header_button_refresh").prop("disabled", false);
				setTimeout(function(){	
					if($("#display_bus_stop_table").find("tbody").children().length!=0){   //re-enabling container only is all row is not deleted 
						$("#bus_stop_tab_main_container").fadeIn();	
					}						
					$("#loading_1").fadeOut();
				},400);
			}
			
			//variable to clone table state after delete. Only for tooltip regain purpose.
			var updated_bus_stop_table;
			var isUpdated_table = false;
			
			//this function delete bus stop from server.
			function deleteBusStopRows(){	
				$("#display_bus_stop_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						$(row).find("td:nth-child(3)").parent().remove();
					}
				});
				
				//cloning the table
				updated_bus_stop_table = $("#display_bus_stop_table").clone();
				isUpdated_table = true;
				
				//server code
				//alert("deleted bus stops: "+bus_stops_to_delete);
			}
			
			//this function get the route name to delete
			function getBusStopNameToDelete(){
				var stops_to_delete = [];
				$("#display_bus_stop_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						//alert("checked");
						stops_to_delete.push($(row).find("td:nth-child(3)").text());
						//$(row).find("td:nth-child(3)").parent().remove();
						//count = count+1;
						//alert(routes_to_delete[i]);
					}
				});	
				//alert(routes_to_delete);
				//alert(routes_to_delete.length);
				
				return stops_to_delete;
			}
			

			//delete the bus stop from the page.
			function deleteBusStopRowsExtended(){				
				$("#bus_stop_delete_loading_icon").fadeIn();
				
				//degetting the schdule details that need to be deleted.
				var toDeleteStopsList = getBusStopNameToDelete();	
				
				setTimeout(function(){

				//##################################################
				//Server codes
				//send toDeleteSchedules to server to delete.
				var deleteStatus = deleteBusStopToServer(toDeleteStopsList);
				
				
				
				//####################################################
								
				if(deleteStatus == true){
					deleteBusStopRows();		//deleting rows in displayed table
					
					//deleting from local array
					//alert(JSON.stringify(busStopCollection));
					for(var i=0; i<toDeleteStopsList.length;i++){
						for(var j=0; i<busStopCollection.length;j++){
							if(busStopCollection[j].name==toDeleteStopsList[i]){
								busStopCollection.splice(busStopCollection.indexOf(busStopCollection[j]),1);
								break;
							}
						}
					};					
					
					//alert(JSON.stringify(busStopCollection));
					
					
					$("#bus_stop_delete_loading_icon").fadeOut();
					//displaying the no route message in screen if all bus stop deleted.
					if(displayBusStopDetailAlertMessage()!=true){
										//displaying status message
						//$("#bus_stop_delete_success_message").hide();		//hiding any previous message first
						$("#bus_stop_delete_success_message").slideDown("slow").fadeIn("slow");
						$("#bus_stop_delete_success_message").focus();
						$("#bus_stop_delete_success_message").blur();
												
						$("#bus_stop_main_table_section").css({height:"76%"});
							
						setTimeout(function(){						
								$("#bus_stop_main_table_section").css({height:"87.5%"});	
							//alert();
							$("#bus_stop_delete_success_message").slideUp().fadeout(); //nothing will work after this line why? may be bug? try uncommenting the alert apple below. will not work but above alert will work. why?
							//alert("apple");
						},5000);
					}
				
				}
				else{										
					$("#bus_stop_server_danger_message_title").text("ERROR OCCURED!!!");
					$("#bus_stop_server_danger_message_detail").text(" Something went wrong while deleting the Bus Stop detail. Please, try again later.");
					$("#bus_stop_server_danger_message").slideDown().fadeIn();
					setTimeout(function(){
						$("#bus_stop_server_danger_message").slideUp().fadeOut();	
					},4000);
					$("#bus_stop_delete_loading_icon").fadeOut();
				}
						

				},1500);
			}
			
			
			//this function displays modal to ask user to delete the selected bus stop rows and then delete.
			function displayBusStopDeleteModal(){	
				var bus_stops_to_delete = [];				
				var count = 0;
				$("#display_bus_stop_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						//routes_to_delete[i] = $(row).find("td:nth-child(3)").text();
						//$(row).find("td:nth-child(3)").parent().remove();						
						count = count+1;
					}
				});
				if (count==0){					
					$("#alert_modal_title").text("DELETE BUS STOP");
					$("#alert_modal_content").text("Nothing is selected.");
					$("#alert_modal").modal('show');
				}
				else{
					$("#action_modal_title").text("DELETE BUS STOP");
					$("#action_modal_content").text("Are you sure want to delete this Bus Stop detail?");
					$("#action_modal").modal('show');
					$('#action_modal_delete').click(function (e) {
					  // deleting the route rows.
					  deleteBusStopRowsExtended();
					})
				}
			}
			
			//this message either display the empty route table message when there is no bus stop rows to display or table.
			function displayBusStopDetailAlertMessage(){
				if($("#display_bus_stop_table").find("tbody").children().length==0){
				
					cancelBusStopDeleteOption();
					
					$("#bus_stop_tab_main_container").hide();
					$("#bus_stop_display_status_message_title").text("Bus Stop un-available.");						
					$("#bus_stop_display_status_message_details").text("There is nothing to display. Please, add a new Bus stop details. Your added details will be displayed here.");	
					$("#bus_stop_display_status_message").fadeIn();	
					return true;
				}	
				else{
					$("#bus_stop_display_status_message").css({
						display:"none"
					});	
					$("#bus_stop_tab_main_container").fadeIn();
					return false;
				}
			}
			
			
			
			
			//######################Route Way tab#####################################
			
			//these following variable will be set from server downloaded data.
			var way_available_routes =[]; //this is example to mimic data from server
			var routeWaysCollection = [];
			var way_not_available_routes =[]; //this is example to mimic data from server

			//Map co-ordinate example
			var route1_way = {name:"Route 1",wayLine:[{node:1, latitude:27.71595, longitude:85.28364}, {node:2, latitude:27.70743, longitude:85.28263}, {node:3, latitude:27.69950, longitude:85.28177}, {node:4, latitude:27.69858, longitude:85.28154}, {node:5, latitude:27.69804, longitude:85.28155}, {node:6, latitude:27.69337, longitude:85.28174}, {node:7, latitude:27.69356, longitude:85.28275}, {node:8, latitude:27.69378, longitude:85.28370}, {node:9, latitude:27.69409, longitude:85.28449}, {node:10, latitude:27.69427, longitude:85.28498}, {node:11, latitude:27.69533, longitude:85.28908}, {node:12, latitude:27.69539, longitude:85.28979}, {node:13, latitude:27.69545, longitude:85.29009}, {node:14, latitude:27.69564, longitude:85.29072}, {node:15, latitude:27.69564, longitude:85.29088}, {node:16, latitude:27.69563, longitude:85.29101}, {node:17, latitude:27.69546, longitude:85.29200}, {node:18, latitude:27.69544, longitude:85.29216}, {node:19, latitude:27.69547, longitude:85.29250}, {node:20, latitude:27.69553, longitude:85.29270}, {node:21, latitude:27.69559, longitude:85.29285}, {node:22, latitude:27.69579, longitude:85.29306}, {node:23, latitude:27.69664, longitude:85.29356}, {node:24, latitude:27.69673, longitude:85.29381}, {node:25, latitude:27.69695, longitude:85.29447}, {node:26, latitude:27.69850, longitude:85.29960}, {node:27, latitude:27.69860, longitude:85.30000}, {node:28, latitude:27.69843, longitude:85.30074}, {node:29, latitude:27.69806, longitude:85.30260}, {node:30, latitude:27.69781, longitude:85.30355}, {node:31, latitude:27.69773, longitude:85.30372}, {node:32, latitude:27.69667, longitude:85.30570}, {node:33, latitude:27.69660, longitude:85.30587}, {node:34, latitude:27.69627, longitude:85.30704}, {node:35, latitude:27.69604, longitude:85.30776}, {node:36, latitude:27.69585, longitude:85.30828}, {node:37, latitude:27.69509, longitude:85.31006}, {node:38, latitude:27.69462, longitude:85.31135}, {node:39, latitude:27.69433, longitude:85.31206}, {node:40, latitude:27.69425, longitude:85.31229}, {node:41, latitude:27.69411, longitude:85.31274}, {node:42, latitude:27.69397, longitude:85.31336}, {node:43, latitude:27.69390, longitude:85.31375}, {node:44, latitude:27.69388, longitude:85.31395}, {node:45, latitude:27.69393, longitude:85.31397}, {node:46, latitude:27.69398, longitude:85.31401}, {node:47, latitude:27.69412, longitude:85.31407}, {node:48, latitude:27.69430, longitude:85.31410}, {node:49, latitude:27.69445, longitude:85.31409}, {node:50, latitude:27.69614, longitude:85.31384}, {node:51, latitude:27.69708, longitude:85.31374}, {node:52, latitude:27.69732, longitude:85.31368}, {node:53, latitude:27.69786, longitude:85.31347}, {node:54, latitude:27.69800, longitude:85.31338}, {node:55, latitude:27.69810, longitude:85.31330}, {node:56, latitude:27.69934, longitude:85.31341}, {node:57, latitude:27.69967, longitude:85.31345}, {node:58, latitude:27.70000, longitude:85.31348}, {node:59, latitude:27.70055, longitude:85.31351}, {node:60, latitude:27.70157, longitude:85.31357}, {node:61, latitude:27.70184, longitude:85.31360}, {node:62, latitude:27.70356, longitude:85.31377}, {node:63, latitude:27.70377, longitude:85.31375}, {node:64, latitude:27.70400, longitude:85.31380}, {node:65, latitude:27.70445, longitude:85.31383}, {node:66, latitude:27.70458, longitude:85.31387}, {node:67, latitude:27.70537, longitude:85.31405}, {node:68, latitude:27.70572, longitude:85.31412}, {node:69, latitude:27.70706, longitude:85.31431}, {node:70, latitude:27.70788, longitude:85.31436}, {node:71, latitude:27.70847, longitude:85.31440}, {node:72, latitude:27.70855, longitude:85.31444}, {node:73, latitude:27.70874, longitude:85.31463}, {node:74, latitude:27.70874, longitude:85.31482}, {node:75, latitude:27.70881, longitude:85.31530}, {node:76, latitude:27.70899, longitude:85.31590}, {node:77, latitude:27.70926, longitude:85.31666}, {node:78, latitude:27.70940, longitude:85.31703}, {node:79, latitude:27.70944, longitude:85.31709}, {node:80, latitude:27.70951, longitude:85.31716}, {node:81, latitude:27.70960, longitude:85.31720}, {node:82, latitude:27.70989, longitude:85.31724}, {node:83, latitude:27.71006, longitude:85.31723}, {node:84, latitude:27.71028, longitude:85.31738}, {node:85, latitude:27.71301, longitude:85.31783}, {node:86, latitude:27.71324, longitude:85.31790}, {node:87, latitude:27.71332, longitude:85.31819}, {node:88, latitude:27.71360, longitude:85.31938}, {node:89, latitude:27.71366, longitude:85.31997}, {node:90, latitude:27.71371, longitude:85.32197}, {node:91, latitude:27.71343, longitude:85.32204}, {node:92, latitude:27.71214, longitude:85.32219}, {node:93, latitude:27.71158, longitude:85.32223}, {node:94, latitude:27.71127, longitude:85.32218}, {node:95, latitude:27.71099, longitude:85.32210}, {node:96, latitude:27.71050, longitude:85.32198}, {node:97, latitude:27.71033, longitude:85.32223}, {node:98, latitude:27.71029, longitude:85.32271}, {node:99, latitude:27.71025, longitude:85.32311}, {node:100, latitude:27.71017, longitude:85.32450}, {node:101, latitude:27.71010, longitude:85.32514}, {node:102, latitude:27.71001, longitude:85.32604}, {node:103, latitude:27.70994, longitude:85.32623}, {node:104, latitude:27.70921, longitude:85.32938}, {node:105, latitude:27.70913, longitude:85.32979}, {node:106, latitude:27.70902, longitude:85.33025}, {node:107, latitude:27.70894, longitude:85.33067}, {node:108, latitude:27.70894, longitude:85.33067}, {node:109, latitude:27.70866, longitude:85.33199}, {node:110, latitude:27.70862, longitude:85.33222}, {node:111, latitude:27.70841, longitude:85.33291}, {node:112, latitude:27.70829, longitude:85.33330}, {node:113, latitude:27.70830, longitude:85.33338}, {node:114, latitude:27.70826, longitude:85.33363}, {node:115, latitude:27.70811, longitude:85.33626}, {node:116, latitude:27.70810, longitude:85.33653}, {node:117, latitude:27.70798, longitude:85.33935}, {node:118, latitude:27.70798, longitude:85.33945}, {node:119, latitude:27.70797, longitude:85.33995}, {node:120, latitude:27.70800, longitude:85.34021}, {node:121, latitude:27.70818, longitude:85.34097}, {node:122, latitude:27.70821, longitude:85.34117}, {node:123, latitude:27.70817, longitude:85.34186}, {node:124, latitude:27.70810, longitude:85.34227}, {node:125, latitude:27.70804, longitude:85.34251}, {node:126, latitude:27.70785, longitude:85.34314}, {node:127, latitude:27.70780, longitude:85.34334}, {node:128, latitude:27.70767, longitude:85.34371}, {node:129, latitude:27.70721, longitude:85.34436}, {node:130, latitude:27.70606, longitude:85.34581}, {node:131, latitude:27.70595, longitude:85.34601}, {node:132, latitude:27.70588, longitude:85.34619}, {node:133, latitude:27.70578, longitude:85.34653}, {node:134, latitude:27.70575, longitude:85.34674}, {node:135, latitude:27.70574, longitude:85.34693}, {node:136, latitude:27.70576, longitude:85.34731}, {node:137, latitude:27.70613, longitude:85.34959}, {node:138, latitude:27.70623, longitude:85.35030}, {node:139, latitude:27.70625, longitude:85.35048}, {node:140, latitude:27.70624, longitude:85.35070}, {node:141, latitude:27.70620, longitude:85.35092}, {node:142, latitude:27.70613, longitude:85.35111}, {node:143, latitude:27.70605, longitude:85.35128}, {node:144, latitude:27.70592, longitude:85.35147}, {node:145, latitude:27.70579, longitude:85.35162}, {node:146, latitude:27.70561, longitude:85.35177}, {node:147, latitude:27.70545, longitude:85.35187}, {node:148, latitude:27.70526, longitude:85.35195}, {node:149, latitude:27.70510, longitude:85.35198}, {node:150, latitude:27.70305, longitude:85.35213}, {node:151, latitude:27.70282, longitude:85.35218}, {node:152, latitude:27.70252, longitude:85.35232}, {node:153, latitude:27.70093, longitude:85.35353}, {node:154, latitude:27.70071, longitude:85.35373}, {node:155, latitude:27.70019, longitude:85.35411}]};
		
			
			var route2_way = {name:"Route 2",wayLine:[{node:1, latitude:27.71595, longitude:85.28364}, {node:2, latitude:27.70743, longitude:85.28263}, {node:3, latitude:27.69950, longitude:85.28177}, {node:4, latitude:27.69858, longitude:85.28154}, {node:5, latitude:27.69804, longitude:85.28155}, {node:6, latitude:27.69337, longitude:85.28174}, {node:7, latitude:27.69356, longitude:85.28275}, {node:8, latitude:27.69378, longitude:85.28370}, {node:9, latitude:27.69409, longitude:85.28449}, {node:10, latitude:27.69427, longitude:85.28498}, {node:11, latitude:27.69533, longitude:85.28908}, {node:12, latitude:27.69539, longitude:85.28979}, {node:13, latitude:27.69545, longitude:85.29009}, {node:14, latitude:27.69564, longitude:85.29072}, {node:15, latitude:27.69564, longitude:85.29088}, {node:16, latitude:27.69563, longitude:85.29101}, {node:17, latitude:27.69546, longitude:85.29200}, {node:18, latitude:27.69544, longitude:85.29216}, {node:19, latitude:27.69547, longitude:85.29250}, {node:20, latitude:27.69553, longitude:85.29270}, {node:21, latitude:27.69559, longitude:85.29285}, {node:22, latitude:27.69579, longitude:85.29306}, {node:23, latitude:27.69664, longitude:85.29356}, {node:24, latitude:27.69673, longitude:85.29381}, {node:25, latitude:27.69695, longitude:85.29447}, {node:26, latitude:27.69850, longitude:85.29960}, {node:27, latitude:27.69860, longitude:85.30000}, {node:28, latitude:27.69843, longitude:85.30074}, {node:29, latitude:27.69806, longitude:85.30260}, {node:30, latitude:27.69781, longitude:85.30355}, {node:31, latitude:27.69773, longitude:85.30372}, {node:32, latitude:27.69667, longitude:85.30570}, {node:33, latitude:27.69660, longitude:85.30587}, {node:34, latitude:27.69627, longitude:85.30704}, {node:35, latitude:27.69604, longitude:85.30776}, {node:36, latitude:27.69585, longitude:85.30828}, {node:37, latitude:27.69509, longitude:85.31006}, {node:38, latitude:27.69462, longitude:85.31135}]};
		
			var route3_way = {name:"Route 3",wayLine:[{node:1, latitude:27.71595, longitude:85.28364}, {node:2, latitude:27.70743, longitude:85.28263}, {node:3, latitude:27.69950, longitude:85.28177}, {node:4, latitude:27.69858, longitude:85.28154}, {node:5, latitude:27.69804, longitude:85.28155}, {node:6, latitude:27.69337, longitude:85.28174}, {node:7, latitude:27.69356, longitude:85.28275}, {node:8, latitude:27.69378, longitude:85.28370}, {node:9, latitude:27.69409, longitude:85.28449}, {node:10, latitude:27.69427, longitude:85.28498}, {node:11, latitude:27.69533, longitude:85.28908}, {node:12, latitude:27.69539, longitude:85.28979}, {node:13, latitude:27.69545, longitude:85.29009}, {node:14, latitude:27.69564, longitude:85.29072}, {node:15, latitude:27.69564, longitude:85.29088}, {node:16, latitude:27.69563, longitude:85.29101}, {node:17, latitude:27.69546, longitude:85.29200}, {node:18, latitude:27.69544, longitude:85.29216}]};
			
			
			
			//this function gets the all the way route data from teh server
			//on refresh this method will be called and then div will be revalidate
			
			
			//var is_route_way_tab_opened = false;
				
			function loadRouteWayData(){
				//codes which will return array of object below route1_way

					//route_way_data_load_status = true;
					
				//set like this 
				//var route_way_obj1 = {name:"Route 1",ways:route1_way};
				//var route_way_obj2 = {name:"Route 2",ways:route2_way};
				//var route_way_obj3 = {name:"Route 3",ways:route3_way};
				
				routeWaysCollection.push(route1_way,route2_way,route3_way);
				
				way_available_routes =['Route 1', 'Route 2', 'Route 3']; //this is example to mimic data from server
				way_not_available_routes =['Route 4','Route 5']; //this is example to mimic data from server
		
			}
			loadRouteWayData();
			
			
			
						//#############################################################################################
			//#SERVER INTERACTTION CODES

			function addRouteWayToServer(routeWay){
				alert(JSON.stringify(routeWay));
				return true;
			}	


			function updateRouteWayToServer(waysList){
			//format {name:route_name, wayLine:markerLatLngObjects};   the way line is new. in server this is need to be updated. or totally replaced, and name is route name and a reference.
			alert(JSON.stringify(waysList));
				return true;
			}


			function deleteRouteWayToServer(routeName){
			alert(routeName);
				return true;
			}


			//############################################################################################
			
			
			
			
			//this function gets the loads the route names and display to the left panel
			function loadRouteWayDataToPage(){
				
				//adding route on way added table
				//adding separate id for val i.e. route name so that it can easily retrive without getting glyphicon when .text() on tr. 
				//also id is set to i+1000 because to make it unique.
				/*jQuery.each(way_available_routes, function(i, val){
					$("#display_added_route_way_table tbody").append('<tr tabindex="1"><td>'+parseInt(i+1)+'</td><td style="padding-left:24px"><span id="'+i+1000+'">'+val +'</span><span style="float:right;"><a onclick="addPopoverOptionInRow(this)"><span style="margin-right:8px;cursor:pointer" class="glyphicon glyphicon-option-horizontal"></span></a></span></td></tr>');
				}); */
				
				
				if(way_available_routes.length==0){
					$("#display_route_way_added_table_not_available").fadeIn();
					$("#display_added_route_way_table").hide();
				}
				//displaying the Added route way table on side panel
				else{
					$("#display_route_way_added_table_not_available").hide();
					$("#display_added_route_way_table").fadeIn();					
					jQuery.each(way_available_routes, function(i, val){
						$("#display_added_route_way_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td width="90%" style="padding-left:24px"><span id="'+i+1000+'">'+val +'</span><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:24px; height:24px;width:24px;background-size: 24px 24px;background-repeat: no-repeat;"></span><span style="float:right;"><a style="float:right" onclick="displayOptionMenu(this)"><span style="margin-right:8px;cursor:pointer" class="glyphicon glyphicon-option-horizontal"></span></a><a style="display:none; float:right" onclick="hideOptionMenu(this)"><span style="margin-right:8px;cursor:pointer" class="glyphicon glyphicon-option-vertical"></span></a><br><div style="display:none; height:24px; width:100%; margin-top:4px; margin-bottom:-8px"><span style="margin-right:12px;margin-left:6px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="View Way" class="glyphicon glyphicon-globe" onclick="displayRouteWay(this)"></span><span <span style="width:18px" data-placement="top" data-toggle="tooltip"  title="View RawList"><span style="margin-right:12px; cursor:pointer; float:left" class="glyphicon glyphicon-file" onclick="viewRawCoOrdinates(this)"></span></span><span style="margin-right:12px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Edit Way" class="glyphicon glyphicon-edit" onclick="openEditRouteWay(this)"></span><span style=" margin-right:8px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Delete Way" class="glyphicon glyphicon-trash" onclick="deleteRouteWay(this)"></span></div></span></td></tr>');
					}); 
				}
				
				
				
				
				if(way_not_available_routes.length==0){
					$("#display_route_way_not_added_table_not_available").fadeIn();
					$("#display_not_added_route_way_table").hide();				
				}
				else{
					$("#display_route_way_not_added_table_not_available").hide();
					$("#display_not_added_route_way_table").show();	
					
					//adding route on way not added table
					jQuery.each(way_not_available_routes, function(i, val){
						$("#display_not_added_route_way_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td style="padding-left:24px"><span id="'+i+2000+'">'+val +'</span><span  style="float:right; margin-right:8px;cursor:pointer" class="glyphicon glyphicon-plus" onclick="openAddRouteWay(this)"></span></td></tr>');
					});					
				}
			};
			loadRouteWayDataToPage();
			
			
			//this function displays the option menu when user click on option icon on route way added table row.
			function displayOptionMenu(row){
				//hiding any other row option menu if they are opened.
				$(row).parent().parent().parent().parent().each(function(i, table_row){
					$(table_row).find("div").slideUp();
						$(table_row).find("tr td:nth-child(2) span:nth-child(3) a:nth-child(1)").show();
						$(table_row).find("tr td:nth-child(2) span:nth-child(3) a:nth-child(2)").hide();
						
				});
				//showing the selected row option menu.
				$(row).parent().find("div").slideDown();
				$(row).parent().find("a:last").show();
				$(row).hide();
			}
			
			//this function hides the option menu when user click on option icon on route way added table row.
			function hideOptionMenu(row){
				$(row).parent().find("div").slideUp();
				$(row).parent().find("a:first").show();
				$(row).hide();
			}
			

			/*
			function addPopoverOptionInRow(option){
				$(option).popover({
					role:'button',
					tabindex:'0',
					trigger:'focus',
					placement: 'top',
					html: 'true',
					content : '<div style="height:24px; width:78px"><span style="margin-right:12px;margin-left:6px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="View Way" class="glyphicon glyphicon-globe" onclick="displayRouteWay(this)"></span><span style="margin-right:12px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Edit Way" class="glyphicon glyphicon-edit" onclick="openEditRouteWay(this)"></span><span style="margin-right:6px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Delete Way" class="glyphicon glyphicon-trash" onclick="deleteRouteWay(this)"></span></div>'
				});
				$(option).popover('show');
				$(option).on('shown.bs.popover', function(){
					$("#route_way_tab").click(function(){						
						$(option).popover('hide');
					});
				});
			} 
			*/
			
			//this function gets the route way data by taking route name as arguement and return route way
			//this method parse the JSON Object to get only lat lng. format of JSON : {name:route 1, wayLine:[{node:1,longitude:33434,latitude:43434},{node:1,longitude:33434,latitude:43434}{node:1,longitude:33434,latitude:43434}{node:1,longitude:33434,latitude:43434}]}. 
			//Here, only extract lng and lat. and create array structure : [[27.70874, 85.31463], [27.70874, 85.31482], [27.70881, 85.31530]]
			function getRouteWayData( jsonObject, routeName ){
				var searchStatus = false;
				for(var i=0; i<jsonObject.length; i++) {
					if (jsonObject[i].name == routeName){
						var wayLine = jsonObject[i].wayLine;
						var onlyLatLng = [];
						
						for(var j=0; j<wayLine.length;j++){
							var lng = wayLine[j].longitude;
							var lat = wayLine[j].latitude;
							var latLng = [lat, lng];
							onlyLatLng.push(latLng);
						}
						searchStatus = true;
						//alert(onlyLatLng);
						return onlyLatLng;
					}
				}
				if(searchStatus==false){
					return null;
				}
			}
			
			//initializing the wayline. this variable holds temporarily the route way line co-ordinates when user click to open to display roue way of any avaibale route.
			var wayLine;
			//This function is triggered from option menu view Way. displays the way of the route on map.
			function displayRouteWay(route){
				//showing add option for this route if other route way is not being added or edited currently.
				if(is_route_way_add_available==false){					
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot display the route way at the moment. Route way ADD MODE is currently activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else if(is_route_way_edit_available==false){				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot display the route way at the moment. Route way EDIT MODE is currently activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else{				
					//gettin the row id 
					var row_id = $(route).parent().parent().parent().parent().find("td:nth-child(1)").text();				
					//getting row route name 				
					var row_name = $(route).parent().parent().parent().parent().find("td:nth-child(2) span:nth-child(1)").text();				
					//alert(row_name);
					//getting the way data
					
					var wayData = getRouteWayData(routeWaysCollection, row_name);
					
					//removing any previous wayline.
					if(wayLine!=null){
						map_route_way.removeLayer(wayLine);
					}
					
					setRouteWayMapView(true, false);
					
					$("#route_way_edit_mode_footer").slideUp().fadeOut();
					$("#route_way_add_mode_footer").slideUp().fadeOut();
					$("#route_way_no_mode_footer").slideUp().fadeOut();
					$("#route_way_view_mode_footer").slideUp().fadeIn();
					
					$("#route_way_view_mode_name").text(row_name).hide().fadeIn();	
					
					//adding listenr to clear button
					/*$("#route_way_view_mode_clear_button").on('click', function(){
						map_route_way.removeLayer(wayLine);	
						setRouteWayMapView(true, false);
					});*/
					$("#route_way_view_mode_exit").off();
					$("#route_way_view_mode_exit").on('click', function(){
						map_route_way.removeLayer(wayLine);	
						setRouteWayMapView(true, false);
						setDefaultRouteWayMapFooter();
					});
					
					$("#loading_2").fadeIn();
					setTimeout(function(){													
						$("#loading_2").fadeOut(100);
						//displaying wayData in the map
						wayLine = L.polyline(wayData).addTo(map_route_way);	
						//L.circle([27.71595, 85.28364], 35, {color: 'red',fillColor: '#f03',fillOpacity: 0.5}).bindLabel('Swayambhu Bus Station', { noHide: true }).addTo(map_route_way);
					},600);	
				}
			}
			
			//this function set to default map footer mode
			function setDefaultRouteWayMapFooter(){
				if($("#route_way_view_mode_footer:visible").length!=0){
					//alert("A");
					$("#route_way_view_mode_footer").slideDown().fadeOut();
				}
				if($("#route_way_edit_mode_footer:visible").length!=0){
					//alert("B");
					$("#route_way_edit_mode_footer").slideDown().fadeOut();
				}
				if($("#route_way_add_mode_footer:visible").length!=0){
					//alert("C");
					$("#route_way_add_mode_footer").slideDown().fadeOut();
				}			
				$("#route_way_no_mode_footer").slideDown().fadeIn();
			}
			
			
				
			
			//this variable store boolean value for if any other route way is being added when another route edit, add, view etc. button is clicked.
			//initially add is available therefore, true.
			var is_route_way_add_available = true;

			//Thia function add route way
			function openAddRouteWay(route){
				//showing add option for this route if other route way is not being added currently.
				if(is_route_way_add_available==false){					
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot add the route way at the moment. Route way ADD MODE is already activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else if(is_route_way_edit_available==false){				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot add the route way at the moment. Route way EDIT MODE is currently activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else{
					
					//removing any previous wayline that is opened in view mode.
					if(wayLine!=null){
						map_route_way.removeLayer(wayLine);
					}
					
					//displaying loading animation first
					//$("#route_way_map").hide();
					$("#loading_2").fadeIn();
					setTimeout(function(){
						$("#loading_2").fadeOut();					
						//$("#route_way_map").show();
					},900);
					
					//setting route add is unavailable
					is_route_way_add_available = false;
					//getting row route name 				
					var row_name = $(route).parent().find("span:nth-child(1)").text();
					$(route).parent().parent().focus();
					
					//highlighting current row.
					//backing up color
					var background_color =$(route).parent().parent().css("background-color");
					$(route).parent().parent().css({"background-color":"#E0E0E0"});
					$(route).parent().find("span:nth-child(1)").css({color:"#673AB7","font-weight":"bold"});
					//alert(row_name);
						
					//setting the default map view and initializing map footer.
					setRouteWayMapView(true, false);
					$("#route_way_edit_mode_footer").slideUp().fadeOut();
					$("#route_way_view_mode_footer").slideUp().fadeOut();
					$("#route_way_no_mode_footer").slideUp().fadeOut();
					
					$("#route_way_add_mode_footer").slideUp().fadeIn();
					
					$("#route_way_add_mode_name").text(row_name).hide().fadeIn();	
									
					//removing previous listeners
					$("#route_way_add_mode_exit").off();
					$("#route_way_add_mode_exit").on('click', function(){
						
						//displaying confirm alert					
						$("#action_modal_exit_title").text("WARNING!!! ABORT OPERATION?");
						$("#action_modal_exit_content").text("Are you sure want to cancel the way add mode? Any added data, will be lost and can not be recovered. Please, Confirm.");
						$("#action_modal_exit").modal('show');
						
						$("#action_modal_exit_ok").off();
						$("#action_modal_exit_ok").on('click',function(){
							
							//clearing the map layers
							wayMarkersGroup.clearLayers();
							map_route_way.removeLayer(wayMarkersGroup);
							//resetting marker index
							markerIndex = 1;
							//remove onclick on the map so that marker will not added.
							map_route_way.off();
							
							is_route_way_add_available = true;
							//map_route_way.removeLayer(wayLine);	
							setRouteWayMapView(true, false);
							setDefaultRouteWayMapFooter();	
							
							$(route).parent().parent().css({"background-color":background_color});
							$(route).parent().find("span:nth-child(1)").css({color:"#212121","font-weight":"normal"});							
							$(route).parent().parent().focus();
						});
					});
					
					//adding listener to way list button. this will display the rew way list.
					$("#route_way_add_mode_way_list_button").off();
					$("#route_way_add_mode_way_list_button").on('click', function(){
						viewAddEditModeRawCoOrdinates($(this));
					});	

					//adding listener to add way button.
					$("#route_way_add_mode_add_button").off();
					$("#route_way_add_mode_add_button").on('click', function(){
						
						//i.e. routeway is already added. so row name is set to successfully added.
						if(($(route).parent().find("span:nth-child(1)").text())=="SUCCESSFULLY ADDED."){							
								//displaying no markers added message.							
								$("#alert_modal_title").text("WARNING!!! ROUTE WAY ALREADY ADDED");
								$("#alert_modal_content").text(" Cannot save the current operation. The route way is already added and you can find it in ADDED list panel. Please, exit the ADD MODE. !!!");
								$("#alert_modal").modal('show');
						}
						//if not already added then add route.
						else{		
							//if the map is not empty then only save markers
							if (wayMarkersGroup.getLayers().length!=0){														
								//add the route data
								
								//setting the row name progress in the same row cell replacing the route name.
								$(route).parent().find("span:nth-child(1)").text("ADDING WAY...");
								if(addRouteWayData(row_name)==true){
									//deleting the row from not added list and adding to added list

									//is_route_way_add_available=true;		//setting the add option available so that other can be easily added without exiting the current one. since, already added, there is issue of data lost if other route add displayed without notification.
									setTimeout(function(){					
										shiftRowToAddedList(route, row_name);
									},3000);							
									
									//diable the exit prompt 
									//removing previous listeners
									$("#route_way_add_mode_exit").off();
									$("#route_way_add_mode_exit").on('click', function(){
										//clearing the map layers
										wayMarkersGroup.clearLayers();
										//resetting marker index
										markerIndex = 1;
																				
										$("#loading_2").fadeIn();
										
										setTimeout(function(){
											$("#loading_2").fadeOut();
										},1000);
										//remove onclick on the map so that marker will not added.
										map_route_way.off();
										
										is_route_way_add_available = true;
										//map_route_way.removeLayer(wayLine);	
										setRouteWayMapView(true, false);
										setDefaultRouteWayMapFooter();										
									});
								}
								//if server return error  display message.
								else{							
									//setting the default row name
									$(route).parent().find("span:nth-child(1)").text(row_name);									
												
									$("#alert_modal_title").text("WARNING!!! ERROR OCCURED");
									$("#alert_modal_content").text(" Cannot add the route way at the moment. Please, try again later.");
									$("#alert_modal").modal('show');
								}
							}
							else{
								//displaying no markers added message.							
								$("#alert_modal_title").text("WARNING!!! NO MARKER ADDED");
								$("#alert_modal_content").text(" Cannot save the current operation. No markers are added in the map. Please, add markers on map and then click save. Try again!!!");
								$("#alert_modal").modal('show');
							}
						}
					});			
				
					//enabling map works
					enableMarkerAddingInMap();	
				}
			}
			
			//this function shifts the row to added list when route way add is successful.
			function shiftRowToAddedList(row, row_name){								
				$(row).parent().find("span:nth-child(1)").text("SUCCESSFULLY ADDED.");
				$(row).parent().find("span:nth-child(1)").css({color:"green","font-weight":"bold","font-size":"12px"});
				setTimeout(function(){	
					$(row).parent().parent().focus();				
					$(row).parent().parent().fadeOut(300, function(){
						$(this).remove();
						if($("#display_not_added_route_way_table tbody").children().length==0){
							$("#display_route_way_not_added_table_not_available").fadeIn();
						}
						});
					},3000);
					
				var i = $("#display_added_route_way_table tbody").children().length;
				
				//Adding the row to the ADDED Table
				$("#display_added_route_way_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td width="90%" style="padding-left:24px"><span>'+row_name +'</span><span style="float:right;background:url(${actionLoadingIcon});display:none; margin-right:24px; height:24px;width:24px;background-size: 24px 24px;background-repeat: no-repeat;"></span><span style="float:right;"><a style="float:right" onclick="displayOptionMenu(this)"><span style="margin-right:8px;cursor:pointer" class="glyphicon glyphicon-option-horizontal"></span></a><a style="display:none; float:right" onclick="hideOptionMenu(this)"><span style="margin-right:8px;cursor:pointer" class="glyphicon glyphicon-option-vertical"></span></a><br><div style="display:none; height:24px; width:100%; margin-top:4px; margin-bottom:-8px"><span style="margin-right:12px;margin-left:6px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="View Way" class="glyphicon glyphicon-globe" onclick="displayRouteWay(this)"></span><span <span style="width:18px" data-placement="top" data-toggle="tooltip"  title="View RawList"><span style="margin-right:12px; cursor:pointer; float:left" class="glyphicon glyphicon-file" onclick="viewRawCoOrdinates(this)"></span></span><span style="margin-right:12px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Edit Way" class="glyphicon glyphicon-edit" onclick="openEditRouteWay(this)"></span><span style=" margin-right:8px; cursor:pointer; float:left" data-toggle="tooltip" data-placement="top" title="Delete Way" class="glyphicon glyphicon-trash" onclick="deleteRouteWay(this)"></span></div></span></td></tr>').fadeIn();
				
				$("#display_added_route_way_table tbody tr:last").focus().css({color:"#673AB7"});
			}
			
			
			//this variable holds the marker object collection.
			//wayMarkers = [];
			var wayMarkersGroup = L.layerGroup();		//holds all marker in the map
			
			//this function enable map route way adding
			function enableMarkerAddingInMap(){
				//adding the marker group in the map
				map_route_way.addLayer(wayMarkersGroup);
				
				map_route_way.on('click', function(e) {	
					//alert(e.latlng);
					map_route_way.invalidateSize();
					
					//longitude and latitude variable 
					var lng = e.latlng.lng.toFixed(6);		//tofixed() to round to 6 decimal.
					var lat = e.latlng.lat.toFixed(6);	
							
					//var marker+markerIndex;
					
					addMarkerInMap(wayMarkersGroup, lat, lng);		
				});
			}
			
			
			//marker index number, this is outside, because this need to be read when adding another marker so that another marker id will be higher that this.
			var markerIndex = 1;
			//this function add the marker in the map 
			function addMarkerInMap(markersGroup, lat, lng){
				markersGroup.addLayer(L.marker([lat,lng], 
					{
						draggable:true,
						icon: L.AwesomeMarkers.icon(
							{
								icon: '',
								prefix: 'fa',
								markerColor: 'green',
								html:(markerIndex)
							}
						)
					}) 
					//.bindPopup(this.options.index)
					//.openPopup()
					.on('click', function(e){  //using click in order to avoid click on map and add other marker during double click.
						//alert(this.options.index);
						
						this.on('dblclick', function(e){
							//getting the marker number.
							//alert(this.options.icon.options.html);
							markersGroup.removeLayer(this);	
					
							//re-ordering the marker numbers.
							var i = 1;
							wayMarkersGroup.eachLayer(function (layer) {
								//alert(i);
								layer.setIcon(L.AwesomeMarkers.icon(
									{
										icon: '',
										prefix: 'fa',
										markerColor: 'green',
										html:(i++)
									}
								))
							});						
							markerIndex = i;	
						
						
						})
					}).on('dragend',function(){
						this.bindPopup('Node: '+this.options.icon.options.html+', Longitude: '+this.getLatLng().lng.toFixed(6)+', Latitude: '+this.getLatLng().lat.toFixed(6));					
					})			
				);
				
				//ADDING TO THE COLLECTION
				//wayMarkers.push(marker);					
				
				//CONFUSION WHY THE WAYMARKERS MARKER LATLNG IS UPDATED AUTOMATICALLY ON DRAGGING?
				
				markerIndex++;
				
				//adding the pop content				
				markersGroup.eachLayer(function (layer) {
					//alert(layer.options.index);
					layer.bindPopup('Node: '+layer.options.icon.options.html+', Longitude: '+layer.getLatLng().lng.toFixed(6)+', Latitude: '+layer.getLatLng().lat.toFixed(6));
				});
			}
			
				
			
			
			//this function displays the raw co-ordinates of the selected row route.
			function viewAddEditModeRawCoOrdinates(button){
				//get this row name i.e. route name and get the data from server.
				
				$(button).popover({
					tabindex:'1',
					role:'button',
					placement: 'left',
					toggle : "popover",
					html:true,
					content : getAllMarkerLatLng().join(',\n'),
					title: '<span class="text-info"><strong style="margin-right:32px">RAW CO-ORDINATES</strong></span>'+
					'<span class="glyphicon glyphicon-text-width" data-toggle="tooltip" data-placement="top" title="Rich View" style="cursor:pointer; margin-left:18px" onclick="formatAddRouteRawData(this)"></span>'+
					'<button type="button" id="close" class="close" style="margin-top:-2px" onclick="closePopover(this)">&times;</button>'+
					'<br><small style="font-size:11.5px; text-align:justify">You can also insert co-ordinates manually or make changes in below editor. Note: This will also change the map marker position.<br><span style="color:green">Format: LatLng(latitude, longitude)</span></small>',
					container: 'body',
					template: '<div class="popover popover-large" style="width:400px;height:618px;"><div class="arrow"></div><div class="popover-inner" style="margin-bottom:20px"><h3 class="popover-title"></h3><div style="overflow-x:hidden;overflow-y:auto; word-wrap: break-word; text-align:justify; font-size:12px; height:580px"><textarea id="add_route_raw_data_popover_textarea" class="popover-content" style="width:100%;height:472px"></textarea><button  type="button" class="btn btn-sm" style="background:none; color:#424242; border:1px solid #9E9E9E; padding:0px; height:24px;width:86px; margin-right:6px;float:right" onclick="saveRawData(this)"><span class="glyphicon glyphicon-floppy-disk"></span> SAVE</button><p id="add_route_raw_data_popover_success_msg" style="color:green;font-weight:bold; margin-right:12px; margin-top:8px; float:right; display:none">Save Successful.</p><p id="add_route_raw_data_popover_error_msg" style="color:red;font-weight:bold; margin-right:12px; margin-top:8px; float:right; display:none">Error in Format!!!</p></div></div></div>',
				});
				$(button).popover('show');
			}
			
			//this function get all marker lat and lng from the map
			function getAllMarkerLatLng(){
				var rawLatLng=[];
				wayMarkersGroup.eachLayer(function (layer) {
					rawLatLng.push(layer.getLatLng());
				});
				return rawLatLng;
			}
			
			
			//this function wrap the raw data in add mode popover
			function wrapData(data){
				
			}
			
						
			//this function format the raw data in add route way popover.
			function formatAddRouteRawData(textArea){
				var rawText = $(textArea).parent().parent().find("textarea").val();
				rawText = rawText.replace(/latlng/ig,"LatLng");
				//alert(rawText);				
				rawText = rawText.replace(/\n/g,"");		//removing all new lines
				
				rawText = rawText.replace(/\),|\)/g,")-");		//replacing , with - so that lat long comma remain.
				
				//the above regex will also add - in the last of the string so removing it also.
				rawText = rawText.replace(/-$/, "");
				//alert(rawText);
				//rawText = rawText.replace(/\)\n|\)/g,")-");		//replacing ) with )- so that lat long comma remain so that each latlong not separated with comma can also be separated.
				//alert(rawText);
				rawText = rawText.replace(/\),latlng/ig,")-LatLng");		//now replacing the )- with - so that each latlng can be separated. (using - since , is already present between lat and lng.)
				//alert(rawText);
				rawText = rawText.replace(/ /ig,"");//REMOVING SPACE
				//alert(rawText);
				rawText = rawText.replace(/,/ig,", "); //now adding space in lat lng comma
				//alert(rawText);
				var rawLatLngArray = rawText.split("-");
				$(textArea).parent().parent().find("textarea").val(rawLatLngArray.join(',\n'));
			}
			
			

			function saveRawData(data){
				//formatting the data
				//formatAddRouteRawData($(data).parent().find("textarea"));		
				var rawText = "";
				rawText= $(data).parent().find("textarea").val();
				//alert(rawText);
				
				//Re-formatting the data.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				rawText = rawText.replace(/latlng/ig,"LatLng");
				//alert(rawText);
				rawText = rawText.replace(/\n/g,"");		//removing all new lines
				
				rawText = rawText.replace(/\),|\)/g,")-");		//replacing , with - so that lat long comma remain.
				
				//the above regex will also add - in the last of the string so removing it also.
				rawText = rawText.replace(/-$/, "");
				//alert(rawText);
				//rawText = rawText.replace(/\)\n|\)/g,")-");		//replacing ) with )- so that lat long comma remain so that each latlong not separated with comma can also be separated.
				//alert(rawText);
				rawText = rawText.replace(/\),latlng/ig,")-LatLng");		//now replacing the )- with - so that each latlng can be separated. (using - since , is already present between lat and lng.)
				//alert(rawText);
				rawText = rawText.replace(/ /ig,"");//REMOVING SPACE
				//alert(rawText);
				rawText = rawText.replace(/,/ig,", "); //now adding space in lat lng comma
				//alert(rawText);
				var rawLatLngArray = [];
				rawLatLngArray = rawText.split("-");
				//alert(rawLatLngArray[0]);
				//alert(rawLatLngArray.length);
				
				//adding formatted data to textarea again 
				$(data).parent().find("textarea").val(rawLatLngArray.join(',\n'));	
				
				//alert(rawLatLngArray.length);										
				//var rawLatLngArray = $(data).parent().find("textarea").val().split(",");
				
				//alert(rawLatLngArray.split(","));
				for(i=0;i<rawLatLngArray.length;i++){					
					var match = rawLatLngArray[i].match(/LatLng\([0-9]{2}\.[0-9]{1,9}, [0-9]{2}.[0-9]{1,9}\)/);
					
					//if there is error in the raw data
					if(match!=rawLatLngArray[i]){
						//displaying message
						//alert("error: "+rawLatLngArray[i]);
						$(data).parent().find("p:last").fadeIn().show();
						setTimeout(function(){							
							$(data).parent().find("p:last").fadeOut();
						},5000);
						
						
						var tarea = $(data).parent().find("textarea");
						//highlighting the text area.
						//selectTextareaLine(tarea, i);
						
						var start = (tarea.val()).indexOf(rawLatLngArray[i]);   
						//alert(start);
						var end = start+rawLatLngArray[i].length;
												
						document.getElementById("add_route_raw_data_popover_textarea").selectionStart = start;
						document.getElementById("add_route_raw_data_popover_textarea").selectionEnd = end;
					    document.getElementById("add_route_raw_data_popover_textarea").focus();
					   //document.getElementById("add_route_raw_data_popover_textarea").val("Sdfdsfdsfdsfsfsdfdsf");
					   
					   //##############################QUESTION###################################################
					   //In the opoover textbox, the tarea variable textbox will not select the text on selectionStart or selectionEnd.
					   //However direct id like above will work.
					   
					   //WORKs
					   //document.getElementById("add_route_raw_data_popover_textarea").selectionStart = 5;
						//document.getElementById("add_route_raw_data_popover_textarea").selectionEnd = 6;
						
						//NOT WORKs
					   //tarea.selectionStart = 5;
						//tarea.selectionEnd = 6;
						
						//SAME IS THE CASE FOR .val() to set text in text area but opposite. i.e. work with tarea but not document.getelement by id.
												
						//	tarea.selectionStart = 1;
						//	tarea.selectionEnd = 2;
						//tarea.focus();
						
						// do selection
						// Chrome / Firefox
						/*if(typeof(tarea.selectionStart) != "undefined") {
								alert("mozi: "+tarea.selectionStart);
								tarea.selectionStart = start;
								tarea.selectionEnd = end;
								tarea.select(start, end);
								tarea.focus();
								
						//		return true;
						//	}*/

						// Text highlighting for IE
						 if (document.selection && document.selection.createRange) {
							//alert("win");
							document.getElementById("add_route_raw_data_popover_textarea").focus();
							document.getElementById("add_route_raw_data_popover_textarea").select();
							var range = document.selection.createRange();
							range.collapse(true);
							range.moveEnd("character", 2);
							range.moveStart("character", 6);
							range.select();
							return true;
						}
						break;
					}
					//if no error then save.
					else{
						//if all data are correct then save data.
						if(i==rawLatLngArray.length-1){
							
							//displaying message.
							$(data).parent().find("p:first").fadeIn().show();
							setTimeout(function(){							
								$(data).parent().find("p:last").fadeOut();
							},2000);
							
							//updating the data to the marker.
							//removing existing marker.
							wayMarkersGroup.clearLayers();
							
							//resetting marker index
							markerIndex = 1;
							//creating the latlng object
							for(var j=0;j<rawLatLngArray.length;j++){
								//alert(rawLatLngArray.length);
								//Format LatLng(55.5555,55.5555)
								var latlng = rawLatLngArray[j].replace("LatLng","");	//(55.5555,55.5555)
								latlng = latlng.replace("(","");	////55.5555,55.5555)
								latlng = latlng.replace(")","");	//55.5555,55.5555
								
								
								var latLngArr = latlng.split(",");
								var lat = latLngArr[0];
								var lng = latLngArr[1];
								//alert(lat+","+lng);
								//now adding marker
								addMarkerInMap(wayMarkersGroup, lat, lng);
							}							
						}
					}
				}			
			}
			


		/// debugging code
		//var sel = document.getElementById('lineSelector');
		//var tarea = document.getElementById('tarea');
		//sel.onchange = function() {
		//	selectTextareaLine(tarea,this.value);
		//}
			
			
		
			
			//this function add the route way data to the server.
			function addRouteWayData(route_name){				
				$("#loading_2").fadeIn();
				//disabling the add button
				$("#route_way_add_mode_add_button").prop('disabled',true);
				var markers = wayMarkersGroup.getLayers();
				var markerLatLngObjects = [];

				//getting the long lat from the all marker and adding it to the collectin
				jQuery.each(markers, function(i, marker){
					var node = marker.options.icon.options.html;	//getting node id
					var lat = marker.getLatLng().lat;
					var lng = marker.getLatLng().lng;
					var marker = {node:node,latitude:lat,longitude:lng};  //creating marker JSON object.
					markerLatLngObjects.push(marker);				
				});
				
				var routeWay = {name:route_name, wayLine:markerLatLngObjects};		//creating a route object.
				//var str = JSON.stringify(routeWay);
				//###########################################################################
				//				SERVER CODE 
				
				//alert(JSON.stringify(routeWay));
				var serverStatus = addRouteWayToServer(routeWay);
				
				
				
				
				
				
				//##############################################################################
				
				if(serverStatus==true){					
					setTimeout(function(){					
						$("#route_way_add_mode_add_button").prop('disabled',false);
						$("#loading_2").fadeOut();
						//alert(str);
						
					//alert(JSON.stringify(routeWaysCollection));
						//adding the added routeWay object in the all route way collection so that it can viewed from clicking view route way button in added Routeway section's route row option menu.
						routeWaysCollection.push(routeWay);
						
					//alert(JSON.stringify(routeWaysCollection));
						
					},3000);
					return true;
				}
				else{				
					$("#route_way_add_mode_add_button").prop('disabled',false);
					$("#loading_2").fadeOut();
					return false;
				}
			}
			
			
			//this function displays the raw co-ordinates of the selected row route.
			function viewRawCoOrdinates(route){
				//get this row name i.e. route name and get the data from server.
				
				var row_name = $(route).parent().parent().parent().parent().parent().find("td:nth-child(2) span:nth-child(1)").text();
				//alert(row_name);				
				$(route).popover({
					tabindex:'1',
					role:'button',
					trigger: "click | focus", 
					placement: 'right',
					toggle : "popover",
					html:true,
					content : getRouteWayData(routeWaysCollection, row_name).join(","),
					title: '<span class="text-info"><strong>RAW CO-ORDINATES</strong></span>'+
					'<span class="glyphicon glyphicon-repeat" data-toggle="tooltip" data-placement="top" title="Original" style="cursor:pointer; margin-left:20px" onclick="viewOriginalRawData(this)"></span>'+
					'<span class="glyphicon glyphicon-text-width" data-toggle="tooltip" data-placement="top" title="Rich View" style="cursor:pointer; margin-left:12px" onclick="viewFormattedRawData(this)"></span>'+
					'<button type="button" id="close" class="close" style="margin-top:-2px" onclick="closePopover(this)">&times;</button>',
					container: 'body',
					template: '<div class="popover popover-large" style="z-index:10000; margin-top:48px;width:420px;height:640px"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content" style="overflow-x:hidden;overflow-y:auto; word-wrap: break-word; text-align:justify; font-size:12px; height:600px; padding:0px">  </div></div></div>',
				});
				$(route).popover('show');
			}
			
				
			//this function close raw co-ordinates popover
			function closePopover(button){
				$(button).parent().parent().parent().popover('hide');
				$(button).parent().parent().parent().popover('destroy');
			}
			
			
			//this variable holds the raw data before formatting.
			var rawDataBeforeFormat;
			function viewFormattedRawData(view){
				//$(view).parent().parent().find("div").append("asdsfd<br>as");
				//checking if the table to display formatted data is present or not then create table.
				//if else for: user might click on button even after displaying table mode so avoid display even after displaying table mode.
				if($(view).parent().parent().find("div").find("table").length==0){
					
					$(view).parent().parent().find("div").hide();
					
					var arr = [];
					//getting the data from original data
					arr = $(view).parent().parent().find("div").text().split(",");	
					
					//backing up original before dleting
					rawDataBeforeFormat = $(view).parent().parent().find("div").text();
					//deleting original data
					$(view).parent().parent().find("div").empty();
					//now creating table to display that data.
					$(view).parent().parent().find("div").html('<table class="table table-condensed table-striped table-bordered"><thead><tr><th width="10%">NODE</th><th width="45%">LONGITUDE</th><th width="45%">LATITUDE</th></tr></thead><tbody></tbody></table>');
					var j = 0;
					//alert(arr.length);tr
					for(var i=0;i<arr.length;i=i+2){
					//alert("S");
						//$(view).parent().parent().find("div table tbody").append('Node: '+parseInt(j+1)+' [Lng: '+arr[i+1]+', Lat:'+arr[i]+']<br>');
						$(view).parent().parent().find("div table tbody").append('<tr><td>'+parseInt(j+1)+'</td><td>'+arr[i+1]+'</td><td>'+arr[i]+'</td></tr>');
						j++;
						//alert(j+i);		
					}					
					$(view).parent().parent().find("div").fadeIn();
				}
				else{								
					$(view).parent().parent().find("div").hide();
					$(view).parent().parent().find("div").fadeIn();
				}
				
				//$(view).parent().parent().find("div").text("asdsfd");
				//$(view).parent().parent().remove();
				    //var popover = $(view).parent().parent().parent().data('bs.popover');
					//popover.options.content = "YOUR NEW TEXT";
	
				//var data = [];
				//data =$(view).parent().parent().find("div").text().split(',');
				
				//alert(data);
				/*var collection = [];
				var j =0;
				jQuery.each(data, function(i, val){
				alert()
					collection[j][0]=data[i];
					collection[j][1]=data[i+1];
					i=i+2;
					j=j+1;
				});
				alert(collection);
				jQuery.each(collection, function(i, val){
					$(view).parent().parent().find("div").append('Node: '+parseInt(i+1)+', Longitude: '+val[1].toFixed(5)+', Latitude:'+val[0].toFixed(5)+'<br>');
				});	*/	
			}
			
			function viewOriginalRawData(view){
								
				//$(view).parent().parent().find("div").append("asdsfd<br>as");
				if($(view).parent().parent().find("div").find("table").length!=0 && rawDataBeforeFormat!=null){
					
					$(view).parent().parent().find("div").hide();
					$(view).parent().parent().find("div").text(rawDataBeforeFormat);
					$(view).parent().parent().find("div").fadeIn();
				}
				else{								
					$(view).parent().parent().find("div").hide();
					$(view).parent().parent().find("div").fadeIn();
				}
			}

	
			//initializing and creating map object for add bus stop 
				var map_route_way;
				function initializeMap(){
					map_route_way =new L.Map("route_way_map", {
						layers: [new L.tileLayer('http://localhost:8080/1.0.0/osm/{z}/{x}/{y}.png',{tms: true, attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'})]	
					});	
					map_route_way.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.
					displayResetButtonInMap();
				}
				initializeMap();
				
				
			
			//this function initialize map buttons for edit or add mode map--
			function displayResetButtonInMap(){
				var resetButton;
				
				resetButton = L.easyButton( 'glyphicon-repeat', function(){
					
					//var formatMarkerIndexButton;
					if(is_route_way_add_available!=true || is_route_way_edit_available!=true){
						//displaying confirm alert					
						$("#action_modal_exit_title").text("WARNING!!! CLEAR MAP?");
						$("#action_modal_exit_content").text("Are you sure want to remove all the markers from map? All added markers will be lost and can not be recovered. Please, Confirm.");
						$("#action_modal_exit").modal('show');
						
						$("#action_modal_exit_ok").off();
						$("#action_modal_exit_ok").on('click',function(){							
							//removing all the markers in the map
							wayMarkersGroup.clearLayers();	
							markerIndex = 1;//resetting teh index
						});
					}	
					else{
						map_route_way.removeLayer(wayLine);	
					}
					
					
				});
				resetButton.addTo(map_route_way);		
				
					
					/*formatMarkerIndexButton = L.easyButton( 'glyphicon-sort-by-order', function(){					
						//revalidate Marker index
						var i = 1;
						wayMarkersGroup.eachLayer(function (layer) {
							alert(i);
							layer.setIcon(L.AwesomeMarkers.icon(
								{
									icon: '',
									prefix: 'fa',
									markerColor: 'green',
									html:(i++)
								}
							))
						});						
						markerIndex = i;					
						//map_route_way.addLayer(easyButton);
					});	*/				
					
					//map_route_way.addLayer(resetButton);
					//map_route_way.addLayer(formatMarkerIndexButton);
					//formatMarkerIndexButton.addTo(map_route_way);
				};
				

				//this variable is used to display loading animation only when tab is opened for first time.
				var is_tab_loading_first_time = true;
				
				//Codes will execute only when bus stop tab is opened.
				$("body").on("shown.bs.tab", "#route_way_tab_header", function() {
				
					//hiding upper right control buttons.
					disableAddEditDeleteButtons();
					
					//enabling the loading animation
					firstTimeTabLoadinAnimation();
				
					/*to avoid error Leaflet map not displayed properly inside tabbed panel using invalidateSize.
					answer: http://stackoverflow.com/questions/10762984/leaflet-map-not-displayed-properly-inside-tabbed-panel*/
								
					setTimeout(function(){map_route_way.invalidateSize()},50);	  //must use timeout otherwise not work. since loadBustDetail has timeout 600. must match.
					setTimeout(function(){map_route_way.invalidateSize()},500);
					setTimeout(function(){map_route_way.invalidateSize()},1000);
					//revalidating again.. in case if page is displayed from add.when there no bus details are available to display. map is directly displayed when adding new bus stop. in this case we need to lately validate the map. otherwise not displayed properly.
					setTimeout(function(){map_route_way.invalidateSize()},2000);
					
					//enabling the map									
					/*$("#route_way_map").hide();
					$("#route_way_map_loading").fadeIn();
					setTimeout(function(){						
					$("#route_way_map").fadeIn();					
					$("#route_way_map_loading").fadeOut();
					},1000);*/
				});
				
				$("body").on("hidden.bs.tab", "#route_way_tab_header", function() {
					//re enabling upper right control buttons.
					enableAddEditDeleteButtons();
				});
				
				//this function set and displays map default location. 
				function setRouteWayMapView(animate_option, reset_option){
					var default_position = [ 27.707011230127296,85.31444102525711];
					map_route_way.setView([default_position[0],default_position[1]], 13, {animate: animate_option, reset: reset_option});
					map_route_way.zoomIn(1, {animate: true});
				};
				
				setRouteWayMapView(true, true);		
	
	
			//#######################UPDATE ROUTE WAY###############################
				
			//this variable store boolean value for if any other route way is being edited when another route edit, add, view etc.  button is clicked.
			//initially add is available therefore, true.
			var is_route_way_edit_available = true;
	
			//Thia function add route way
			function openEditRouteWay(route){
				//showing add option for this route if other route way is not being added currently.
				if(is_route_way_add_available==false){					
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot open this route for edit at the moment. Route way ADD MODE is currently activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else if(is_route_way_edit_available==false){				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot edit the route way at the moment. Route way EDIT MODE is already activated. Please, finish the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else{
					
					//removing any previous wayline that is opened in view mode.
					if(wayLine!=null){
						map_route_way.removeLayer(wayLine);
					}
					
					//setting route add is unavailable
					is_route_way_edit_available = false;
					//getting row route name 				
					var row_name = $(route).parent().parent().parent().find("span:first").text();
					
					//alert(row_name);
									
					setRouteWayMapView(true, false);
					$("#route_way_edit_mode_footer").slideUp().fadeOut();
					$("#route_way_view_mode_footer").slideUp().fadeOut();
					$("#route_way_no_mode_footer").slideUp().fadeOut();
					
					$("#route_way_edit_mode_footer").slideUp().fadeIn();
					
					$("#route_way_edit_mode_name").text(row_name).hide().fadeIn();	
									
					//removing previous listeners
					$("#route_way_edit_mode_exit").off();
					$("#route_way_edit_mode_exit").on('click', function(){
						
						//displaying confirm alert					
						$("#action_modal_exit_title").text("WARNING!!! ABORT OPERATION?");
						$("#action_modal_exit_content").text("Are you sure want to cancel the current way edit mode? Any changed data, will be lost and can not be recovered. Please, Confirm.");
						$("#action_modal_exit").modal('show');
						
						$("#action_modal_exit_ok").off();
						$("#action_modal_exit_ok").on('click',function(){
							
							//clearing the map layers
							wayMarkersGroup.clearLayers();							
							//resetting the marker index
							markerIndex = 1;
							
							//remove onclick on the map so that marker will not added.
							map_route_way.off();
							
							is_route_way_edit_available = true;
							//map_route_way.removeLayer(wayLine);	
							setRouteWayMapView(true, false);
							setDefaultRouteWayMapFooter();	
						});
					});
					
					//adding listener to way list button.
					$("#route_way_edit_mode_way_list_button").off();
					$("#route_way_edit_mode_way_list_button").on('click', function(){
						viewAddEditModeRawCoOrdinates($(this));
					});	

					//adding listener to add way button.
					$("#route_way_update_mode_add_button").off();
					$("#route_way_update_mode_add_button").on('click', function(){
				
						//if the map is not empty then only save markers
						if (wayMarkersGroup.getLayers().length!=0){														
							//add the route data
							
							if(updateRouteWay(row_name)==true){
							
								//some delay while displaying success message.
								setTimeout(function(){									
									//displaying success message.
									$("#route_way_update_success_message").slideDown().fadeIn();
									setTimeout(function(){									
										$("#route_way_update_success_message").slideUp().fadeOut();
									},4000);
								},3000);
								
								//diable the exit prompt 
								//removing previous listeners while exiting since data is already updated.
								$("#route_way_edit_mode_exit").off();
								$("#route_way_edit_mode_exit").on('click', function(){
									//clearing the map layers
									wayMarkersGroup.clearLayers();													
									//resetting marker index
									markerIndex = 1;
									
									$("#loading_2").fadeIn();
									
									setTimeout(function(){
										$("#loading_2").fadeOut();
									},1000);
									//remove onclick on the map so that marker will not added.
									map_route_way.off();
									
									is_route_way_edit_available = true;
									//map_route_way.removeLayer(wayLine);	
									setRouteWayMapView(true, false);
									setDefaultRouteWayMapFooter();										
								});
							}
							//if server return error  display message.
							else{																		
								//$("#alert_modal_title").text("WARNING!!! ERROR OCCURED");
								//$("#alert_modal_content").text(" Cannot add the route way at the moment. Please, try again later.");
								//$("#alert_modal").modal('show');
								
								//displaying success message.
								$("#route_way_update_failed_message").slideDown().fadeIn();
								setTimeout(function(){									
									$("#route_way_update_failed_message").slideUp().fadeOut();
								},4000);								
							}
						}
						else{
							//displaying no markers added message.							
							$("#alert_modal_title").text("WARNING!!! NO MARKER ADDED");
							$("#alert_modal_content").text(" Cannot save the current operation. No markers are added form the route. Please, add markers on map and then click save. Try again!!!");
							$("#alert_modal").modal('show');
						}
						
					});	
					
					//displaying loading animation first
					//$("#route_way_map").hide();
					$("#loading_2").fadeIn();
					setTimeout(function(){
						$("#loading_2").fadeOut(200);					
						//$("#route_way_map").show();
						//enabling marker adding in the map
						enableMarkerAddingInMap();	
						//alert("apple");
						//getting latlng of this route and setting marker to the map.
						setRouteWayMarkerInMap(row_name);
					},900);
				}
			}
			
			
			//this function sets the all the latlng of route as marker in the map in update mode.
			function setRouteWayMarkerInMap(route_name){
				//alert("SDFsfdsfs");
				var collection;
				//wayline from the route way collection
				jQuery.each(routeWaysCollection, function(i, routeWay){
					if(routeWay.name==route_name){
						//alert(routeWay.name);
						collection = jQuery.extend(true, {}, routeWay.wayLine);
						//collection = routeWay[i].wayLine;
						return false;
					}						
				});	
				
				//alert("fsfdsf:"+JSON.stringify(collection));
				//iterating through collection and adding the marker inmap
				jQuery.each(collection, function(i, latlng){
					var lat = latlng.latitude;	
					var lng = latlng.longitude;	
					//alert(lat+lng);
					addMarkerInMap(wayMarkersGroup, lat, lng);
				});								
			}
	
			
					
			//this function update the route way data to the server.
			function updateRouteWay(route_name){				
				//loading animations
				$("#loading_2").fadeIn();
				//disabling the add button
				$("#route_way_update_mode_add_button").prop('disabled',true);
				var markers = wayMarkersGroup.getLayers();
				var markerLatLngObjects = [];
				
				//getting the long lat from the all marker and adding it to the collectin
					jQuery.each(markers, function(i, marker){
						var node = marker.options.icon.options.html;	//getting node id
						var lat = marker.getLatLng().lat;
						var lng = marker.getLatLng().lng;
						var marker = {node:node,latitude:lat,longitude:lng};  //creating marker JSON object.
						markerLatLngObjects.push(marker);				
					});
					
					var routeWay = {name:route_name, wayLine:markerLatLngObjects};		//creating a route object.
					//var json_routeWay = JSON.stringify(routeWay);
					
					//####################################################################################################
					//SERVER CODE
					
					var serverStatus = updateRouteWayToServer(routeWay);
					
					
					
					
					
					
					
					
				//#########################################################################################################
				
				if(serverStatus==true){
					setTimeout(function(){					
						$("#route_way_update_mode_add_button").prop('disabled',false);
						$("#loading_2").fadeOut();
					},3000);
					//for each route_way in collection if the route name is this edited routename then replace.
					jQuery.each(routeWaysCollection, function(i, collection){
						if(collection.name==route_name){
							//collection.splice();
							routeWaysCollection[i] = routeWay;		//replacing with updated route way.
							return false;
						}						
					});
					return true;				
				}
				else{						
					$("#route_way_update_mode_add_button").prop('disabled',false);
					$("#loading_2").fadeOut();
					return false;
				}	
			}
			
			
			//This function is triggered from option menu view Way. displays the way of the route on map.
			function deleteRouteWay(route){	
				//showing add option for this route if other route way is not being added currently.
				if(is_route_way_add_available==false){					
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot delete the route way at the moment. Route way ADD MODE is currently activated. Please, exit the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else if(is_route_way_edit_available==false){				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot delete the route way at the moment. Route way EDIT MODE is currently activated. Please, exit the current operation and try again.");
					$("#alert_modal").modal('show');
				}
				else{				
					var row_name = $(route).parent().parent().parent().find("span:first").text();					
					
					//displaying confirm alert					
					$("#action_modal_exit_title").text("WARNING!!! DELETE ROUTE WAY?");
					$("#action_modal_exit_content").text("Are you sure want to delete "+row_name.toUpperCase()+"'s route way? Once deleted it can not be recovered. Please, Confirm.");
					$("#action_modal_exit").modal('show');
					
					$("#action_modal_exit_ok").off();
					$("#action_modal_exit_ok").on('click',function(){
						//delete codes		
						//displaying being deleted text.					
						$(route).parent().parent().parent().find("span:first").text("DELETING...").css({"font-size":"12px","font-weight":"bold","color":"#673AB7"});
						
						//hiding option menu
						$(route).parent().parent().parent().parent().find("td:last span:nth-child(3)").fadeOut();
						//enabling loading animation
						$(route).parent().parent().parent().parent().find("td:last span:nth-child(2)").fadeIn();	
						
						
						//server remove code here
						//####################################################################################
						var serverStatus = deleteRouteWayToServer(row_name);
						
						
						
						
						
						//####################################################################################
						
						
						
						if(serverStatus==true){
							//deleting from the local array
							//alert("before delete routewaycollection count: "+routeWaysCollection.length);
							jQuery.each(routeWaysCollection, function(i, routeWay){
								if(routeWay.name==row_name){
									routeWaysCollection.splice(i,1);			//deleting the routeWay Object from the collection./local array
									return false;
								}						
							});
							
							//alert("After delete routewaycollection count: "+routeWaysCollection.length);	
							setTimeout(function(){
								shiftRowToNotAddedList($(route).parent().parent().parent().parent(), row_name);
							},3000);
						}				
					});
				}
			}
			
			
			//this function shifts the row to added list when route way add is successful.
			function shiftRowToNotAddedList(row, row_name){								
				$(row).find("td:last span:nth-child(1)").text("SUCCESSFULLY DELETED.").css({"font-size":"13px","font-weight":"bold","color":"red"});
				$(row).find("td:last span:nth-child(2)").hide();		//removing the loading animation
								
				setTimeout(function(){	
					$(row).focus();				
					$(row).fadeOut(500, function(){
						$(this).remove();
						if($("#display_added_route_way_table tbody").children().length==0){
							$("#display_route_way_added_table_not_available").fadeIn();
						}
					});
				
					var i = $("#display_not_added_route_way_table tbody").children().length;						
					//Adding the row to the NOT ADDED Table				
					$("#display_not_added_route_way_table tbody").delay(200).append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td style="padding-left:24px"><span>'+row_name +'</span><span  style="float:right; margin-right:8px;cursor:pointer" class="glyphicon glyphicon-plus" onclick="openAddRouteWay(this)"></span></td></tr>').fadeIn();
					$("#display_not_added_route_way_table tbody tr:last").focus().css({color:"#673AB7"});
					
				},1000);
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			//#############################################################################################################################################
			
			//						STOPS DISTANCE SECTION
			
			//#############################################################################################################################################
					
					
					
			//sample data
			
			var route1 = {name:"Route 1", available:true, stops:[{distance:0, name:"Soyamnhu bus station1"},{distance:3, name:"Soyamnhu bus station2"},{distance:4, name:"Soyamnhu bus station3"},{distance:6, name:"Soyamnhu bus station4"},{distance:7, name:"Soyamnhu bus station5"},{distance:8, name:"Soyamnhu bus station6"},{distance:9, name:"Soyamnhu bus station7"},{distance:11, name:"Soyamnhu bus station8"}]};
			
			//distance not avaiable json example
			var route2 = {name:"Route 2", available:false, stops:[{distance:0, name:"Soyamnhu bus station1"},{distance:0, name:"Soyamnhu bus station2"},{distance:0, name:"Soyamnhu bus station3"},{distance:0, name:"Soyamnhu bus station4"}]};
			
			
			var stopsDistanceCollection =[];
			
			function loadStopsDistanceData(){
			
				//resetting the data.
				stopsDistanceCollection = [];
				//download code from server.
				stopsDistanceCollection.push(route1, route2);				
			}
			loadStopsDistanceData();
			
			
			
		
			
			//###########################################################################################################################################
			
			//SERVER CODE
			
			function updateStopsDistanceToServer(update_stops_distance){
			
				return true;
			}
			
			
			//############################################################################################################################################
			
			
			
			
			
					//Codes will execute only when stops distance tab is opened.
				$("body").on("shown.bs.tab", "#stops_distance_tab_header", function() {
				
					//hiding upper right control buttons.
					disableAddEditDeleteButtons();
					
					//loading data 
					loadStopsDistanceRouteToPage();
					
					//enabling the loading animation
					firstTimeTabLoadinAnimation();
					
				});
				
				$("body").on("hidden.bs.tab", "#stops_distance_tab_header", function() {
					//re enabling upper right control buttons.
					enableAddEditDeleteButtons();
				});
				
				
				//this function load route name in the left panel.
				
			
				
			
			//this function gets the loads the route names and display to the left panel
			function loadStopsDistanceRouteToPage(){
			
				if(routeCollection.length==0){
					$("#stops_distance_routes_not_available_msg").fadeIn();
					$("#stops_distance_route_table").hide();
				}
				//displaying the Added route way table on side panel
				else{
					$("#stops_distance_routes_not_available_msg").hide();
					$("#stops_distance_route_table").fadeIn();						
					jQuery.each(routeCollection, function(i, route){
						$("#stops_distance_route_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td tabindex="1" width="90%" style="padding-left:24px"><span>'+route.name +'</span><a><span style="margin-right:12px; cursor:pointer; float:right" data-toggle="tooltip" data-placement="top" title="Edit Stop Distance" class="glyphicon glyphicon-edit" onmouseover="displayTooltip(this)" onclick="displayStopDistanceEdit(this)"></span></a><a><span style="margin-right:12px; cursor:pointer; float:right" data-toggle="tooltip" data-placement="top" title="View Stop Distance" class="glyphicon glyphicon-folder-open" onmouseover="displayTooltip(this)" onclick="displayStopDistance(this)"></span></a></td></tr>');
					}); 
				}
			}
			
			
			//this funciton displays the route's stop distance on clicking the display button on the leftpanel route's option.
			function displayStopDistance(button){
				//resetting focus color of other rows.
				$("#stops_distance_route_table tbody").find("tr").each(function(){
					$(this).find("td").css({"color":"#424242","font-weight":"normal"});
				});
				
				//focusing the row.
				$(button).parent().parent().css({"color":"#673AB7","font-weight":"bold"});
				
				if(stopsDistanceEditModeStatus==true){										
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot view Stops distance of this route at the moment. Stops Distance edit mode is currently active. Please, exit the current edit mode and try again.");
					$("#alert_modal").modal('show');
				}
				else{
				
					var routeName = $(button).parent().parent().find("span:nth-child(1)").text();
					//getting the distance and bus stop detail from the downloaded distance array collection.
					//alert(JSON.stringify(stopsDistanceCollection));
					jQuery.each(stopsDistanceCollection, function(i, distance){
					//alert(routeName);
						if(distance.name==routeName){		
					//alert(routeName);				
							
							$("#stops_distance_distance_not_available_msg").hide();
							//adding the data in the table.
							if(distance.available==true){
								$("#stops_distance_right_panel_loading").fadeIn();
								setTimeout(function(){
									$("#stops_distance_distance_not_set_msg").hide();
									addDataToStopsDistanceTable(distance.stops);	
								$("#stops_distance_right_panel_loading").fadeOut();						
								},1200);
							}
							else{
								$("#stops_distance_right_panel_loading").fadeIn();
								setTimeout(function(){
									$("#stops_distance_distance_not_set_msg").fadeIn();
									addDataToStopsDistanceTable(distance.stops);	
								$("#stops_distance_right_panel_loading").fadeOut();						
								},1200);
							}
							return false;
						}				
					});	
				}
			}
			
			
			//this function opens the edit option 
			function displayStopDistanceEdit(button){
				//resetting focus color of other rows.
				$("#stops_distance_route_table tbody").find("tr").each(function(){
					$(this).find("td").css({"color":"#424242","font-weight":"normal"});
				});
				
				//focusing the row.
				$(button).parent().parent().css({"color":"#673AB7","font-weight":"bold"});
				
				if(stopsDistanceEditModeStatus==true){										
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! PENDING OPERATION");
					$("#alert_modal_content").text(" Cannot edit Stops distance of this route at the moment. Stops Distance edit mode is currently active. Please, exit the current edit mode and try again.");
					$("#alert_modal").modal('show');
				}
				else{
					$("#content_header_button_refresh").prop("disabled",true);	
					
					var routeName = $(button).parent().parent().find("span:nth-child(1)").text();
					//getting the distance and bus stop detail from the downloaded distance array collection.
					//alert(JSON.stringify(stopsDistanceCollection));
					jQuery.each(stopsDistanceCollection, function(i, distance){
					//alert(routeName);
						if(distance.name==routeName){		
					//alert(routeName);				
							
							$("#stops_distance_distance_not_available_msg").hide();
							//adding the data in the table to edit.
								$("#stops_distance_right_panel_loading").fadeIn();
								setTimeout(function(){
									$("#stops_distance_distance_not_set_msg").hide();
									addDataToStopsDistanceEditTable(distance.stops, routeName);
									$("#stops_distance_save_exit_buttons").fadeIn();
								$("#stops_distance_right_panel_loading").fadeOut();						
								},1200);
							
							return false;
						}				
					});	
				}
			}
			
			
			
			
			
			//this function add data to the stops distance table: stops distance and name.
			function addDataToStopsDistanceTable(data){
				//alert(JSON.stringify(data));
					$("#stops_distance_table tbody").empty();
				jQuery.each(data, function(i, val){
					$("#stops_distance_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td style="padding-left:24px">'+val.distance+" Km"+'</td><td style="padding-left:24px">'+val.name+'</td></tr>');
				}); 				
			}
				
				
				
				
			//this variable avoid opening view button during edit mode. 	
			var stopsDistanceEditModeStatus = false;
			
			//this variable holds current route name being edited. used to display the view only table after exitting from save mode.
			var currentStopsDistanceEditRoute = "";
			
			
			
				//this function add data to the stops distance table: stops distance and name. //edit option added.
			function addDataToStopsDistanceEditTable(data, routeName){
				stopsDistanceEditModeStatus = true;
				
				currentStopsDistanceEditRoute = routeName; 
				
				//alert(JSON.stringify(data));
					$("#stops_distance_table tbody").empty();
				jQuery.each(data, function(i, val){
					$("#stops_distance_table tbody").append('<tr tabindex="1"><td width="10%">'+parseInt(i+1)+'</td><td style="padding:0px"><input type="text" class="form-control" placeholder="Enter distance" aria-describedby="basic-addon1" style="height:24px; padding:0px;padding-left:8px" value="'+val.distance+'"></td><td style="padding-left:24px">'+val.name+'</td></tr>');
				}); 				
			}
			
			
			//this function saves stops distance add.
			function saveStopsDistance(){
				var toSaveRoute = [];
				
				//making save and exit button unclickable 
				
				$("#stops_distance_save_exit_buttons").css({"pointer-events":"none"});
				
				
				/*for(var i=1; i<=$("#stops_distance_table tbody").length;i++){
					//alert("table id: "+$("#stops_distance_table tbody").find("tr td:nth-child(2) input").val() + ", loop id:"+i);
					//if($("#stops_distance_table tbody").find("tr td:nth-child(1)").text()==i){
						toSaveRoute.push({distance:$("#stops_distance_table tbody").find("tr td:nth-child(2) input").val(), name:$("#stops_distance_table tbody").find("tr td:nth-child(3)").text()});
					//}
				}*/
				
				//getting the value from the table.
				$("#stops_distance_table tbody").find("tr").each(function(i, row){
					toSaveRoute.push({distance:$(row).find("td:nth-child(2) input").val(),name:$(row).find("td:nth-child(3)").text()});
				});
				
				/*for (var i = 0, row; row = $("#stops_distance_table tbody").rows[i]; i++) {
				   toSaveRoute.push({distance:row.cells[1],name:row.cells[2]}); 
				}*/				
				
				//alert(JSON.stringify(toSaveRoute));	

				toUpdateData = {name:currentStopsDistanceEditRoute, stops:toSaveRoute};	
				
				//now adding to server.
				$("#stops_distance_save_loading_icon").fadeIn();
				
				setTimeout(function(){
					
					//################################################################################################################
					
					
					var serverStatus = updateStopsDistanceToServer(toUpdateData);
					
					
					//################################################################################################################
					
					//alert(JSON.stringify(toUpdateData));
					
					if (serverStatus==true){
						$("#stops_distance_save_succes_message").slideDown().fadeIn();
						setTimeout(function(){
							$("#stops_distance_save_succes_message").slideUp().fadeOut();
						},4000);
						
						//saving to local array
						//alert(JSON.stringify(stopsDistanceCollection));
						
						jQuery.each(stopsDistanceCollection, function(i, val){
							if(val.name==currentStopsDistanceEditRoute){
								val.stops=toSaveRoute;
								val.available= true; //in case it is new add instead of update.
							}
						});
						
						
						//alert(JSON.stringify(stopsDistanceCollection));
						
					}
					else{
						$("#stops_distance_save_failed_message").slideDown().fadeIn();	
						setTimeout(function(){
							$("#stops_distance_save_failed_message").slideUp().fadeOut();	
						},4000);
					}					
					$("#stops_distance_save_loading_icon").fadeOut();
					$("#stops_distance_save_exit_buttons").css({"pointer-events":"auto"});
				},2000);
			}
			
			
			
			//this function cancel the stops distance add.
			function cancelStopsDistanceAdd(){
				stopsDistanceEditModeStatus = false;			
				$("#stops_distance_save_exit_buttons").hide();

				
					$("#content_header_button_refresh").prop("disabled", false);
					
				//now displaying the view only table with updated data.
					var routeName = currentStopsDistanceEditRoute;
					currentStopsDistanceEditRoute = "";
					//getting the distance and bus stop detail from the downloaded distance array collection.
					//alert(JSON.stringify(stopsDistanceCollection));
					jQuery.each(stopsDistanceCollection, function(i, distance){
					//alert(routeName);
						if(distance.name==routeName){		
					//alert(routeName);				
							
							$("#stops_distance_distance_not_available_msg").hide();
							//adding the data in the table.
							if(distance.available==true){
								$("#stops_distance_right_panel_loading").fadeIn();
								setTimeout(function(){
									$("#stops_distance_distance_not_set_msg").hide();
									addDataToStopsDistanceTable(distance.stops);	
								$("#stops_distance_right_panel_loading").fadeOut();						
								},1200);
							}
							else{
								$("#stops_distance_right_panel_loading").fadeIn();
								setTimeout(function(){
									$("#stops_distance_distance_not_set_msg").fadeIn();
									addDataToStopsDistanceTable(distance.stops);	
								$("#stops_distance_right_panel_loading").fadeOut();						
								},1200);
							}
							return false;
						}				
					});	
					
			}
			
			
			
			
			 
			  //this funciton display the tooltip on parameter componenet
			  function displayTooltip(component){
				$(component).tooltip('show');
			  }
			
			
			
			//####################################################################################################################
			//MISC FUNCTIONS
			
			//this function captalize the first letter.
			function capitalizeFirstLetter(string) {
				var words = string.split(" ");		//splitting with space.
				var string = "";
				for(var i=0; i<words.length;i++){
					words[i] = words[i].charAt(0).toUpperCase() + words[i].slice(1);
				}
				return words.toString().replace(/,/g," ");
			}
			
	  </script>
</body>
</html>
>
