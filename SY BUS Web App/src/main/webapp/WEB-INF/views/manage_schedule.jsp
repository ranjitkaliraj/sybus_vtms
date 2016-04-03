<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<spring:url value="resources/images/favicon.png" var="favicon" />

<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap-theme.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/css/dashboard.css" var="dashboardCss"/>

<spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
<spring:url value="resources/js/jquery-ui.min.js" var="jqueryUiJs"/>
<spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>

<spring:url value="resources/images/icon.png" var="titleIcon" />
<spring:url value="resources/images/Thin fading line.gif" var="loadingIcon" />
<spring:url value="resources/images/action.gif" var="actionLoadingIcon" />
<spring:url value="resources/images/Thin fading line.gif" var="loadingIcon" />


<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>SY Bus - Vehicle Tracking and Management System for Sajha Yatayat</title>
      <link rel="shortcut icon" type="image/png" href="${favicon}"/>
      <!-- Latest compiled and minified CSS -->
      <link href="${bootstrapCss}" rel="stylesheet">
      <!-- Optional theme -->
      <link href="${bootstrapThemeCss}" rel="stylesheet">
	  <!--css import for sidepanel dashboard-->
    <link href="${dashboardCss}" rel="stylesheet">	
	<style type="text/css">
	html,body{height:97.6%;	
    max-width: 100% !important;
    overflow: hidden;
	
	}
		::-webkit-scrollbar { 
			display: none; 		
		}
		
	#display_bus_stop_table tbody tr:hover {
    background-color: rgba(0,0,0,0.1)!important;
}
	</style>
   </head>
   <body>
      <header class="navbar-inverse navbar-fixed-top" role="banner" style="z-index:10000">
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
                        <span style="float:left;margin-right:8px;margin-left:0px"><img src="${titleIcon}" alt="icon" height="40" width="45"></span> 
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
                              <li><a id="target" href="#">Manage Schedules</a></li>
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
	  <div style="margin-top:8px; height:100%;width:100%">

      <div class="row" style="height:100%; width:auto">
        <div class="col-sm-2 col-md-2 sidebar" style="margin-bottom:40px;border-right:1px solid rgba(0,0,0,0.2)">
		<div style="margin:-22px">
			  <!--breachcrumb for sub-navigation info-->
				  <ol class="breadcrumb" style="margin-top:-8px">
			  <li><a href="home.html"style="color:#595959!important">Home</a></li>
			  <li><a href="manage.html"style="color:#595959!important">Manage</a></li>
			  <li class="active" >Schedule</li>
			</ol>

		</div>


          <ul class="nav nav-sidebar" style="padding:2px">
            <li><a style="color:#000; font-weight:bold;border-top:1px solid rgba(0,0,0,0.3)" href="manage.html">Overview <span class="sr-only">(current)</span></a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-route">MANAGE ROUTE</a></li>
            <li class="active"><a style="font-weight:bold; background:none;color:#000;border:1px solid #9E9E9E"href="#">MANAGE SCHEDULE</a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-vehicle">MANAGE VEHICLE</a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-fare">MANAGE FARE</a></li>
          </ul>
        </div>
		
		<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="margin-bottom:40px;height:100%; width:89%">
          <!--<h1 class="page-header" style="margin-top:-10px">Dashboard</h1>-->
		  <div style="margin-left:-42px;margin-right:-42px;margin-top:-20px; height:100%; width:100%">
		  <!-- Nav tabs -->
				  <!--enclosing this tab menu in container fluid so that there is certain padding and we also dont want to have padding in content e.g. map so exclusively defining only this div that wrap tab section only-->
				  <div id="tab_sections" class="container-fluid">
				  <ul class="nav nav-tabs" role="tablist">  
					<!--<li role="presentation"><a href="manage.html" style="height:36px;padding:8px; color:rgba(0,0,0,0.5)"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span> Back</a></li>-->
					<li role="presentation" class="active"><a id="schedule_tab_header" id="schedules" href="#schedules_tab" aria-controls="schedules_tab" role="tab" data-toggle="tab" style="height:36px; padding:8px">SCHEDULE</a></li>

					<!--add, edit and delete buttons-->
					<div class="btn-group" role="group" aria-label="..." style="float:right;margin-right:18px; margin-top:2px">
					  <button id="add_button" data-toggle="tooltip" data-placement="bottom" title="Add" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Add new Schedule Details"><span class="glyphicon glyphicon-plus"></span></button>
					  <button id="edit_button" data-toggle="tooltip" data-placement="bottom" title="Edit" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Edit and update existing Schedule Details"><span class="glyphicon glyphicon-edit"></span></button>
					  <button id="delete_button" data-toggle="tooltip" data-placement="bottom" title="Delete" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Delete all or particular Schedule Details"><span class="glyphicon glyphicon-trash"></span></button>
					</div>
					</ul>
					</div>
					
					
					<!-- Tab panes to display detail content-->
				<div id ="tab_pane" class="tab-content container-fluid" style="height:100%; width:100%">

								
				<!--title for the content pane for tab. which will be switched accordingly. also this div is fixed.-->
				<div class="page-header row-fluid" style=" height:32px;padding-left:18px;padding-right:18px; padding-bottom:0px; margin-bottom:0px; margin-top:-12px">
				<div id="content_header">
				  <h3><span style="color:#4CAF50" id="content_header_title">CURRENT SCHEDULES</span><small id="content_header_subtitle"> List of currently available schedules.</small>
					 

					 <!--Refresh Button-->
					  <button id="content_header_button_refresh" type="button" class="btn btn-sm"  style="display:nones; background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:24px;width:80px; margin-top:2px" onClick="refresh()">
					  <span id="content_header_icon_refresh" class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Refresh
					  </button>		
					  
					<!--Sort section-->
					<div id="sort_table" class="input-group" style="padding:0px;margin:0px; float:right; width:120px; margin-right:8px; margin-top:2px">
							<span class="input-group-addon" style="height:24px; padding:4px;margin:0px; font-weight:normal font-size:12px; background:none">Sort</span>
							  <select id="schedule_display_sort_table_dropdown" style="height:24px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list." onChange="sortTable()">
								<option value="1">Default</option>
								<option value="2">Vehicle</option>
								<option value="3">Route</option>
								<option value="4">Time</option>
							  </select>
							</div>
							
							<!--Filter section-->
					<div id="filter_table" class="input-group" style="padding:0px;margin:0px; float:right; width:120px; margin-right:8px; margin-top:2px">
							<span class="input-group-addon" style="height:24px; padding:4px;margin:0px; font-weight:normal font-size:12px; background:none">Filter</span>
							  <select id="schedule_display_filter_table_dropdown" style="height:24px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list." onChange="filterTable()">
								<option>Default</option>
								<!--<option>Route 1</option>
								<option>Route 2</option>
								<option>Route 3</option>-->
							  </select>
							</div>
									 
				<!--save and cancel button for edit/delete mode route edit mode-->			
				<button id="content_header_button_exit" type="button" class="btn btn-sm" style="display:none; float:right;margin-bottom:5px; background:none; border:1px solid #9E9E9E;height:28px;width:80px; margin-left:8px" onClick="">
				  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
				</button>
				<button id="content_header_button_save" type="button" class="btn btn-sm" style="display:none; float:right;margin-bottom:5px; background:none; border:1px solid #9E9E9E; height:28px;width:80px" onClick="">
				  <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> SAVE
				</button>	
				
				<!--saving loading animation-->
				<div id="content_header_loading_icon" data-toggle="tooltip" data-placement="bottom" title="Saving..." style="float:right; margin-top:-1px;margin-right:18px; display:none"><img src="${actionLoadingIcon}" height="24" width="24"></div>	
				
				
				  </h3>
				</div>
				</div>
				
				<!--add edit schedule section-->
				<div class="container-fluid" style="padding-left:48px; padding-right:48px; margin-top:12px">
				
					<!--Add new schedule status message section-->				
					<div id="add_schedule_submit_message_alert" class="alert in fade alert-success col-md-12" style="padding:12px; padding-left:18px;display:none; background:nosne; border:1px solid #BDBDBD; height:">
						<h3 style="color:#595959;"><span style="color:#4CAF50" id="add_schedule_submit_message_alert_title">ADD SUCCESSFUL.</span>
						<small id="add_schedule_submit_message_alert_details"> You have successfully added a new schedule details. </small>
						
							<button  id="schedule_add_success_exit" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:6px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">EXIT</button>
							
							<button  id="schedule_add_success_add_again" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:18px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">ADD NEW</button>
						</h3>
					</div>
										
						<!--no route or vehicle available error, duplicate add entry error message-->
						<div id="schedule_add_timeout_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong id="schedule_add_timeout_error_message_header">WARNING.</strong><small id="schedule_add_timeout_error_message_detail"> Cannot add the new Schedule at the moment. Currently, no Vehicles and Route information ara available to display.</small></div>
						
					<!--add new Schedule section-->
					<div id="schedule_add_edit_section" class="panel panel-default col-md-12" style="padding:0px;border:1px solid #BDBDBD;display:none; height:96px">		
					<div class="panel-heading" style="height:28px; padding:4px; text-align:center; background:none;background-color:#424242;color:#CCC">ADD NEW SCHEDULE</div>
					<div class="panel-body" style="padding:6px; margin-top:12px; font-size:12px">
						
						
						
						<div class="form-group row-fluid  col-md-3" style="padding:0px;padding-left:4px; padding-right:4px">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div  id="schedule_add_edit_select_route_dropdown_1"class="input-group" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="padding:0px;margin:0px; font-weight:normal font-size:12px; color:#000; padding:6px">ROUTE</span>
								  <select id="schedule_add_edit_select_route_dropdown" style="height:28px; font-size:12px; padding:0px; color:#000" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list.">
									<option>SELECT A ROUTE</option>
									<!--<option>Schedule 1</option>
									<option>Schedule 2</option>
									<option>Schedule 3</option>
									<option>Schedule 4</option>-->
								  </select>
								</div>
						</div>
						
						
						<div class="form-group row-fluid  col-md-3" style="padding:0px;padding-left:6px; padding-right:6px">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div id="schedule_add_edit_select_vehicle_dropdown_1" class="input-group" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="padding:0px;margin:0px; font-weight:normal font-size:12px; color:#000; padding:6px">VEHICLE</span>
								  <select id="schedule_add_edit_select_vehicle_dropdown" style="height:28px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list.">
									<option>SELECT A VEHICLE</option>
									<!--<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>
									<option>BA 10 PA 3477</option>-->
								  </select>
								</div>
						</div>
						
						<div class="form-group row-fluid  col-md-3" style="padding:0px;padding-left:4px; margin-right:-24px">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div class="input-group col-md-12" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="font-weight:normal; font-size:12px; width:60px; color:#000">TIME</span>
								  <select id="schedule_add_edit_select_hour_dropdown" class="col-md-5" style="float:left;height:28px; font-size:12px; padding:0px; color:#000" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list.">
									<option>HOUR</option>
									<option value="0 ">00</option>
									<option value="1 ">01</option>
									<option value="2 ">02</option>
									<option value="3 ">03</option>
									<option value="4 ">04</option>
									<option value="5 ">05</option>
									<option value="6 ">06</option>
									<option value="7 ">07</option>
									<option value="8 ">08</option>
									<option value="9 ">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
								  </select>
								  
								  <select id="schedule_add_edit_select_min_dropdown" class="col-md-5" style="float:left;height:28px; font-size:12px; padding:0px; color:#000" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list.">
									<option>MIN</option>
									<option value="0 ">00</option>
									<option value="1 ">01</option>
									<option value="2 ">02</option>
									<option value="3 ">03</option>
									<option value="4 ">04</option>
									<option value="5 ">05</option>
									<option value="6 ">06</option>
									<option value="7 ">07</option>
									<option value="8 ">08</option>
									<option value="9 ">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
									<option value="32">32</option>
									<option value="33">33</option>
									<option value="34">34</option>
									<option value="35">35</option>
									<option value="36">36</option>
									<option value="37">37</option>
									<option value="38">38</option>
									<option value="39">39</option>
									<option value="40">40</option>
									<option value="41">41</option>
									<option value="42">42</option>
									<option value="43">43</option>
									<option value="44">44</option>
									<option value="45">45</option>
									<option value="46">46</option>
									<option value="47">47</option>
									<option value="48">48</option>
									<option value="49">49</option>
									<option value="50">50</option>
									<option value="51">51</option>
									<option value="52">52</option>
									<option value="53">53</option>
									<option value="54">54</option>
									<option value="55">55</option>
									<option value="56">56</option>
									<option value="57">57</option>
									<option value="58">58</option>
									<option value="59">59</option>
								  </select>
								  
							</div>
						</div>
						
						<div class="form-group row-fluid  col-md-3" style="padding:0px;padding-left:6px">							
							<!--reset button-->
							<button id="schedule_add_edit_reset_button" type="button" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Reset" style="float:left; margin-right:24px; padding:4px; background:none; border:1px solid #9E9E9E; height:28px;width:28px" onClick="">
							  <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
							</button>
							
							
							<!--save and cancel button for edit/delete mode schedule edit mode-->			
							<button id="schedule_add_edit_exit_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; margin-right:-16px; background:none; border:1px solid #9E9E9E;height:28px;width:86px; margin-left:4px" onClick="">
							  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
							</button>
							
							<button id="schedule_add_edit_add_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; background:none; border:1px solid #9E9E9E; height:28px;width:86px" onClick="">
							  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <span id="schedule_add_edit_form_submit_button">UPDATE</span>
							</button>
							
							<!--submit animation logo-->
							<span id="schedule_add_edit_loading_icon" data-toggle="tooltip" data-placement="bottom" title="Loading..." style="display:none; float:right; margin-right:8px;margin-top:2px"><img src="${actionLoadingIcon}" height="24" width="24"></span>	
							
										
						</div>	
			 						
					  </div>						
					</div>
				</div>
				
				<!--#####################################################################################################################################-->
				<!--Tab main content-->
				<!--#####################################################################################################################################-->
				<div role="tabpanel" class="tab-pane fade in active" id="schedules_tab" style="height:100%; width:100%;  padding-left:56px; padding-right:56px;overflow-y:hidden!important; margin-top:-12px">
				
				<span id="schedule_tab_span_container">  <!--This span is used for hiding the section when reloading or loading-->
				
				<div style="height:12px; width:100%"></div>		<!--Just to fill gap of 12px between header and content pane-->
				

				<!--this is temporary heading for schedule display when add schedule form appears-->
				<div id="temp_schedule_heading" class="page-header row-fluid col-md-12" style="display:none;padding:0px; margin-bottom:2px; margin-top:-12px">
				  <h3 style="margin:0px"><span id="temp_schedule_heading_title" style="color:#4CAF50">CURRENT SCHEDULES</span> <small> List of currently available schedules. </small>			
				  </h3>
				</div>
				
				
				<!--Schedule table list section-->
				<div class="col-md-12 container-fluid" style="padding:0px;font-family:Arial, Helvetica, sans-serif; font-size:12px; height:100%; width:100%;overflow-y:auto!important">

			
			<!--Display message when there is no-schedule to display in table.-->
			  <div id="display_schedule_message_alert" class="alert in fade alert-success col-md-9" role="alert" style="display:none;background:none; border:1px solid #595959">
				<h2 style="color:#595959;"><span style="color:#4CAF50" id="display_schedule_message_title">Schedule not Available.</span><small id="display_schedule_message_detail">There is nothing to display. Please, add a new schedule details. Your added details will be displayed here.</small></h2>
				
			</div>
			
			
									  	
					<!--Save edit schedule detail status message-->				
				 <div id="schedule_save_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Successful.</strong><small> New changes to the selected schedule has been successfully updated.</small></div>
				 <div id="schedule_save_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Failed.</strong><small> Something went wrong. New changes to the selected schedule cannot be made at the moment.</small></div>
				 <div id="schedule_save_already_saved_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Unable to Save.</strong><small> No modification has been made to any schedule details or changes are already saved.</small></div>
				 
				
				
			 <!--delete schedule detail status message-->				
			 <div id="schedule_delete_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Successful.</strong><small> Selected Schedules has been successfully deleted.</small></div>
			 <div id="schedule_delete_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Failed.</strong><small> Something went wrong. Deletion to the selected Schedules cannot be made at the moment.</small></div>
			 
			 
			 
			
			<div id="main_table_container" style="width:100%; margin:auto; overflow-y:auto!important"">


			<!--Delete schedule check box to select all-->	
			<div id="display_schedule_schedule_delete_select_all_checkbox" style="display:none; width:94px"><div style="float:left; margin-top:3px;font-weight:bold">SELECT ALL: </div><div style="float:right"><input id="schedule_delete_select_all_checkbox" type="checkbox" aria-label="..." onClick="selectAllCheckBox()"></div></div>
			
			
			
		  <table class="table table-condensed table-striped table-bordered" id="display_schedule_table" style="display:none">
            <thead>
              <tr style="height:28px; background-color:#424242;color:#CCC">
                <th style="text-align:center" width="5%">SN</th>
                <th style="text-align:center"width="30%">ROUTE NAME</th>
                <th style="text-align:center"width="30%">VEHICLE NAME</th>	
                <th style="text-align:center"width="10%">SCHEDULE</th>				
              </tr>
            </thead>
            <tbody>
             <!--<tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Schedule 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>
             <tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Schedule 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>-->
			  </tbody>
			  </table>
			  
			  			<!--Delete button-->
			  <div id="delete_schedule_apply_and_cancel_buttons" style="display:none; margin-bottom:6px; margin-top:-6px">
			  <hr>
			  	<button id="delete_schedule_button" type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;height:32px; width:96px">
				  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DELETE
				</button>
				
				 <!--delete option close/cancel button-->
			  	<button type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;margin-left:5px; height:32px; width:96px" onClick="cancelScheduleDeleteOption()">
				  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
				</button>
				</div>	

</div>
			  
			
				<br><br><br><br>
			  </div>			  
				  			  
			  </span>
				
				</div>
				</div> 
				
				  </div>
				</div>
			</div>
		</div> 


		<!--loading icon animation-->
		<div id="loading_2" style="background:url('${loadingIcon}');background-repeat:no-repeat;background-position:center center;height:auto; width:auto; position: absolute;top:0;bottom: 0;left: 0;right: 0;margin-left:460px; auto;position:absolute; z-index:9999; display:none"></div>

		<div id="loading_1" style="background:url('${loadingIcon}');background-repeat:no-repeat;background-position:center center;height:auto; width:auto; position: absolute;top:0;bottom: 0;left: 0;right: 0;margin-left:120px; position:absolute; z-index:9999; display:none"></div>

		
		<!--Modals-->
		<!--Alert Modal-->
		<div id="alert_modal" class="modal fade" style="margin-top:120px; padding:40px">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header" style="height:42px; padding:8px; border-top-left-radius:5px; border-top-right-radius:5px; background-color:#424242; color:#FFF; text-align:center">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 id="alert_modal_title"class="modal-title"></h4>
			  </div>
			  <div class="modal-body">
			  <span style="font-size:16px" id="alert_modal_content"></span>
			  </div>
			  <div class="modal-footer">
				<button id="alert_modal_close" type="button" class="btn btn-sm" data-dismiss="modal" style="background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:32px;width:96px"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> CLOSE</button>
			  </div>
			</div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		
			<!--Action Modal-->
		<div id="action_modal" class="modal fade"  style="margin-top:120px; padding:40px">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header" style="height:42px; padding:8px; border-top-left-radius:5px; border-top-right-radius:5px;background:#424242; color:#FFF; text-align:center">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 id="action_modal_title"class="modal-title"></h4>
			  </div>
			  <div class="modal-body">
				<span style="font-size:16px" id="action_modal_content"></span>
			  </div>
			  <div class="modal-footer">
				<button id="action_modal_cancel" type="button" class="btn btn-sm" data-dismiss="modal" style="background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:32px;width:96px;margin-left:10px"> 
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> CANCEL</button>
				<button id="action_modal_delete" type="button" class="btn btn-sm" data-dismiss="modal" style="background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:32px;width:96px"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DELETE</button>
			  </div>
			</div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		

      <br>
      <!-- Footer -->
      <div class="navbar-header" style="position: fixed;bottom: 0; width: 100%; height:40px; background:#212121">
         <div  style="text-align:center; font-size:11px;color:#DDD">
            <div class="container" style="margin-top:5px">
               <span><strong  style="color:#4CAF50">Copyright &copy; sybus.com 2015 </strong><br> SAJHA YATAYAT VEHICLE TRACKING AND MANAGEMENT SYSTEM (SYBUS)  </span>
            </div>
         </div>
      </div>
	  
	  
	  <!--Javascript section-->
      <!-- Latest compiled JQuery JavaScript -->
      <script src="${jqueryJs}"></script>
      <script src="${jqueryUiJs}"></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src="${bootstrapJs}"></script>
	  
	  
	  <script type="text/javascript">
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
			setTabHeader("CURRENT SCHEDULES", " List of currently available Schedules.");
			//activateHeaderButton("refresh");  //initially setting refresh button
			
			//if the + button on top clicked show the add route form.
			$("#add_button").click(function(){
				openAddScheduleForm();
				//making form unfocused so that blue color edege will not seen.
				$("#schedule_add_edit_section").blur();
			});
			//if the edit button on top clicked show the edit action.
			$("#edit_button").click(function(){		
				displayEditOption();				
			});
			//if the delete button on top clicked show the delete action
			$("#delete_button").click(function(){				
				displayDeleteOption();
			});	

			//when all data is downloaded. i.e. document is ready. displaying the table.			
			/*$("#loading_1").fadeIn();	
			setTimeout(function(){
				$("#loading_1").fadeOut();	
				$("#display_schedule_table").fadeIn();
			},600);*/
			
			//misc. just to hide to foucs effect on form.
			$("#schedule_add_edit_section").click(function(){
				$("#schedule_add_edit_section").blur();
			});
		});
			
			//Setting header and title Javascript codes
			function setTabHeader(title, subtitle){				
				$("#content_header_title").text(title);
				$("#content_header_subtitle").text(subtitle);	
				$("#content_header").hide();				
				$("#content_header").fadeIn(500);
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
				//$("#loading_1").fadeIn();	
				//$("#schedule_tab_span_container").hide();
				//setTimeout(function(){				
				//	$("#schedule_tab_span_container").fadeIn();		
					//emptying the local array first.
					scheduleCollection = [];			
					allRoutesCollection = [];
					allVehicleCollection = [];
					
					//emptying the table row.
					$("#display_schedule_table tbody").empty();
					
					//now loading the data.
					loadRouteData();
				//	$("#loading_1").fadeOut();			
				//},2000);
			}
			
			//####################################################LOAD DATA ##############################################################
			
			//example data.
			var schedule1 = {id:1,vehicle:"BA 10 PA 3477", route:"Route 1", time:"12:15"};
			var schedule2 = {id:2,vehicle:"BA 11 PA 2327", route:"Route 1", time:"12:20"};
			var schedule3 = {id:3,vehicle:"BA 12 PA 6565", route:"Route 1", time:"12:25"};
			var schedule4 = {id:4,vehicle:"BA 13 PA 3434", route:"Route 3", time:"12:30"};
			var schedule5 = {id:5,vehicle:"BA 14 PA 5544", route:"Route 2", time:"12:35"};
			var schedule6 = {id:6,vehicle:"BA 15 PA 6655", route:"Route 3", time:"12:40"};
			var schedule7 = {id:7,vehicle:"BA 16 PA 7565", route:"Route 3", time:"12:45"};
			var schedule8 = {id:8,vehicle:"BA 17 PA 7666", route:"Route 3", time:"12:50"};
			var schedule9 = {id:9,vehicle:"BA 18 PA 7777", route:"Route 2", time:"12:55"};
			var schedule10 = {id:10,vehicle:"BA 10 PA 8866", route:"Route 2", time:"13:00"};
			var schedule11 = {id:11,vehicle:"BA 10 PA 3237", route:"Route 2", time:"13:05"};
			
			
			
			//this variable array holds the all the route data retrived from the server. also added updated and deleted route will be updated here as well
			var scheduleCollection = [];	
			
			var allRoutesCollection = [];	//holds route names. used to display in add/edit form dropdown
			var allVehicleCollection = [];   //holds vehicle names. used to display in add/edit form dropdown
			
			//this function get the route list when the page is first loaded.\\\
			function loadRouteData(){
				//loading from server code here  example is route 1 route 2 and route 3 and route 4
				
				//scheduleCollection.push(schedule1,schedule2,schedule3,schedule4,schedule5,schedule6,schedule7,schedule8,schedule9,schedule10,schedule11);
				//scheduleCollection.push(schedule1,schedule2,schedule3,schedule4,schedule5,schedule6,schedule7,schedule8,schedule9,schedule10,schedule11);
				
				//allRoutesCollection.push("Route 1", "Route 2","Route 3","Route 4");
				//allVehicleCollection.push("BA 10 PA 3477","BA 11 PA 2327","BA 12 PA 6565","BA 13 PA 3434", "BA 14 PA 5544","BA 15 PA 6655","BA 16 PA 7565","BA 17 PA 7666","BA 18 PA 7777","BA 10 PA 8866","BA 10 PA 3237");
				
				$("#loading_1").fadeIn();	
				$("#display_schedule_table").hide();
				
				console.log("Loading schedule data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "load_schedule_data",
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS LOADING SCHEDULE DATA");
							//updateRouteServerStatus = status;
							scheduleCollection = data.schedules;								
							allRoutesCollection = data.routes;	
							allVehicleCollection = data.vehicles; 
							
							if (scheduleCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_schedule_message_alert").fadeIn();	
								$("#display_schedule_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(scheduleCollection, function(i, schedule){
									//stopsName.push(route.stops);
									loadScheduleDataToTable(schedule.vehicle, schedule.route, schedule.time);						
								});	
								
								
																				
								//making the table font color to black since it is changed by to blue by loadRouteDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_schedule_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_schedule_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
								//	$("#loading_1").fadeOut();	
									$("#display_schedule_table").fadeIn();
									
									$("#loading_1").fadeOut();	
									
							}
								//adding the route name in filter dropdown
								//alert(allRoutesCollection.length);
								jQuery.each(allRoutesCollection, function(i, route){
									//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
									$('#schedule_display_filter_table_dropdown').append($('<option>', { 
										value: i,
										text : route 
									}));
								});
								
								//adding the route and vehicle name in add form dropdowns
								if(allRoutesCollection.length!=0 || allVehicleCollection.length!=0){
									//now adding in dropdown
									jQuery.each(allRoutesCollection, function(i, route){
										//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
										$('#schedule_add_edit_select_route_dropdown').append($('<option>', { 
											value: i,
											text : route 
										}));
									});
									jQuery.each(allVehicleCollection, function(i, vehicle){
										//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
										$('#schedule_add_edit_select_vehicle_dropdown').append($('<option>', { 
											value: i,
											text : vehicle 
										}));
									});
								}
								//},600);
							//}
						},
						error : function(e) {
							console.log("ERROR WHILE LOADING SCHEDULE DATA");
							
							scheduleCollection = [];							
							allRoutesCollection = [];	
							allVehicleCollection = []; 

														if (scheduleCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_schedule_message_alert").fadeIn();	
								$("#display_schedule_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(scheduleCollection, function(i, schedule){
									//stopsName.push(route.stops);
									loadScheduleDataToTable(schedule.vehicle, schedule.route, schedule.time);						
								});	
								
								
																				
								//making the table font color to black since it is changed by to blue by loadRouteDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_schedule_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_schedule_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
								//	$("#loading_1").fadeOut();	
									$("#display_schedule_table").fadeIn();
																		
									$("#loading_1").fadeOut();	
							}
								//adding the route name in filter dropdown
								//alert(allRoutesCollection.length);
								jQuery.each(allRoutesCollection, function(i, route){
									//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
									$('#schedule_display_filter_table_dropdown').append($('<option>', { 
										value: i,
										text : route 
									}));
								});
								
								//adding the route and vehicle name in add form dropdowns
								if(allRoutesCollection.length!=0 || allVehicleCollection.length!=0){
									//now adding in dropdown
									jQuery.each(allRoutesCollection, function(i, route){
										//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
										$('#schedule_add_edit_select_route_dropdown').append($('<option>', { 
											value: i,
											text : route 
										}));
									});
									jQuery.each(allVehicleCollection, function(i, vehicle){
										//$("#select_stop_from_list option").append('<option>'+stop.name+'</option>');
										$('#schedule_add_edit_select_vehicle_dropdown').append($('<option>', { 
											value: i,
											text : vehicle 
										}));
									});
								}
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
				//	$("#loading_1").hide();	
				//},600);				
			}						
			loadRouteData();
			
			//#############################################################################################
			//#SERVER INTERACTTION CODES

			function addScheduleToServer(vehicle, route, time){
				
				var scheduleData = {vehicle:vehicle, route:route, time:time};
				//need to return added schedule id or null.
				//the time is send as 1212 format not 12:12. in database it is stored like that. Update: not valid now. send as 12:!2
				//return 12;
				
				console.log("Adding new schedule data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "save_schedule_data",
						data : JSON.stringify(scheduleData),
						dataType : 'json',
						timeout : 100000,
						success : function(scheduleID) {
							console.log("SUCCESS ADDING SCHEDULE DATA");
							//updateRouteServerStatus = status;
							afterAddScheculeData(true, vehicle, route, time, scheduleID);
						},
						error : function(e) {
							console.log("ERROR WHILE ADDING SCHEDULE DATA");
							//updateRouteServerStatus = false;	
							afterAddScheculeData(false, vehicle, route, time, 0);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
				
			}	


			function updateScheduleToServer(updatedSchedules){
							
				console.log("Updating schedule data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "update_schedule_data",
						data : JSON.stringify(updatedSchedules),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS UPDATING SCHEDULE DATA");
							//updateRouteServerStatus = status;
							afterUpdateScheduleData(true, updatedSchedules);
						},
						error : function(e) {
							console.log("ERROR WHILE UPDATING SCHEDULE DATA");
							//updateRouteServerStatus = false;	
							afterUpdateScheduleData(false, updatedSchedules);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}


			function deleteScheduleToServer(toDeleteSchedules){
				console.log("Deleting schedule data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "delete_schedule_data",
						data : JSON.stringify(toDeleteSchedules),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS DELETING SCHEDULE DATA");
							//updateRouteServerStatus = status;
							afterDeleteScheduleData(true, toDeleteSchedules);
						},
						error : function(e) {
							console.log("ERROR WHILE DELETING SCHEDULE DATA");
							//updateRouteServerStatus = false;	
							afterDeleteScheduleData(false, toDeleteSchedules);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}


			//############################################################################################
			
			//this function load data to the page table
			function loadScheduleDataToTable(vehicle, route, time){
				var index = $("#display_schedule_table tbody").children().length;
				index = parseInt(index)+1;
				//adding to the table list.
				$("#display_schedule_table tbody").append('<tr style="padding:0px; height:auto; color:#673AB7; font-size:11.5px" tabindex="1"><td style="height:24px">'+index+'</td><td style="text-align:center">'+route+'</td><td style="text-align:center">'+vehicle+'</td><td style="text-align:center">'+time+'</td></tr>');
			}
			
			//this function removes or clears the dropdown.
			
			
			//##############ADD NEW SCHEDULE #######################################################
			
			
			
			//this funciton is triggered when user click the add button in top right corner option panel.
			//this funciton shows the add form
			function openAddScheduleForm(){
				$("#schedule_add_edit_section").slideDown().fadeIn();				
				$("#temp_schedule_heading").fadeIn();
				disableAddEditDeleteButtons();	
				setTabHeader("ADD SCHEDULE"," Add a new Schedule details.");
				$("#content_header_button_refresh").attr("disabled", true);		//refresh button
				$("#sort_table").css({"pointer-events":"none"});		//sort button	
				$("#filter_table").css({"pointer-events":"none"});		//filter button			
				$("#display_schedule_table").css({'pointer-events':'none','filter':'alpha(opacity=60)', 'opacity':'0.6'});
								
				$("#schedule_add_edit_form_submit_button").text("ADD");			//this button is used for update as well. so ensureing it is displayed ADD .
				
				
				//adding the route and vehicle name in add form dropdowns
				if(allRoutesCollection.length==0 || allVehicleCollection.length==0){
					setTimeout(function(){						
						$("#schedule_add_timeout_error_message_header").text("WARNING");
						$("#schedule_add_timeout_error_message_detail").text(" Cannot add the new Schedule at the moment. Currently, no Vehicles and Route information ara available to display.");
						$("#schedule_add_timeout_error_message").slideDown().fadeIn();
					},600);
				}
				else{
					$("#schedule_add_timeout_error_message").hide();					
				}
				
				//adding click event on add button
				$("#schedule_add_edit_add_button").off();
				$("#schedule_add_edit_add_button").on('click', function(){
						addSchedule();
				});
				
				//adding click event on exit button
				$("#schedule_add_edit_exit_button").off();
				$("#schedule_add_edit_exit_button").on('click', function(){
					exitAddEditScheduleForm();
					
					$("#schedule_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route vehicle available
				});	
				//adding click event on reset button
				$("#schedule_add_edit_reset_button").on('click', function(){
					resetForm();
				});					
			}
			
			
			//reset add edit schedule fomr
			function resetForm(){				
				$("#schedule_add_edit_select_vehicle_dropdown").val("SELECT A VEHICLE");
				$("#schedule_add_edit_select_route_dropdown").val("SELECT A ROUTE");
				$("#schedule_add_edit_select_hour_dropdown").val("HOUR");
				$("#schedule_add_edit_select_min_dropdown").val("MIN");
			}
			
			//this function add the schedule details. it is triggeded by add button of add schedule form
			function addSchedule(){
				var vehicle = $("#schedule_add_edit_select_vehicle_dropdown :selected").text();
				var route = $("#schedule_add_edit_select_route_dropdown :selected").text();
				var hour = $("#schedule_add_edit_select_hour_dropdown :selected").text();
				var min = $("#schedule_add_edit_select_min_dropdown :selected").text();
				
				if(vehicle=="SELECT A VEHICLE"){									
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. Vehicle is not selected. Please, select a Vehicle from the dropdown list and try again.");
					$("#alert_modal").modal('show');
				}
				else if(route=="SELECT A ROUTE"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. Route is not selected. Please, select a Route from the dropdown list and try again.");
					$("#alert_modal").modal('show');
				}
				else if(hour=="HOUR"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. The schedule time is not selected. Please, select Hour for schedule time and try again.");
					$("#alert_modal").modal('show');
				}
				else if(min=="MIN"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. The schedule time is not selected. Please, select Minute for schedule time and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(route,vehicle,hour, min)==true){
					//alert(checkForDuplicateEntry(route,vehicle,hour, min));
					$("#schedule_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#schedule_add_edit_loading_icon").fadeOut();					
						$("#schedule_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#schedule_add_timeout_error_message_detail").text(" The schedule information is already exist. Please, provide non-duplicate data and add it.");
						$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#schedule_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{					
					$("#schedule_add_edit_loading_icon").fadeIn();
					//setTimeout(function(){
							
							//##########################################################
							//Now sent the data to the server.
							//sending time in the form of 1212 not separated as 12:12. 
							addScheduleToServer(vehicle, route, hour.concat(":").concat(min));
							
							//#######################################################

						
							//var serverStatus = false;
							//error example
							//var errormessage = "Duplicate Schedule. The schedule is already added on the list.";
							//var returnSameObjectWithId = {id:1212, vehicle:"BA 10 PA 3477", route:"Route 1", time:"12:15"};  //or only download id.
							//so that new data will be stored in local array with id.
							
							//now add this object to the scheduleCollection;
							//#######################################################
							
							//if the returned id is null or server failed.
							/*if(addedScheduleReturnedId!=null || addedScheduleReturnedId!="" || addedScheduleReturnedId!='undefined'){
								//adding the data to local array
								//the id will be downloaded from the server.												//above id will be added here.
								scheduleCollection.push({id:addedScheduleReturnedId,route:route,vehicle:vehicle,time:hour.concat(":").concat(min)});
								
								//adding to the table
								loadScheduleDataToTable(vehicle, route, hour.concat(":").concat(min));
								
								////////////////////////////////////////////////////
								
								//the display successful message.
								$("#add_schedule_submit_message_alert").fadeIn();
								$("#schedule_add_edit_section").hide();

								//adding event listener to add again button.
								$("#schedule_add_success_add_again").on('click',function(){						
									$("#add_schedule_submit_message_alert").slideUp().fadeOut();
									openAddScheduleForm();
								});
								
								//adding click listener to exit button.
								$("#schedule_add_success_exit").on('click',function(){						
									$("#add_schedule_submit_message_alert").slideUp().fadeOut();
									exitAddEditScheduleForm();
								});
							}
							else{
								/*if(errormessage!=""){
									$("#schedule_add_server_error_message_detail").text(errormessage);
									$("#schedule_add_server_error_message2").slideDown().fadeIn();
									setTimeout(function (){						
										$("#schedule_add_server_error_message2").slideUp().fadeOut();
									},4000);
								}
								//else{
									//display error message. may be server error or system error.
									$("#schedule_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
									$("#schedule_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the schedule details at the moment.");
									$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
									setTimeout(function(){
										$("#schedule_add_timeout_error_message").slideUp().fadeOut();
									},4000);
								//}
							}
							$("#schedule_add_edit_loading_icon").fadeOut();
							resetForm();	*/						
						//},2000);							
				}
			}
			
			
			//This function is executed after add schedule ajax execution.
			function afterAddScheculeData(status, vehicle, route, time, scheduleID){
				if(status == true){
					//adding the data to local array
					//the id will be downloaded from the server.												//above id will be added here.
					scheduleCollection.push({id:scheduleID,route:route,vehicle:vehicle,time:time});
					
					//adding to the table
					loadScheduleDataToTable(vehicle, route, time);
					
					$("#display_schedule_message_alert").hide();	
					$("#display_schedule_table").fadeIn();
					
					////////////////////////////////////////////////////
					
					//the display successful message.
					$("#add_schedule_submit_message_alert").fadeIn();
					$("#schedule_add_edit_section").hide();

					//adding event listener to add again button.
					$("#schedule_add_success_add_again").on('click',function(){						
						$("#add_schedule_submit_message_alert").slideUp().fadeOut();
						openAddScheduleForm();
					});
					
					//adding click listener to exit button.
					$("#schedule_add_success_exit").on('click',function(){						
						$("#add_schedule_submit_message_alert").slideUp().fadeOut();
						exitAddEditScheduleForm();
					});
				}
				else{
					//display error message. may be server error or system error.
					$("#schedule_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#schedule_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the schedule details at the moment.");
					$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#schedule_add_timeout_error_message").slideUp().fadeOut();
					},4000);
					//}
				}
				$("#schedule_add_edit_loading_icon").fadeOut();
				resetForm();	
			}
			
			//this function exit the schedule details. it is triggeded by exit button of add/edit schedule form
			function exitAddEditScheduleForm(){	
				resetForm();
				$("#schedule_add_edit_section").slideUp("slow").fadeOut("slow");
				$("#temp_schedule_heading").hide();
				enableAddEditDeleteButtons();	
				setTabHeader("CURRENT SCHEDULE"," List of currently available schedules.");
				$("#content_header_button_refresh").attr("disabled", false);					
				$("#display_schedule_table").css({'pointer-events':'auto','filter':'alpha(opacity=100)', 'opacity':'1'});
				$("#sort_table").css({"pointer-events":"auto"});		//sort button	
				$("#filter_table").css({"pointer-events":"auto"});		//filter button
			}
			
			
			//this method check for duplicate data during adding or updating schedule details
			function checkForDuplicateEntry(route,vehicle,hour, min){
				var isDuplicate = false;
				for(var i=0; i<scheduleCollection.length;i++){
					var time = scheduleCollection[i].time.split(":");	
					//alert(scheduleCollection[i].route+route + scheduleCollection[i].vehicle+vehicle +Number(time[0])+Number(hour) + Number(time[1])+Number(min));
					if(scheduleCollection[i].route==route && scheduleCollection[i].vehicle==vehicle && Number(time[0])==Number(hour) && Number(time[1])==Number(min)){
						//alert();
						isDuplicate= true;
						return true;
					}				
				}
				return isDuplicate;
			}
			
			
			//################EDIT SCHEDULE SECTION################################################
						
			
			//this function open edit option when the edit button is clicked on top right corner
			function displayEditOption(){
			
					var saveStatus = false; 		//status for either updates are saved or not
					var original_table = $("#display_schedule_table").clone();		//clonning original table
					
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_schedule_table").find("tbody").children().length==0){
					$("#display_schedule_table").hide();				
					$("#display_schedule_message_alert").hide();	
					$("#display_schedule_message_title").text("Edit un-available.");						
					$("#display_schedule_message_detail").text("Currently, no Schedules are available to edit.");	
					$("#display_schedule_message_alert").slideDown().fadeIn();	
					setTimeout(function(){
						$("#display_schedule_message_alert").slideUp().fadeOut();						
						$("#display_schedule_message_title").text("Schedules un-available.");						
						$("#display_schedule_message_detail").text("There is nothing to display. Please, add a new schedule details. Your added details will be displayed here.");
						$("#display_schedule_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{			
					$("#display_schedule_table").hide();											
					$("#loading_1").fadeIn();	
					
					//removing previous events bind to this buttons					
					$("#content_header_button_exit").off();
					$("#content_header_button_save").off();
					
					//hiding tefresh, sort and filters					
					$("#content_header_button_refresh").hide();
					$("#sort_table").hide();		//sort button	
					$("#filter_table").hide();		//filter
					
					//hiding buttons to imitate fade in effect
					$("#content_header_button_exit").hide();
					$("#content_header_button_save").hide();
					//adding click listener to save button.
					$("#content_header_button_save").click(function(){
						saveUpdatedScheduleDetail();
						saveStatus = true;
					});
					$("#content_header_button_exit").click(function(){
						$("#loading_1").fadeIn();					
						$("#display_schedule_table").hide();
						
						//reverting to original table on exit if changes are not saved.
						if(saveStatus==false){
							$("#display_schedule_table").replaceWith(original_table);
						}
						cancelScheduleEditOption();
						setTimeout(function(){					
							$("#display_schedule_table").fadeIn(100);
							$("#loading_1").hide();
						},600);
					});
					//setting the header					
					setTabHeader("EDIT SCHEDULE"," Please, click on edit button of any row to edit its details.");
					
					addEditButtonOnScheduleTable();
					disableAddEditDeleteButtons();
					$("#loading_1").fadeIn();
					setTimeout(function(){	
						$("#content_header_button_exit").fadeIn();	
						$("#content_header_button_save").fadeIn();							
						$("#display_schedule_table").fadeIn(100);
						$("#loading_1").hide();
					},600);
				}
			}
			
		
		//this function add the edit button on each row of the table
		function addEditButtonOnScheduleTable(){
			$("#display_schedule_table thead tr").append('<th width="8%"style="text-align:center">ACTION</th>');
			$("#display_schedule_table tbody tr").append('<td height="24" style="margin:0px; padding:4px"><button type="button" class="btn btn-sm" style="padding:2px; font-size:11px;height:24px; margin:0px; width:100%; background:none; border:1px solid #424242" onclick="displayEditForm(this)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> EDIT </button></td>');	
		}
		
		//this function removes the edit button on each row of the table
		function removeEditButtonOnScheduleTable(){					
			$("#display_schedule_table thead tr th:nth-child(5)").remove();
			$("#display_schedule_table tbody tr td:nth-child(5)").each(function(){
				$(this).remove();
			});	
		}
		
		//this function cancel the schedule edit option
		function cancelScheduleEditOption(){							//emptying the updated value.
				updated_Schedules = [];
				
				$("#loading_1").fadeIn();
				$("#display_schedule_table").hide();
				
				setTabHeader("CURRENT ROUTES", " List of currently available Routes.");
				
				removeEditButtonOnScheduleTable();
				changeDefaultTextColorOfRouteRow();	
				enableAddEditDeleteButtons();
			
				//unhiding tefresh, sort and filters					
				$("#content_header_button_refresh").fadeIn();
				$("#sort_table").fadeIn();		//sort button	
				$("#filter_table").fadeIn();		//filter
				
				//hiding the save and exti buttons
				$("#content_header_button_exit").hide();
				$("#content_header_button_save").hide();
				
				setTimeout(function(){					
					$("#display_route_table").hide();				
					$("#loading_1").fadeOut();
				},400);
				
		}
		
		//when user click a row edit button, the system will get first schedule id from the local array and will be used to add with updated data. the updateSchedule array.
		//the process to update\
			//>>>> First, set to edit mode.
			//>>>> Then click to edit button
			//>>>> Then open the form. 
			//>>>> The scheduleIdtoUpdate is the retrieved from the local array and then stored untill the next edit form is triggered. then , this will replaced.
			//>>>> Then when user close and save, this id is used and stored to UpdatedSchedule array along with updated value.
			//>>>> later this array is send to server to make changes.
			//>>>> Program complete.
			
		//this variable holds the original id of the schedule that will be updated when edit form is displayed.
		var scheduleIdtoBeUpdated = null;
		
		//This function displays the edit form when edit button is clicked
		function displayEditForm(row){
			var route = $(row).parent().parent().find("td:nth-child(2)").text();
			var vehicle = $(row).parent().parent().find("td:nth-child(3)").text();
			var time = $(row).parent().parent().find("td:nth-child(4)").text();	
			//alert(route+vehicle+time);
			var hrMin = time.split(":");
			var hour = Number(hrMin[0]);
			var min = Number(hrMin[1]);
			
			//getting the selected schedule id
			jQuery.each(scheduleCollection, function(i, schedule){
				if(schedule.vehicle==vehicle && schedule.route==route && schedule.time==time){
					scheduleIdtoBeUpdated = schedule.scheduleID;
					return true;
				}				
			});
			//alert(id);
									
			openEditScheduleForm(row, vehicle, route, hour, min);			
		}
		
		
					
			//this funciton is triggered when user click the edit button in top right corner option panel.
			//this funciton shows the add form
			function openEditScheduleForm(row, vehicleName, routeName, hour, min){
				//highlightling the selected row				
				//$(row).parent().parent().css({"background":"#EEEEEE"});	
				$(row).parent().parent().focus();
				
				$("#schedule_add_edit_section").slideDown().fadeIn();
								
				$("#schedule_add_edit_form_submit_button").text("UPDATE");			//this button is used for update as well. so ensureing it is displayed ADD .
								
					//adding click event on add button
					$("#schedule_add_edit_add_button").off();
					$("#schedule_add_edit_add_button").on('click', function(){
							updatSchedule($(row));
					});
				//adding click event on exit button``
				$("#schedule_add_edit_exit_button").off();
				$("#schedule_add_edit_exit_button").on('click', function(){					
					$("#schedule_add_edit_section").slideUp().fadeOut();
					resetForm();
					
					$("#schedule_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route vehicle available
				});	
				//adding click event on reset button
				$("#schedule_add_edit_reset_button").on('click', function(){
					resetForm();
				});			

					//alert(allVehicleCollection.indexOf(vehicleName));
					//setting the default schedule value
					$('#schedule_add_edit_select_vehicle_dropdown').prop('selectedIndex', Number(allVehicleCollection.indexOf(vehicleName)+1)); 
					$('#schedule_add_edit_select_route_dropdown').prop('selectedIndex', Number(allRoutesCollection.indexOf(routeName)+1)); 
					//$('#schedule_add_edit_select_vehicle_dropdown select>option:eq('+vehicleName+')').prop('selected', true);
					//$("#schedule_add_edit_select_vehicle_dropdown").val(vehicleName);
					//$("#schedule_add_edit_select_route_dropdown").val(routeName);
					$("#schedule_add_edit_select_hour_dropdown").prop('selectedIndex', Number(hour+1)); 
					$("#schedule_add_edit_select_min_dropdown").prop('selectedIndex', Number(min+1)); 
					//$("#schedule_add_edit_select_hour_dropdown").val(hour);
					//$("#schedule_add_edit_select_min_dropdown").val(min);
			}
			
			
	
				//This function writes updated routes details to the edit mode table which will later saved after save button clicked.
			function updatSchedule(row){				
				var vehicle = $("#schedule_add_edit_select_vehicle_dropdown :selected").text();
				var route = $("#schedule_add_edit_select_route_dropdown :selected").text();
				var hour = $("#schedule_add_edit_select_hour_dropdown :selected").text();
				var min = $("#schedule_add_edit_select_min_dropdown :selected").text();		

				if(vehicle=="SELECT A VEHICLE"){									
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. Vehicle is not selected. Please, select a Vehicle from the dropdown list and try again.");
					$("#alert_modal").modal('show');
				}
				else if(route=="SELECT A ROUTE"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. Route is not selected. Please, select a Route from the dropdown list and try again.");
					$("#alert_modal").modal('show');
				}
				else if(hour=="HOUR"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. The schedule time is not selected. Please, select Hour for schedule time and try again.");
					$("#alert_modal").modal('show');
				}
				else if(min=="MIN"){							
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Schedule. The schedule time is not selected. Please, select Minute for schedule time and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(route,vehicle,hour, min)==true){
					//alert(checkForDuplicateEntry(route,vehicle,hour, min));
					$("#schedule_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#schedule_add_edit_loading_icon").fadeOut();					
						$("#schedule_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#schedule_add_timeout_error_message_detail").text(" The schedule information is already exist. Please, provide non-duplicate data and add it.");
						$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#schedule_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{
					$("#schedule_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#schedule_add_edit_loading_icon").fadeOut();
						$(row).parent().parent().find("td:nth-child(2)").text(route);
						$(row).parent().parent().find("td:nth-child(3)").text(vehicle);
						$(row).parent().parent().find("td:nth-child(4)").text(hour+":"+min);
						
						$(row).parent().parent().css({"color":"#673AB7","font-weight":"bold"});	
						
						$("#schedule_add_edit_section").slideUp().fadeOut();
						$(row).parent().parent().focus();
						
						//now adding to the update array
						updated_Schedules.push({scheduleID:scheduleIdtoBeUpdated, route:route,vehicle:vehicle,time:hour.concat(":").concat(min)});
					},600);				
				}
			}
			
		
		//this variable is to store as collection of all route details individual array.
		var updated_Schedules = [];
		
		//This function saves all the updated schedules details to the database server.
		function saveUpdatedScheduleDetail(){
			if(updated_Schedules.length==0){					
				$("#schedule_save_already_saved_error_message").slideDown().fadeIn();
				setTimeout(function(){
					$("#schedule_save_already_saved_error_message").slideUp().fadeOut();
				},5000);
			}
			else{
				//disabling the save or exit button during saving data
				$("#content_header_button_save").prop("disabled",true);
				$("#content_header_button_exit").prop("disabled",true);
				//enabling the loading animation				
				$("#content_header_loading_icon").fadeIn();
				//setTimeout(function(){			

						
						//###################################################################################
						//saving status from server.
						
						
						//updated_Schedules need to send to serve.rad
						
						updateScheduleToServer(updated_Schedules);
						
						
						//###################################################################################						
						
						/*if(serverStatus==true){
							$("#schedule_save_success_message").slideDown().fadeIn();
							$("#schedule_save_success_message").focus();
							$("#schedule_save_success_message").blur();
							
							setTimeout(function(){
								$("#schedule_save_success_message").slideUp().fadeOut();
							},5000);
							
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfRouteRow();
							
							//alert("apple");
							//modify the changes from the local array too.
							jQuery.each(updated_Schedules, function(i,updated_schedule){
								jQuery.each(scheduleCollection, function(i,old_schedule){
									if(old_schedule.id==updated_schedule.id){
										old_schedule.vehicle=updated_schedule.vehicle;
										old_schedule.route=updated_schedule.route;
										old_schedule.time=updated_schedule.time;
										return true;
									}
								});
							});
							//delete updated routes array collection
							updated_Schedules = [];
							//alert();
							//alert(JSON.stringify(scheduleCollection));
							
				
							//jQuery.each(updated_Schedules, function(i, val){						
							//alert(i+" , "+val.name+" , "+val.stops);
							
							//re-enabling the save or exit button during saving data
							$("#content_header_button_save").prop("disabled",false);
							$("#content_header_button_exit").prop("disabled",false);
							//disabling the loading animation				
							$("#content_header_loading_icon").fadeOut();
							
						}
						else{
							$("#schedule_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#schedule_save_danger_message").slideUp().fadeOut();
							},5000);
						}*/
					//});
					
					
					
					
				//},2000);
			}
		}
		
		
		//This function is executed after update route ajax.
		function afterUpdateScheduleData(status, updated_Schedules){
			if(status==true){
				$("#schedule_save_success_message").slideDown().fadeIn();
				$("#schedule_save_success_message").focus();
				$("#schedule_save_success_message").blur();
				
				setTimeout(function(){
					$("#schedule_save_success_message").slideUp().fadeOut();
				},5000);
				
				//reverting the edited row color to original color and font.
				changeDefaultTextColorOfRouteRow();
				
				//alert("apple");
				//modify the changes from the local array too.
				
				jQuery.each(updated_Schedules, function(i,updated_schedule){
					jQuery.each(scheduleCollection, function(i,old_schedule){
						if(old_schedule.id==updated_schedule.id){
							old_schedule.vehicle=updated_schedule.vehicle;
							old_schedule.route=updated_schedule.route;
							old_schedule.time=updated_schedule.time;
							return true;
						}
					});
				});
				//delete updated routes array collection
				updated_Schedules = [];
				//alert();
				//alert(JSON.stringify(scheduleCollection));
				
	
				//jQuery.each(updated_Schedules, function(i, val){						
				//alert(i+" , "+val.name+" , "+val.stops);
				
				//re-enabling the save or exit button during saving data
				$("#content_header_button_save").prop("disabled",false);
				$("#content_header_button_exit").prop("disabled",false);
				//disabling the loading animation				
				$("#content_header_loading_icon").fadeOut();
				
			}
			else{
				$("#schedule_save_danger_message").slideDown().fadeIn();
				setTimeout(function(){
					$("#schedule_save_danger_message").slideUp().fadeOut();
				},5000);
			}
		}
		
		
		
		
		
			
			//this function revert back the text color to default black which has been changed in edit mode after update.
			function changeDefaultTextColorOfRouteRow(){
				$("#display_schedule_table tbody tr").each(function(){
					$(this).css({"font-weight":"normal", "color":"#424242"});
				});
			}
			
			
			
			//##############DELETE SECTION#####################################################
			
			
			
			//this function display the delete option
			function displayDeleteOption(){
				//<!--if there is no route available then delete mode must is unavailable-->
				if($("#display_schedule_table").find("tbody").children().length==0){
					$("#display_schedule_table").hide();
					
					$("#display_schedule_message_alert").hide();	
					$("#display_schedule_message_title").text("Delete un-available.");						
					$("#display_schedule_message_detail").text("Currently, no Schedule are available to delete.");	
					$("#display_schedule_message_alert").fadeIn();	
					
					setTimeout(function(){	
					$("#display_schedule_message_alert").slideUp().fadeOut();						
						$("#display_schedule_message_title").text("Schedules un-available.");						
						$("#display_schedule_message_detail").text("There is nothing to display. Please, add a new Schedule details. Your added details will be displayed here.");
						$("#display_schedule_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{	
					setTabHeader("DELETE SCHEDULES", " Please, check the rows that you want to delete.");
					//$("#temp_route_heading_title").text("DELETE ROUTE");
					//$("#temp_route_heading h3 small").text("Please, check the rows that you want to delete.");
					$("#display_schedule_table").hide();
					addCheckBoxInTable();
					$("#delete_schedule_apply_and_cancel_buttons").fadeIn();
					$("#display_schedule_schedule_delete_select_all_checkbox").slideDown().fadeIn();
					disableAddEditDeleteButtons();
					
					$("#content_header_button_refresh").prop("disabled", true);
					$("#sort_table").css({"pointer-events":"none"});		//sort button	
					$("#filter_table").css({"pointer-events":"none"});		//filter
					
					$("#display_schedule_table").fadeIn('slow');
					
					//adding event listener to the delete button
					$("#delete_schedule_button").off()
					$("#delete_schedule_button").on('click',function(){
						displayScheduleDeleteModal();
					});
					
					//for cancel button cancelScheduleOption is already added in onclick event of button html attribute.
				}			
			}
			
						//This function add the checkbox to the route table list.
			function addCheckBoxInTable(){
				$("#display_schedule_table thead tr").prepend('<th>MARK</th>');
				//var total_item = $("#display_route_table thead tr").find("tbody").children().length;
				//for(var i=0; i<total_item;i++){
					$("#display_schedule_table tbody tr").prepend('<td style="padding:0px; margin:0px" width="4%"><span style="background:none;border:none" class="input-group-addon"><input type="checkbox" aria-label="..." onclick="unTickSelectAllCheckBox()"></span></td>');				
				//}
			}
			
			
			
			//Action of select all checkbox on delete route details option. the function will return either the checkbox is checked or not.
			//triggered by select all checkbox.
				function selectAllCheckBox(){
					if($("#schedule_delete_select_all_checkbox").is(":checked")){					
					//alert("checked");
					//checking all the input checkboxes in the list.
					$("#display_schedule_table tbody tr").find("input:checkbox").prop('checked', true);
					}
					else{
						//alert("not checked");					
						$("#display_schedule_table tbody tr").find("input:checkbox").prop('checked', false);
					}
				}
				
			
			//This function unselect the select all Checkbox. This is to make the main select all tick box unticked when any of all selected boxes are manually unchecked during deletion.
			function unTickSelectAllCheckBox(){
				$("#schedule_delete_select_all_checkbox").prop('checked', false);
			}
			
						
			//this function removes the checkbox from the route delete option
			function removeCheckBoxInTable(){
				$("#display_schedule_table thead tr th:first").remove();
				$("#display_schedule_table tbody tr td:nth-child(1)").each(function(){
					(this).remove();
				});
			}
			
			
						
			//this function get out of the delete option mode
			function cancelScheduleDeleteOption(){	
				setTabHeader("CURRENT SCHEDULES", " List of currently available Schedules.");	
				
					$("#display_schedule_table").hide();					
					$("#loading_1").fadeIn();
				//$("#temp_route_heading_title").text("CURRENT ROUTE");
				//$("#temp_route_heading h3 small").text("List of currently available routes.");
				removeCheckBoxInTable();
				
				$("#delete_schedule_apply_and_cancel_buttons").hide();
				$("#display_schedule_schedule_delete_select_all_checkbox").hide();
				
				enableAddEditDeleteButtons();
				
				
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
					
					
				setTimeout(function(){					
					$("#display_schedule_table").fadeIn();					
					$("#loading_1").fadeOut();
				},400);
			}
			
			

			
			//this function gets the schedule route, vehicle and time detail and return.
			function getToDeleteScheduleRowIds(){	
				//this variable holds the deleted schedule or to delete schedule details.					
				var toDeleteSchedules = [];
				$("#display_schedule_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');						
						toDeleteSchedules.push({route:$(row).find("td:nth-child(3)").text(),vehicle:$(row).find("td:nth-child(4)").text(),time: $(row).find("td:nth-child(5)").text()});
					}
				});
				return toDeleteSchedules;
			}
			
			//this function delete route rows
			function deleteRowSchedules(){	
				$("#display_schedule_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						$(row).remove();
					}
				});
			}
			
			
						
			//this variable holds the id of the schedule code to delete.			
			var scheduleIdToDelete = [];
			
			function deleteScheduleRowsExtended(){				
				$("#loading_1").fadeIn();
				
				//degetting the schdule details that need to be deleted.
				var toDeleteSchedulesList = getToDeleteScheduleRowIds();	
				//alert(JSON.stringify(toDeleteSchedules));
				
				//getting the id of schedule to delete.
				jQuery.each(toDeleteSchedulesList, function(i, deletedSchedule){
					jQuery.each(scheduleCollection, function(i, oldSchedule){
					//alert(oldSchedule.vehicle+deletedSchedule.vehicle + oldSchedule.route+deletedSchedule.route + oldSchedule.time+deletedSchedule.time);
						if(oldSchedule.vehicle==deletedSchedule.vehicle && oldSchedule.route==deletedSchedule.route && oldSchedule.time==deletedSchedule.time){
							scheduleIdToDelete.push(oldSchedule.scheduleID);
							//alert();
						}
					});
				});
										
				//setTimeout(function(){	
				
				
				//alert(scheduleIdToDelete);
				//##################################################
				//Server codes
				//send toDeleteSchedules to server to delete.
				deleteScheduleToServer(scheduleIdToDelete);
				
				
				
				//####################################################
				
				/*if(deleteStatus == true){			
						//deleting schedule from the local array.
						
						//alert(JSON.stringify(scheduleCollection));
						for(var i=0; i<scheduleIdToDelete.length;i++){
							for(var j=0; i<scheduleCollection.length;j++){
								if(scheduleCollection[j].id==scheduleIdToDelete[i]){
									scheduleCollection.splice(scheduleCollection.indexOf(scheduleCollection[j]),1);
									break;
								}
							}
						};
						
						//Why the below doesnot work and above work?
						//Because, whenever a row is deleted in the local array, the array index is shift and next count array becomes unavailable and hence undefined. 
						//for example, if I delete 9 and 10 indexed data of array, so when first 9 is matched the total array becomes 9 from total 10 and when again loop repeated 
						//for the 10 index, the index become unavailable. so, the problem is tha we also need to decrease the i size. best solution, use collectino array inside
						//of the to delete array.\
						
						/*
						//alert("apple:"+scheduleCollection.length);
						jQuery.each(scheduleCollection, function(i, schedule){
							alert(JSON.stringify(schedule));
							jQuery.each(scheduleIdToDelete, function(j, schedule_id){
								if(Number(schedule.id)==Number(schedule_id)){
									scheduleCollection.splice(scheduleCollection.indexOf(schedule),1);
									return true;
								}
							});
						});
						*/
						//falied to make delete in local array. above code will throw type error on schedule.
						/*
						
							TypeError: schedule is undefined
							deleteScheduleRowsExtended/</</<()manage_...le.html (line 1521)
							j = 0
							schedule_id = 10
							.each()jquery-....min.js (line 2)
							a = [10, 11]
							b = function(j, schedule_id)
							c = undefined
							deleteScheduleRowsExtended/</<()manage_...le.html (line 1520)
							i = 10
							schedule = undefined
							.each()jquery-....min.js (line 2)
							a = [Object { id=1, vehicle="BA 10 PA 3477", route="Route 1", more...}, Object { id=2, vehicle="BA 11 PA 2327", route="Route 1", more...}, Object { id=3, vehicle="BA 12 PA 6565", route="Route 1", more...}, 7 more...]
							b = function(i, schedule)
							c = undefined
							deleteScheduleRowsExtended/<()manage_...le.html (line 1518)
								

							if(Number(schedule.id)==Number(schedule_id)){

								
							manage_...le.html (line 1521, col 1)

						
						
						//alert(JSON.stringify(scheduleCollection));
						
						deleteRowSchedules(); ///delete the row in the table displayed 					
					
						scheduleIdToDelete = [];		//empty the remove list
					
						$("#loading_1").fadeOut();
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayScheduleDetailAlertMessage()==false){										
						//displaying status message
							$("#schedule_delete_success_message").slideDown().fadeIn();
							$("#schedule_delete_success_message").focus();
							$("#schedule_delete_success_message").blur();
							setTimeout(function(){
								$("#schedule_delete_success_message").slideUp().fadeOut();
							},5000);
						}

					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#schedule_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#schedule_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the schedule details at the moment.");
					$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#schedule_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}*/
				//},2000);
			}
			
			
			
			//This function is executed after the delete schedule ajax.
			function afterDeleteScheduleData(status, scheduleIdToDelete){
					if(status == true){			
						//deleting schedule from the local array.
						
						if(scheduleCollection>0){
							//alert(JSON.stringify(scheduleCollection));
							for(var i=0; i<scheduleIdToDelete.length;i++){
								for(var j=0; i<scheduleCollection.length;j++){
									if(scheduleCollection[j].id==scheduleIdToDelete[i]){
										scheduleCollection.splice(scheduleCollection.indexOf(scheduleCollection[j]),1);
										break;
									}
								}
							};
						}

							deleteRowSchedules(); ///delete the row in the table displayed 					
						
							scheduleIdToDelete = [];		//empty the remove list
						//Why the below doesnot work and above work?
						//Because, whenever a row is deleted in the local array, the array index is shift and next count array becomes unavailable and hence undefined. 
						//for example, if I delete 9 and 10 indexed data of array, so when first 9 is matched the total array becomes 9 from total 10 and when again loop repeated 
						//for the 10 index, the index become unavailable. so, the problem is tha we also need to decrease the i size. best solution, use collectino array inside
						//of the to delete array.\
						
						/*
						//alert("apple:"+scheduleCollection.length);
						jQuery.each(scheduleCollection, function(i, schedule){
							alert(JSON.stringify(schedule));
							jQuery.each(scheduleIdToDelete, function(j, schedule_id){
								if(Number(schedule.id)==Number(schedule_id)){
									scheduleCollection.splice(scheduleCollection.indexOf(schedule),1);
									return true;
								}
							});
						});
						*/
						//falied to make delete in local array. above code will throw type error on schedule.
						/*
						
							TypeError: schedule is undefined
							deleteScheduleRowsExtended/</</<()manage_...le.html (line 1521)
							j = 0
							schedule_id = 10
							.each()jquery-....min.js (line 2)
							a = [10, 11]
							b = function(j, schedule_id)
							c = undefined
							deleteScheduleRowsExtended/</<()manage_...le.html (line 1520)
							i = 10
							schedule = undefined
							.each()jquery-....min.js (line 2)
							a = [Object { id=1, vehicle="BA 10 PA 3477", route="Route 1", more...}, Object { id=2, vehicle="BA 11 PA 2327", route="Route 1", more...}, Object { id=3, vehicle="BA 12 PA 6565", route="Route 1", more...}, 7 more...]
							b = function(i, schedule)
							c = undefined
							deleteScheduleRowsExtended/<()manage_...le.html (line 1518)
								

							if(Number(schedule.id)==Number(schedule_id)){

								
							manage_...le.html (line 1521, col 1)

						*/
						
						//alert(JSON.stringify(scheduleCollection));
						
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayScheduleDetailAlertMessage()==false){										
						//displaying status message
							$("#schedule_delete_success_message").slideDown().fadeIn();
							$("#schedule_delete_success_message").focus();
							$("#schedule_delete_success_message").blur();
							setTimeout(function(){
								$("#schedule_delete_success_message").slideUp().fadeOut();
							},5000);
						}
						
							$("#loading_1").fadeOut();

					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#schedule_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#schedule_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the schedule details at the moment.");
					$("#schedule_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#schedule_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}
			}
			
			
			
			
			
			
			//this function displays modal to ask user to delete the selected rows and then delete.
			function displayScheduleDeleteModal(){				
				var count = 0;
				$("#display_schedule_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');					
						count = count+1;
					}
				});
				if (count==0){					
					$("#alert_modal_title").text("DELETE SCHEDULE");
					$("#alert_modal_content").text("Nothing is selected.");
					$("#alert_modal").modal('show');
				}
				else{
					$("#action_modal_title").text("DELETE SCHEDULE");
					$("#action_modal_content").text("Are you sure want to delete this Schedule detail?");
					$("#action_modal").modal('show');
					$('#action_modal_delete').off();
					$('#action_modal_delete').click(function (e) {
					  // deleting the route rows.
					  deleteScheduleRowsExtended();
					})
				}
			}
			
			//this message either display the empty route table message when there is no route rows to display or table.
			function displayScheduleDetailAlertMessage(){
			//alert($("#display_schedule_table").find("tbody").children().length);
				if($("#display_schedule_table").find("tbody").children().length==0){
					$("#display_schedule_message_title").text("Schedules un-available.");						
					$("#display_schedule_message_detail").text("There is nothing to display. Please, add a new Schedule details. Your added details will be displayed here.");	
					$("#display_schedule_message_alert").fadeIn();	
					//cancel button unhide the table so hiding table below it.
					//cancelRouteDeleteOption();	
					setTabHeader("CURRENT SCHEDULES", " List of currently available Schedules.");	
					//$("#temp_route_heading_title").text("CURRENT ROUTE");
					//$("#temp_route_heading h3 small").text("List of currently available routes.");
					removeCheckBoxInTable();
					$("#delete_schedule_apply_and_cancel_buttons").hide();
					$("#display_schedule_schedule_delete_select_all_checkbox").hide();
					
					enableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
				
					$("#display_schedule_table").hide();
					return true;
				}	
				else{
					$("#display_schedule_message_alert").css({
						display:"none"
					});	
					$("#display_schedule_table").fadeIn();
					return false;
				}
			}
			
			
			//##############SORT SECTION#######################################################
			function sortTable(){
				var route = [];
				var vehicle = [];
				var time = [];
				jQuery.each(scheduleCollection, function(i, schedule){
					//alert(oldSchedule.vehicle+deletedSchedule.vehicle + oldSchedule.route+deletedSchedule.route + oldSchedule.time+deletedSchedule.time);
						route.push(schedule.route+"-"+schedule.vehicle+"-"+schedule.time);
						vehicle.push(schedule.vehicle+"-"+schedule.route+"-"+schedule.time);
						time.push(schedule.time+"-"+schedule.route+"-"+schedule.vehicle);
						//time.push(schedule.time);
				});
				
				var sortedRoute = route.sort();
				var sortedVehicle = vehicle.sort();
				var sortedTime = time.sort();
				
				//alert($("schedule_display_sort_table_dropdown option:selected").val());
				if($("#schedule_display_sort_table_dropdown option:selected").text()=="Default"){
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();
						$("#display_schedule_table tbody").empty();
						//adding data to page table
						jQuery.each(scheduleCollection, function(i, schedule){
							//stopsName.push(route.stops);
							loadScheduleDataToTable(schedule.vehicle, schedule.route, schedule.time);						
						});	
						changeDefaultTextColorOfRouteRow();
					},300);
				}
				else if($("#schedule_display_sort_table_dropdown option:selected").text()=="Route"){
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();
						$("#display_schedule_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedRoute, function(i, schedule){
							//stopsName.push(route.stops);
							var data = schedule.split("-");
							loadScheduleDataToTable(data[1], data[0], data[2]);						
						});
						changeDefaultTextColorOfRouteRow();
					},300);				
				}
				else if($("#schedule_display_sort_table_dropdown option:selected").text()=="Vehicle"){	
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();									
						$("#display_schedule_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedVehicle, function(i, schedule){
							//stopsName.push(route.stops);
							var data = schedule.split("-");
							loadScheduleDataToTable(data[0], data[1], data[2]);						
						});
						changeDefaultTextColorOfRouteRow();
					},300);			
				}
				else if($("#schedule_display_sort_table_dropdown option:selected").text()=="Time"){	
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();							
						$("#display_schedule_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedTime, function(i, schedule){
							//stopsName.push(route.stops);
							var data = schedule.split("-");
							loadScheduleDataToTable(data[1], data[2], data[0]);						
						});
						changeDefaultTextColorOfRouteRow();
					},300);						
				}
			}
			
			
			//This function filters the table
			function filterTable(){
				var selected = $("#schedule_display_filter_table_dropdown option:selected").text();
				//alert(selected);
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();
						$("#display_schedule_table tbody").empty();
						//adding data to page table
						jQuery.each(scheduleCollection, function(i, schedule){
							//stopsName.push(route.stops);
							if(schedule.route == selected){								
								loadScheduleDataToTable(schedule.vehicle, schedule.route, schedule.time);	
							}
							else if(selected=="Default"){
							
								loadScheduleDataToTable(schedule.vehicle, schedule.route, schedule.time);
							}
						});	
						changeDefaultTextColorOfRouteRow();
						
						displayFilterStatusMessage();
					},300);
				//}
			}
			
			function displayFilterStatusMessage(){
			//alert($("#display_schedule_table tbody").children().length);
				if($("#display_schedule_table tbody").children().length<1){
					$("#schedule_add_timeout_error_message_header").text("NOT AVAILABLE.");
					$("#schedule_add_timeout_error_message_detail").text(" No schedules are available for this to display in the table below.");
					$("#schedule_add_timeout_error_message").slideDown().fadeIn();	
					setTimeout(function(){						
						$("#schedule_add_timeout_error_message").slideUp().fadeOut();	
					},4000);
				}
			}
			
			


	  </script>	  
   </body>
</html>