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
                              <li><a id="target" href="#">Manage Vehicles</a></li>
                              <li><a href="#">Manage Vehicles</a></li>
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
			  <li class="active" >Vehicle</li>
			</ol>

		</div>


          <ul class="nav nav-sidebar" style="padding:2px">
            <li><a style="color:#000; font-weight:bold;border-top:1px solid rgba(0,0,0,0.3)" href="manage.html">Overview <span class="sr-only">(current)</span></a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-route">MANAGE ROUTE</a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-schedule">MANAGE SCHEDULE</a></li>
            <li class="active"><a style="font-weight:bold; background:none;color:#000;border:1px solid #9E9E9E"href="#">MANAGE VEHICLE</a></li>
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
					<li role="presentation" class="active"><a id="vehicle_tab_header" id="vehicles" href="#vehicles_tab" aria-controls="vehicles_tab" role="tab" data-toggle="tab" style="height:36px; padding:8px">VEHICLE</a></li>

					<!--add, edit and delete buttons-->
					<div class="btn-group" role="group" aria-label="..." style="float:right;margin-right:18px; margin-top:2px">
					  <button id="add_button" data-toggle="tooltip" data-placement="bottom" title="Add" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Add new Vehicle Details"><span class="glyphicon glyphicon-plus"></span></button>
					  <button id="edit_button" data-toggle="tooltip" data-placement="bottom" title="Edit" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Edit and update existing Vehicle Details"><span class="glyphicon glyphicon-edit"></span></button>
					  <button id="delete_button" data-toggle="tooltip" data-placement="bottom" title="Delete" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Delete all or particular Vehicle Details"><span class="glyphicon glyphicon-trash"></span></button>
					</div>
					</ul>
					</div>
					
					
					<!-- Tab panes to display detail content-->
				<div id ="tab_pane" class="tab-content container-fluid" style="height:100%; width:100%">

								
				<!--title for the content pane for tab. which will be switched accordingly. also this div is fixed.-->
				<div class="page-header row-fluid" style=" height:32px;padding-left:18px;padding-right:18px; padding-bottom:0px; margin-bottom:0px; margin-top:-12px">
				<div id="content_header">
				  <h3><span style="color:#4CAF50" id="content_header_title">CURRENT VEHICLES</span><small id="content_header_subtitle"> List of currently available vehicles.</small>
					 

					 <!--Refresh Button-->
					  <button id="content_header_button_refresh" type="button" class="btn btn-sm"  style="display:nones; background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:24px;width:80px; margin-top:2px" onClick="refresh()">
					  <span id="content_header_icon_refresh" class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Refresh
					  </button>		
					  
					<!--Sort section-->
					<div id="sort_table" class="input-group" style="padding:0px;margin:0px; float:right; width:120px; margin-right:8px; margin-top:2px">
							<span class="input-group-addon" style="height:24px; padding:4px;margin:0px; font-weight:normal font-size:12px; background:none">Sort</span>
							  <select id="vehicle_display_sort_table_dropdown" style="height:24px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list." onChange="sortTable()">
								<option value="1">Default</option>
								<option value="2">Name</option>
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
				
				<!--add edit vehicle section-->
				<div class="container-fluid col-md-12" style="padding-left:48px; padding-right:48px; margin-top:12px">
				
					<!--Add new vehicle status message section-->				
					<div id="add_vehicle_submit_message_alert" class="alert in fade alert-success col-md-12" style="padding:12px; padding-left:18px;display:none; background:nosne; border:1px solid #BDBDBD; height:">
						<h3 style="color:#595959;"><span style="color:#4CAF50" id="add_vehicle_submit_message_alert_title">ADD SUCCESSFUL.</span>
						<small id="add_vehicle_submit_message_alert_details"> You have successfully added a new vehicle details. </small>
						
							<button  id="vehicle_add_success_exit" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:6px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">EXIT</button>
							
							<button  id="vehicle_add_success_add_again" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:18px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">ADD NEW</button>
						</h3>
					</div>
										
						<!--no route or vehicle available error, duplicate add entry error message-->
						<div id="vehicle_add_timeout_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong id="vehicle_add_timeout_error_message_header">WARNING.</strong><small id="vehicle_add_timeout_error_message_detail"> Cannot add the new Vehicle at the moment. Currently, no Vehicles and Route information ara available to display.</small></div>
						
					<!--add new Vehicle section-->
					<div id="vehicle_add_edit_section" class="panel panel-default col-md-12" style="padding:0px;border:1px solid #BDBDBD;display:none; height:96px">		
					<div class="panel-heading" style="height:28px; padding:4px; text-align:center; background:none;background-color:#424242;color:#CCC">ADD NEW VEHICLE</div>
					<div class="panel-body" style="padding:6px; margin-top:12px; font-size:12px">
						
						
						
						<div class="form-group row-fluid  col-md-9" style="padding:0px;padding-left:4px; padding-right:4px; margin-right:-24px">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div  class="input-group" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="padding:0px;margin:0px; font-weight:normal font-size:12px; color:#000; padding:6px">VEHICLE NAME</span>
								   <input id ="add_edit_vehicle_form_name_input" style="height:28px; font-size:12px;color:#000" type="text" class="form-control" placeholder="Enter Vehicle Name" aria-describedby="basic-addon1">
								</div>
						</div>

						
						
						<div class="form-group row-fluid col-md-3" style="padding:0px;padding-left:6px; margin-left:8px">							
							<!--reset button-->
							<button id="vehicle_add_edit_reset_button" type="button" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Reset" style="float:left; margin-left:8px; padding:4px; background:none; border:1px solid #9E9E9E; height:28px;width:28px" onClick="">
							  <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
							</button>
							
							
							<!--save and cancel button for edit/delete mode vehicle edit mode-->			
							<button id="vehicle_add_edit_exit_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; margin-right:-16px; background:none; border:1px solid #9E9E9E;height:28px;width:86px; margin-left:4px; margin-right:-12px" onClick="">
							  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
							</button>
							
							<button id="vehicle_add_edit_add_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; background:none; border:1px solid #9E9E9E; height:28px;width:86px" onClick="">
							  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <span id="vehicle_add_edit_form_submit_button">UPDATE</span>
							</button>
							
							<!--submit animation logo-->
							<span id="vehicle_add_edit_loading_icon" data-toggle="tooltip" data-placement="bottom" title="Loading..." style="display:none; float:right; margin-right:8px;margin-top:2px"><img src="${actionLoadingIcon}" height="24" width="24"></span>	
							
										
						</div>	
			 						
					  </div>						
					</div>
				</div>
				
				<!--#####################################################################################################################################-->
				<!--Tab main content-->
				<!--#####################################################################################################################################-->
				<div role="tabpanel" class="tab-pane fade in active" id="vehicles_tab" style="height:100%; width:100%;  padding-left:56px; padding-right:56px;overflow-y:hidden!important; margin-top:-12px">
				
				<span id="vehicle_tab_span_container">  <!--This span is used for hiding the section when reloading or loading-->
				
				<div style="height:12px; width:100%"></div>		<!--Just to fill gap of 12px between header and content pane-->
				

				<!--this is temporary heading for vehicle display when add vehicle form appears-->
				<div id="temp_vehicle_heading" class="page-header row-fluid col-md-12" style="display:none;padding:0px; margin-bottom:2px; margin-top:-12px">
				  <h3 style="margin:0px"><span id="temp_vehicle_heading_title" style="color:#4CAF50">CURRENT VEHICLES</span> <small> List of currently available vehicles. </small>			
				  </h3>
				</div>
				
				
				<!--Vehicle table list section-->
				<div class="col-md-12 container-fluid" style="padding:0px;font-family:Arial, Helvetica, sans-serif; font-size:12px; height:100%; width:100%;overflow-y:auto!important">

			
			<!--Display message when there is no-vehicle to display in table.-->
			  <div id="display_vehicle_message_alert" class="alert in fade alert-success col-md-9" role="alert" style="display:none;background:none; border:1px solid #595959">
				<h2 style="color:#595959;"><span style="color:#4CAF50" id="display_vehicle_message_title">Vehicle not Available.</span><small id="display_vehicle_message_detail">There is nothing to display. Please, add a new vehicle details. Your added details will be displayed here.</small></h2>
				
			</div>
			
			
									  	
					<!--Save edit vehicle detail status message-->				
				 <div id="vehicle_save_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Successful.</strong><small> New changes to the selected vehicle has been successfully updated.</small></div>
				 <div id="vehicle_save_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Failed.</strong><small> Something went wrong. New changes to the selected vehicle cannot be made at the moment.</small></div>
				 <div id="vehicle_save_already_saved_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Unable to Save.</strong><small> No modification has been made to any vehicle details or changes are already saved.</small></div>
				 
				
				
			 <!--delete vehicle detail status message-->				
			 <div id="vehicle_delete_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Successful.</strong><small> Selected Vehicles has been successfully deleted.</small></div>
			 <div id="vehicle_delete_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Failed.</strong><small> Something went wrong. Deletion to the selected Vehicles cannot be made at the moment.</small></div>
			 
			 
			 
			
			<div id="main_table_container" style="width:80%; margin:auto; overflow-y:auto!important"">


			<!--Delete vehicle check box to select all-->	
			<div id="display_vehicle_vehicle_delete_select_all_checkbox" style="display:none; width:94px"><div style="float:left; margin-top:3px;font-weight:bold">SELECT ALL: </div><div style="float:right"><input id="vehicle_delete_select_all_checkbox" type="checkbox" aria-label="..." onClick="selectAllCheckBox()"></div></div>
			
			
			
		  <table class="table table-condensed table-striped table-bordered" id="display_vehicle_table" style="display:none">
            <thead>
              <tr style="height:28px; background-color:#424242;color:#CCC">
                <th style="text-align:center" width="4%">SN</th>
                <th style="text-align:center"width="85%">VEHICLE NAME</th>				
              </tr>
            </thead>
            <tbody>
             <!--<tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Vehicle 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>
             <tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Vehicle 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>-->
			  </tbody>
			  </table>
			  
			  			<!--Delete button-->
			  <div id="delete_vehicle_apply_and_cancel_buttons" style="display:none; margin-bottom:6px; margin-top:-6px">
			  <hr>
			  	<button id="delete_vehicle_button" type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;height:32px; width:96px">
				  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DELETE
				</button>
				
				 <!--delete option close/cancel button-->
			  	<button type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;margin-left:5px; height:32px; width:96px" onClick="cancelVehicleDeleteOption()">
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
			setTabHeader("CURRENT VEHICLES", " List of currently available Vehicles.");
			//activateHeaderButton("refresh");  //initially setting refresh button
			
			//if the + button on top clicked show the add route form.
			$("#add_button").click(function(){
				openAddVehicleForm();
				//making form unfocused so that blue color edege will not seen.
				$("#vehicle_add_edit_section").blur();
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
				$("#display_vehicle_table").fadeIn();
			},600);*/
			
			//misc. just to hide to foucs effect on form.
			$("#vehicle_add_edit_section").click(function(){
				$("#vehicle_add_edit_section").blur();
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
				//$("#vehicle_tab_span_container").hide();
				//setTimeout(function(){				
					//$("#vehicle_tab_span_container").fadeIn();		
					//emptying the local array first.
					vehicleCollection = [];		
					
					//emptying the table row.
					$("#display_vehicle_table tbody").empty();
					
					//now loading the data.
					loadVehicleData();
					//$("#loading_1").fadeOut();			
				//},2000);				
			}
			
			//####################################################LOAD DATA ##############################################################
			
			//example data.
			var vehicle1 = {name:"BA 10 PA 3470"};
			var vehicle2 = {name:"BA 10 PA 3471"};
			var vehicle3 = {name:"BA 10 PA 3472"};
			var vehicle4 = {name:"BA 10 PA 3473"};
			var vehicle5 = {name:"BA 10 PA 3474"};
			var vehicle6 = {name:"BA 10 PA 3475"};
			var vehicle7 = {name:"BA 10 PA 3499"};
			var vehicle8 = {name:"BA 10 PA 3477"};
			var vehicle9 = {name:"BA 10 PA 3478"};
			var vehicle10 = {name:"BA 10 PA 3479"};
			var vehicle11 = {name:"BA 10 PA 3480"};
			
			
			
			//this variable array holds the all the route data retrived from the server. also added updated and deleted route will be updated here as well
			var vehicleCollection = [];	
			
			
			//this function get the route list when the page is first loaded.\\\
			function loadVehicleData(){
				//loading from server code here  example is route 1 route 2 and route 3 and route 4
				
				//vehicleCollection.push(vehicle1,vehicle2,vehicle3,vehicle4,vehicle5,vehicle6,vehicle7,vehicle8,vehicle9,vehicle10,vehicle11);
				//vehicleCollection.push(vehicle1,vehicle2,vehicle3,vehicle4,vehicle5,vehicle6,vehicle7,vehicle8,vehicle9,vehicle10,vehicle11);
				
				$("#loading_1").fadeIn();	
				$("#display_vehicle_table").hide();
				
				console.log("loading vehicle data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "load_vehicle_data",
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS LOADING VEHICLE DATA");
							//updateRouteServerStatus = status;
							vehicleCollection = data;
							
							if (vehicleCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_vehicle_message_alert").fadeIn();	
								$("#display_vehicle_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(vehicleCollection, function(i, vehicle){
									//stopsName.push(route.stops);
									loadVehicleDataToTable(vehicle.name);						
								});	
									
								//making the table font color to black since it is changed by to blue by loadVehicleDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_vehicle_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_vehicle_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
									$("#display_vehicle_table").fadeIn();
								//},600);
							}
				
				
						},
						error : function(e) {
							console.log("ERROR WHILE LOADING VEHICLE DATA");
							//updateRouteServerStatus = false;	
							afterAddRouteWayData(false, routeRow);	
							vehicleCollection = [];	

							if (vehicleCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_vehicle_message_alert").fadeIn();	
								$("#display_vehicle_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(vehicleCollection, function(i, vehicle){
									//stopsName.push(route.stops);
									loadVehicleDataToTable(vehicle.name);						
								});	
									
								//making the table font color to black since it is changed by to blue by loadVehicleDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_vehicle_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_vehicle_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
									$("#display_vehicle_table").fadeIn();
								//},600);
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
			loadVehicleData();
			
			//#############################################################################################
			//#SERVER INTERACTTION CODES

			function addVehicleToServer(vehicleName){
				console.log("Adding new vehicle data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "save_vehicle_data",
						data : vehicleName,
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS ADDING ROUTE WAY DATA");
							//updateRouteServerStatus = status;
							afterAddVehicleData(true, vehicleName);
						},
						error : function(e) {
							console.log("ERROR WHILE ADDING ROUTE WAY DATA");
							//updateRouteServerStatus = false;	
							afterAddVehicleData(false, vehicleName);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}	


			function updateVehicleToServer(updatedVehicles){
				console.log("Updating new vehicle data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "update_vehicle_data",
						data : JSON.stringify(updatedVehicles),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS UPDATING VEHICLE DATA");
							//updateRouteServerStatus = status;
							afterUpdateVehicleData(true, updatedVehicles);
						},
						error : function(e) {
							console.log("ERROR WHILE UPDATING VEHICLE DATA");
							//updateRouteServerStatus = false;	
							afterUpdateVehicleData(false, updatedVehicles);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}


			function deleteVehicleToServer(toDeleteVehicles){
				console.log("Deleting new vehicle data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "delete_vehicle_data",
						data : JSON.stringify(toDeleteVehicles),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS DELETING VEHICLE DATA");
							//updateRouteServerStatus = status;
							afterDeleteVehicleData(true, toDeleteVehicles);
						},
						error : function(e) {
							console.log("ERROR WHILE DELETING VEHICLE DATA");
							//updateRouteServerStatus = false;	
							afterDeleteVehicleData(false, toDeleteVehicles);						
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
			function loadVehicleDataToTable(vehicleName){
				var index = $("#display_vehicle_table tbody").children().length;
				index = parseInt(index)+1;
				//adding to the table list.
				$("#display_vehicle_table tbody").append('<tr style="padding:0px; height:auto; color:#673AB7; font-size:11.5px" tabindex="1"><td style="height:24px">'+index+'</td><td style="text-align:center">'+vehicleName+'</td></tr>');
			}
			
			//this function removes or clears the dropdown.
			
			
			//##############ADD NEW SCHEDULE #######################################################
			
			
			
			//this funciton is triggered when user click the add button in top right corner option panel.
			//this funciton shows the add form
			function openAddVehicleForm(){
				$("#vehicle_add_edit_section").slideDown().fadeIn();				
				$("#temp_vehicle_heading").fadeIn();
				disableAddEditDeleteButtons();	
				setTabHeader("ADD VEHICLE"," Add a new Vehicle details.");
				$("#content_header_button_refresh").attr("disabled", true);		//refresh button
				$("#sort_table").css({"pointer-events":"none"});		//sort button			
				$("#display_vehicle_table").css({'pointer-events':'none','filter':'alpha(opacity=60)', 'opacity':'0.6'});
								
				$("#vehicle_add_edit_form_submit_button").text("ADD");			//this button is used for update as well. so ensureing it is displayed ADD .

				
				//adding click event on add button
				$("#vehicle_add_edit_add_button").off();
				$("#vehicle_add_edit_add_button").on('click', function(){
						addVehicle();
				});
				
				//adding click event on exit button
				$("#vehicle_add_edit_exit_button").off();
				$("#vehicle_add_edit_exit_button").on('click', function(){
					exitAddEditVehicleForm();
					
					$("#vehicle_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route vehicle available
				});	
				//adding click event on reset button
				$("#vehicle_add_edit_reset_button").on('click', function(){
					resetForm();
				});					
			}
			
			
			//reset add edit vehicle fomr
			function resetForm(){				
				$("#add_edit_vehicle_form_name_input").val("");
			}
			
			//this function add the vehicle details. it is triggeded by add button of add vehicle form
			function addVehicle(){
				var vehicleName = $("#add_edit_vehicle_form_name_input").val();
				//alert(vehicleName);
				
				if(vehicleName=="" || vehicleName==null){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Vehicle. Vehicle name is not entered. Please, select enter a vehicle name and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(vehicleName)==true){
					//alert(checkForDuplicateEntry(route,vehicle,hour, min));
					$("#vehicle_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#vehicle_add_edit_loading_icon").fadeOut();					
						$("#vehicle_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#vehicle_add_timeout_error_message_detail").text(" The vehicle information is already exist. Please, provide non-duplicate data and add it.");
						$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{					
					$("#vehicle_add_edit_loading_icon").fadeIn();
					//setTimeout(function(){
							
							//##########################################################
							//Now sent the data to the server.
							//sending time in the form of 1212 not separated as 12:12. 
							addVehicleToServer(vehicleName);
							
							//#######################################################

						
							//var serverStatus = false;
							//error example
							//var errormessage = "Duplicate Vehicle. The vehicle is already added on the list.";
							//var returnSameObjectWithId = {id:1212, vehicle:"BA 10 PA 3477", route:"Route 1", time:"12:15"};  //or only download id.
							//so that new data will be stored in local array with id.
							
							//now add this object to the vehicleCollection;
							//#######################################################
							
							//if the returned id is null or server failed.
							
							
							/*if(serverStatus==true){
								//adding the data to local array
								//the id will be downloaded from the server.												//above id will be added here.
								vehicleCollection.push({name:vehicleName});
								alert(JSON.stringify(vehicleCollection));
								//adding to the table
								loadVehicleDataToTable(vehicleName);
								
								////////////////////////////////////////////////////
								
								//the display successful message.
								$("#add_vehicle_submit_message_alert").fadeIn();
								$("#vehicle_add_edit_section").hide();

								//adding event listener to add again button.
								$("#vehicle_add_success_add_again").on('click',function(){						
									$("#add_vehicle_submit_message_alert").slideUp().fadeOut();
									openAddVehicleForm();
								});
								
								//adding click listener to exit button.
								$("#vehicle_add_success_exit").on('click',function(){						
									$("#add_vehicle_submit_message_alert").slideUp().fadeOut();
									exitAddEditVehicleForm();
								});
							}
							else{
								/*if(errormessage!=""){
									$("#vehicle_add_server_error_message_detail").text(errormessage);
									$("#vehicle_add_server_error_message2").slideDown().fadeIn();
									setTimeout(function (){						
										$("#vehicle_add_server_error_message2").slideUp().fadeOut();
									},4000);
								}
								//else{
									//display error message. may be server error or system error.
									$("#vehicle_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
									$("#vehicle_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the vehicle details at the moment.");
									$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
									setTimeout(function(){
										$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
									},4000);
								//}
							}*/						
						//},2000);							
				}
			}
			
			
			//This function is executed after add vehicle ajax executed.
			function afterAddVehicleData(status, vehicleName){
				if(status==true){
					//adding the data to local array
					//the id will be downloaded from the server.												//above id will be added here.
					vehicleCollection.push({name:vehicleName});
					alert(JSON.stringify(vehicleCollection));
					//adding to the table
					loadVehicleDataToTable(vehicleName);
					$("#display_vehicle_message_alert").hide();	
					
					$("#display_vehicle_table").fadeIn();
					
					////////////////////////////////////////////////////
					
					//the display successful message.
					$("#add_vehicle_submit_message_alert").fadeIn();
					$("#vehicle_add_edit_section").hide();

					//adding event listener to add again button.
					$("#vehicle_add_success_add_again").on('click',function(){						
						$("#add_vehicle_submit_message_alert").slideUp().fadeOut();
						openAddVehicleForm();
					});
					
					//adding click listener to exit button.
					$("#vehicle_add_success_exit").on('click',function(){						
						$("#add_vehicle_submit_message_alert").slideUp().fadeOut();
						exitAddEditVehicleForm();
					});
				}
				else{
					//display error message. may be server error or system error.
					$("#vehicle_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#vehicle_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the vehicle details at the moment.");
					$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
					},4000);
					//}
				}
				
				$("#vehicle_add_edit_loading_icon").fadeOut();
				resetForm();	
			}
			
			//this function exit the vehicle details. it is triggeded by exit button of add/edit vehicle form
			function exitAddEditVehicleForm(){	
				resetForm();
				$("#vehicle_add_edit_section").slideUp("slow").fadeOut("slow");
				$("#temp_vehicle_heading").hide();
				enableAddEditDeleteButtons();	
				setTabHeader("CURRENT VEHICLES"," List of currently available Vehicles.");
				$("#content_header_button_refresh").attr("disabled", false);					
				$("#display_vehicle_table").css({'pointer-events':'auto','filter':'alpha(opacity=100)', 'opacity':'1'});
				$("#sort_table").css({"pointer-events":"auto"});		//sort button	
			}
			
			
			//this method check for duplicate data during adding or updating vehicle details
			function checkForDuplicateEntry(vehicleName){
				var isDuplicate = false;
				for(var i=0; i<vehicleCollection.length;i++){
					//alert(vehicleCollection[i].route+route + vehicleCollection[i].vehicle+vehicle +Number(time[0])+Number(hour) + Number(time[1])+Number(min));
					if(vehicleCollection[i].name==vehicleName){
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
					var original_table = $("#display_vehicle_table").clone();		//clonning original table
					
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_vehicle_table").find("tbody").children().length==0){
					$("#display_vehicle_table").hide();				
					$("#display_vehicle_message_alert").hide();	
					$("#display_vehicle_message_title").text("Edit un-available.");						
					$("#display_vehicle_message_detail").text("Currently, no Vehicles are available to edit.");	
					$("#display_vehicle_message_alert").slideDown().fadeIn();	
					setTimeout(function(){
						$("#display_vehicle_message_alert").slideUp().fadeOut();						
						$("#display_vehicle_message_title").text("Vehicles un-available.");						
						$("#display_vehicle_message_detail").text("There is nothing to display. Please, add a new vehicle details. Your added details will be displayed here.");
						$("#display_vehicle_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{			
					$("#display_vehicle_table").hide();											
					$("#loading_1").fadeIn();	
					
					//removing previous events bind to this buttons					
					$("#content_header_button_exit").off();
					$("#content_header_button_save").off();
					
					//hiding tefresh, sort and filters					
					$("#content_header_button_refresh").hide();
					$("#sort_table").hide();		//sort button
					
					//hiding buttons to imitate fade in effect
					$("#content_header_button_exit").hide();
					$("#content_header_button_save").hide();
					//adding click listener to save button.
					$("#content_header_button_save").off();
					$("#content_header_button_save").click(function(){
						saveUpdatedVehicleDetail();
						saveStatus = true;
					});
					$("#content_header_button_exit").click(function(){
						$("#loading_1").fadeIn();					
						$("#display_vehicle_table").hide();
						
						//reverting to original table on exit if changes are not saved.
						if(saveStatus==false){
							$("#display_vehicle_table").replaceWith(original_table);
						}
						cancelVehicleEditOption();
						setTimeout(function(){					
							$("#display_vehicle_table").fadeIn(100);
							$("#loading_1").hide();
						},600);
					});
					//setting the header					
					setTabHeader("EDIT VEHICLE"," Please, click on edit button of any row to edit its details.");
					
					addEditButtonOnVehicleTable();
					disableAddEditDeleteButtons();
					$("#loading_1").fadeIn();
					setTimeout(function(){	
						$("#content_header_button_exit").fadeIn();	
						$("#content_header_button_save").fadeIn();							
						$("#display_vehicle_table").fadeIn(100);
						$("#loading_1").hide();
					},600);
				}
			}
			
		
		//this function add the edit button on each row of the table
		function addEditButtonOnVehicleTable(){
			$("#display_vehicle_table thead tr").append('<th width="12%"style="text-align:center">ACTION</th>');
			$("#display_vehicle_table tbody tr").append('<td height="24" style="margin:0px; padding:4px"><button type="button" class="btn btn-sm" style="padding:2px; font-size:11px;height:24px; margin:0px; width:100%; background:none; border:1px solid #424242" onclick="displayEditForm(this)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> EDIT </button></td>');	
		}
		
		//this function removes the edit button on each row of the table
		function removeEditButtonOnVehicleTable(){					
			$("#display_vehicle_table thead tr th:nth-child(3)").remove();
			$("#display_vehicle_table tbody tr td:nth-child(3)").each(function(){
				$(this).remove();
			});	
		}
		
		//this function cancel the vehicle edit option
		function cancelVehicleEditOption(){							//emptying the updated value.
				updated_Vehicles = [];
				
				$("#loading_1").fadeIn();
				$("#display_vehicle_table").hide();
				
				setTabHeader("CURRENT VEHICLES", " List of currently available Vehicles.");
				
				removeEditButtonOnVehicleTable();
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
		
		//when user click a row edit button, the system will get first vehicle id from the local array and will be used to add with updated data. the updateVehicle array.
		//the process to update\
			//>>>> First, set to edit mode.
			//>>>> Then click to edit button
			//>>>> Then open the form. 
			//>>>> The vehicleIdtoUpdate is the retrieved from the local array and then stored untill the next edit form is triggered. then , this will replaced.
			//>>>> Then when user close and save, this id is used and stored to UpdatedVehicle array along with updated value.
			//>>>> later this array is send to server to make changes.
			//>>>> Program complete.
			
		//this variable holds the original id of the vehicle that will be updated when edit form is displayed.
		var vehicleToBeUpdated = null;
		
		//This function displays the edit form when edit button is clicked
		function displayEditForm(row){
			var vehicleName = $(row).parent().parent().find("td:nth-child(2)").text();
			
			//setting the original vehicle name 
			vehicleToBeUpdated = vehicleName;

									
			openEditVehicleForm(row, vehicleName);			
		}
		
		
					
			//this funciton is triggered when user click the edit button in top right corner option panel.
			//this funciton shows the add form
			function openEditVehicleForm(row, vehicleName){
				//highlightling the selected row				
				//$(row).parent().parent().css({"background":"#EEEEEE"});	
				$(row).parent().parent().focus();
				
				$("#vehicle_add_edit_section").slideDown().fadeIn();
								
				$("#vehicle_add_edit_form_submit_button").text("UPDATE");			//this button is used for update as well. so ensureing it is displayed ADD .
								
					//adding click event on add button
					$("#vehicle_add_edit_add_button").off();
					$("#vehicle_add_edit_add_button").on('click', function(){
							//alert();
							updatVehicle($(row));
					});
				//adding click event on exit button``
				$("#vehicle_add_edit_exit_button").off();
				$("#vehicle_add_edit_exit_button").on('click', function(){					
					$("#vehicle_add_edit_section").slideUp().fadeOut();
					resetForm();
					
					$("#vehicle_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route vehicle available
				});	
				//adding click event on reset button
				$("#vehicle_add_edit_reset_button").on('click', function(){
					resetForm();
				});			
				$("#add_edit_vehicle_form_name_input").val(vehicleName);
			}
			
			
	
			//This function writes updated routes details to the edit mode table which will later saved after save button clicked.
			function updatVehicle(row){				
				var vehicleName = $("#add_edit_vehicle_form_name_input").val();	

				if(vehicleName=="" || vehicleName==null){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot update the Vehicle. Vehicle name is not entered. Please, select enter a vehicle name and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(vehicleName)==true){
					//alert(checkForDuplicateEntry(route,vehicle,hour, min));
					$("#vehicle_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#vehicle_add_edit_loading_icon").fadeOut();					
						$("#vehicle_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#vehicle_add_timeout_error_message_detail").text(" The vehicle information is already exist. Please, provide non-duplicate data and add it.");
						$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{
					$("#vehicle_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#vehicle_add_edit_loading_icon").fadeOut();
						$(row).parent().parent().find("td:nth-child(2)").text(vehicleName);
						
						$(row).parent().parent().css({"color":"#673AB7","font-weight":"bold"});	
						
						$("#vehicle_add_edit_section").slideUp().fadeOut();
						$(row).parent().parent().focus();
						
						resetForm();
						//now adding to the update array
						updated_Vehicles.push({oldName:vehicleToBeUpdated, name:vehicleName});
					},600);				
				}
			}
			
		
		//this variable is to store as collection of all route details individual array.
		var updated_Vehicles = [];
		
		//This function saves all the updated vehicles details to the database server.
		function saveUpdatedVehicleDetail(){
			if(updated_Vehicles.length==0){					
				$("#vehicle_save_already_saved_error_message").slideDown().fadeIn();
				setTimeout(function(){
					$("#vehicle_save_already_saved_error_message").slideUp().fadeOut();
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
						
						
						//updated_Vehicles need to send to serve.rad
						
						updateVehicleToServer(updated_Vehicles);
						
						
						//###################################################################################						
						
						/*if(serverStatus==true){
							$("#vehicle_save_success_message").slideDown().fadeIn();
							$("#vehicle_save_success_message").focus();
							$("#vehicle_save_success_message").blur();
							
							setTimeout(function(){
								$("#vehicle_save_success_message").slideUp().fadeOut();
							},5000);
							
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfRouteRow();
							
							//alert("apple");
							//modify the changes from the local array too.
							jQuery.each(updated_Vehicles, function(i,updated_vehicle){
								jQuery.each(vehicleCollection, function(i,old_vehicle){
									if(old_vehicle.name==updated_vehicle.old_name){
										old_vehicle.name=updated_vehicle.new_name;
										return true;
									}
								});
							});
							//delete updated routes array collection
							updated_Vehicles = [];
							//alert();
							//alert(JSON.stringify(vehicleCollection));
							
				
							//jQuery.each(updated_Vehicles, function(i, val){						
							//alert(i+" , "+val.name+" , "+val.stops);
							
							//re-enabling the save or exit button during saving data
							$("#content_header_button_save").prop("disabled",false);
							$("#content_header_button_exit").prop("disabled",false);
							//disabling the loading animation				
							$("#content_header_loading_icon").fadeOut();
							
						}
						else{
							$("#vehicle_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#vehicle_save_danger_message").slideUp().fadeOut();
							},5000);
						}*/
					//});
					
					
					
					
				//},2000);
			}
		}
		
		
		//This function is triggered after update ajax finished.
		function afterUpdateVehicleData(status, updated_Vehicles){
									
						if(status==true){
							$("#vehicle_save_success_message").slideDown().fadeIn();
							$("#vehicle_save_success_message").focus();
							$("#vehicle_save_success_message").blur();
							
							setTimeout(function(){
								$("#vehicle_save_success_message").slideUp().fadeOut();
							},5000);
							
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfRouteRow();
							
							//alert("apple");
							//modify the changes from the local array too.
							jQuery.each(updated_Vehicles, function(i,updated_vehicle){
								jQuery.each(vehicleCollection, function(i,old_vehicle){
									if(old_vehicle.name==updated_vehicle.old_name){
										old_vehicle.name=updated_vehicle.new_name;
										return true;
									}
								});
							});
							//delete updated routes array collection
							updated_Vehicles = [];
							//alert();
							//alert(JSON.stringify(vehicleCollection));
							
				
							//jQuery.each(updated_Vehicles, function(i, val){						
							//alert(i+" , "+val.name+" , "+val.stops);
							
							//re-enabling the save or exit button during saving data
							$("#content_header_button_save").prop("disabled",false);
							$("#content_header_button_exit").prop("disabled",false);
							//disabling the loading animation				
							$("#content_header_loading_icon").fadeOut();
							
						}
						else{
							$("#vehicle_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#vehicle_save_danger_message").slideUp().fadeOut();
							},5000);
						}
		}
			
			//this function revert back the text color to default black which has been changed in edit mode after update.
			function changeDefaultTextColorOfRouteRow(){
				$("#display_vehicle_table tbody tr").each(function(){
					$(this).css({"font-weight":"normal", "color":"#424242"});
				});
			}
			
			
			
			//##############DELETE SECTION#####################################################
			
			
			
			//this function display the delete option
			function displayDeleteOption(){
				//<!--if there is no route available then delete mode must is unavailable-->
				if($("#display_vehicle_table").find("tbody").children().length==0){
					$("#display_vehicle_table").hide();
					
					$("#display_vehicle_message_alert").hide();	
					$("#display_vehicle_message_title").text("Delete un-available.");						
					$("#display_vehicle_message_detail").text("Currently, no vehicles are available to delete.");	
					$("#display_vehicle_message_alert").fadeIn();	
					
					setTimeout(function(){	
					$("#display_vehicle_message_alert").slideUp().fadeOut();						
						$("#display_vehicle_message_title").text("Vehicles un-available.");						
						$("#display_vehicle_message_detail").text("There is nothing to display. Please, add a new vehicle details. Your added details will be displayed here.");
						$("#display_vehicle_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{	
					setTabHeader("DELETE VEHICLES", " Please, check the rows that you want to delete.");
					//$("#temp_route_heading_title").text("DELETE ROUTE");
					//$("#temp_route_heading h3 small").text("Please, check the rows that you want to delete.");
					$("#display_vehicle_table").hide();
					addCheckBoxInTable();
					$("#delete_vehicle_apply_and_cancel_buttons").fadeIn();
					$("#display_vehicle_vehicle_delete_select_all_checkbox").slideDown().fadeIn();
					disableAddEditDeleteButtons();
					
					$("#content_header_button_refresh").prop("disabled", true);
					$("#sort_table").css({"pointer-events":"none"});		//sort button	
					$("#filter_table").css({"pointer-events":"none"});		//filter
					
					$("#display_vehicle_table").fadeIn('slow');
					
					//adding event listener to the delete button
					$("#delete_vehicle_button").off()
					$("#delete_vehicle_button").on('click',function(){
						displayVehicleDeleteModal();
					});
					
					//for cancel button cancelVehicleOption is already added in onclick event of button html attribute.
				}			
			}
			
						//This function add the checkbox to the route table list.
			function addCheckBoxInTable(){
				$("#display_vehicle_table thead tr").prepend('<th>MARK</th>');
				//var total_item = $("#display_route_table thead tr").find("tbody").children().length;
				//for(var i=0; i<total_item;i++){
					$("#display_vehicle_table tbody tr").prepend('<td style="padding:0px; margin:0px" width="4%"><span style="background:none;border:none" class="input-group-addon"><input type="checkbox" aria-label="..." onclick="unTickSelectAllCheckBox()"></span></td>');				
				//}
			}
			
			
			
			//Action of select all checkbox on delete route details option. the function will return either the checkbox is checked or not.
			//triggered by select all checkbox.
				function selectAllCheckBox(){
					if($("#vehicle_delete_select_all_checkbox").is(":checked")){					
					//alert("checked");
					//checking all the input checkboxes in the list.
					$("#display_vehicle_table tbody tr").find("input:checkbox").prop('checked', true);
					}
					else{
						//alert("not checked");					
						$("#display_vehicle_table tbody tr").find("input:checkbox").prop('checked', false);
					}
				}
				
			
			//This function unselect the select all Checkbox. This is to make the main select all tick box unticked when any of all selected boxes are manually unchecked during deletion.
			function unTickSelectAllCheckBox(){
				$("#vehicle_delete_select_all_checkbox").prop('checked', false);
			}
			
						
			//this function removes the checkbox from the route delete option
			function removeCheckBoxInTable(){
				$("#display_vehicle_table thead tr th:first").remove();
				$("#display_vehicle_table tbody tr td:nth-child(1)").each(function(){
					(this).remove();
				});
			}
			
			
						
			//this function get out of the delete option mode
			function cancelVehicleDeleteOption(){	
				setTabHeader("CURRENT VEHICLES", " List of currently available Vehicles.");	
				
					$("#display_vehicle_table").hide();					
					$("#loading_1").fadeIn();
				//$("#temp_route_heading_title").text("CURRENT ROUTE");
				//$("#temp_route_heading h3 small").text("List of currently available routes.");
				removeCheckBoxInTable();
				
				$("#delete_vehicle_apply_and_cancel_buttons").hide();
				$("#display_vehicle_vehicle_delete_select_all_checkbox").hide();
				
				enableAddEditDeleteButtons();
				
				
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
					
					
				setTimeout(function(){					
					$("#display_vehicle_table").fadeIn();					
					$("#loading_1").fadeOut();
				},400);
			}
			
			

			
			//this function gets the vehicle route, vehicle and time detail and return.
			function getToDeleteVehicleRowNames(){	
				//this variable holds the deleted vehicle or to delete vehicle details.					
				var toDeleteVehicles = [];
				$("#display_vehicle_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');						
						toDeleteVehicles.push($(row).find("td:nth-child(3)").text());
					}
				});
				return toDeleteVehicles;
			}
			
			//this function delete route rows
			function deleteRowVehicles(){	
				$("#display_vehicle_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						$(row).remove();
					}
				});
			}
			
			
						
			//this variable holds the id of the vehicle code to delete.			
			var vehiclesToDelete = [];
			
			function deleteVehicleRowsExtended(){				
				$("#loading_1").fadeIn();
				
				//degetting the schdule details that need to be deleted.
				vehiclesToDelete = getToDeleteVehicleRowNames();	
				//alert(JSON.stringify(vehiclesToDelete));
				
				//setTimeout(function(){					
				
				//alert(vehiclesToDelete);
				//##################################################
				//Server codes
				//send toDeleteVehicles to server to delete.
				deleteVehicleToServer(vehiclesToDelete);
				
				
				//####################################################
				
				/*if(deleteStatus == true){			
						//deleting vehicle from the local array.
						
						//alert(JSON.stringify(vehicleCollection));
						for(var i=0; i<vehiclesToDelete.length;i++){
							for(var j=0; i<vehicleCollection.length;j++){
								if(vehicleCollection[j].name==vehiclesToDelete[i]){
									vehicleCollection.splice(vehicleCollection.indexOf(vehicleCollection[j]),1);
									break;
								}
							}
						};
						
						//alert(JSON.stringify(vehicleCollection));
						
						deleteRowVehicles(); ///delete the row in the table displayed 					
					
						vehiclesToDelete = [];		//empty the remove list
					
						$("#loading_1").fadeOut();
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayVehicleDetailAlertMessage()==false){										
						//displaying status message
							$("#vehicle_delete_success_message").slideDown().fadeIn();
							$("#vehicle_delete_success_message").focus();
							$("#vehicle_delete_success_message").blur();
							setTimeout(function(){
								$("#vehicle_delete_success_message").slideUp().fadeOut();
							},5000);
						}

					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#vehicle_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#vehicle_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the vehicle details at the moment.");
					$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}*/
				//},2000);
			}
			
			
			
			//this function is triggered after the delete ajax finished.
			function afterDeleteVehicleData(status, vehiclesToDelete){
						if(status == true){			
						//deleting vehicle from the local array.
						
						if(vehicleCollection.length!=0){
							//alert(JSON.stringify(vehicleCollection));
							for(var i=0; i<vehiclesToDelete.length;i++){
								for(var j=0; i<vehicleCollection.length;j++){
									if(vehicleCollection[j].name==vehiclesToDelete[i]){
										vehicleCollection.splice(vehicleCollection.indexOf(vehicleCollection[j]),1);
										break;
									}
								}
							};	

							//alert(JSON.stringify(vehicleCollection));
							
							deleteRowVehicles(); ///delete the row in the table displayed 					
						
							vehiclesToDelete = [];		//empty the remove list
						
							$("#loading_1").fadeOut();
							//displaying the no route message in screen if all route deleted.
							
						}
					
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayVehicleDetailAlertMessage()==false){										
						//displaying status message
							$("#vehicle_delete_success_message").slideDown().fadeIn();
							$("#vehicle_delete_success_message").focus();
							$("#vehicle_delete_success_message").blur();
							setTimeout(function(){
								$("#vehicle_delete_success_message").slideUp().fadeOut();
							},5000);
						}
					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#vehicle_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#vehicle_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the vehicle details at the moment.");
					$("#vehicle_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#vehicle_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}
			}
			
			
			
			
			//this function displays modal to ask user to delete the selected rows and then delete.
			function displayVehicleDeleteModal(){				
				var count = 0;
				$("#display_vehicle_table tbody tr").each(function(i, row){
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
					$("#action_modal_content").text("Are you sure want to delete this Vehicle detail?");
					$("#action_modal").modal('show');
					$('#action_modal_delete').off();
					$('#action_modal_delete').click(function (e) {
					  // deleting the route rows.
					  deleteVehicleRowsExtended();
					})
				}
			}
			
			//this message either display the empty route table message when there is no route rows to display or table.
			function displayVehicleDetailAlertMessage(){
			//alert($("#display_vehicle_table").find("tbody").children().length);
				if($("#display_vehicle_table").find("tbody").children().length==0){
					$("#display_vehicle_message_title").text("Vehicles un-available.");						
					$("#display_vehicle_message_detail").text("There is nothing to display. Please, add a new vehicle details. Your added details will be displayed here.");	
					$("#display_vehicle_message_alert").fadeIn();	
					//cancel button unhide the table so hiding table below it.
					//cancelRouteDeleteOption();	
					setTabHeader("CURRENT VEHICLES", " List of currently available Vehicles.");	
					//$("#temp_route_heading_title").text("CURRENT ROUTE");
					//$("#temp_route_heading h3 small").text("List of currently available routes.");
					removeCheckBoxInTable();
					$("#delete_vehicle_apply_and_cancel_buttons").hide();
					$("#display_vehicle_vehicle_delete_select_all_checkbox").hide();
					
					enableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
				
					$("#display_vehicle_table").hide();
					return true;
				}	
				else{
					$("#display_vehicle_message_alert").css({
						display:"none"
					});	
					$("#display_vehicle_table").fadeIn();
					return false;
				}
			}
			
			
			//##############SORT SECTION#######################################################
			function sortTable(){				
				var sortedVehicle = [];

				jQuery.each(vehicleCollection, function(i, vehicle){
					sortedVehicle.push(vehicle.name);
				});
				
				sortedVehicle = sortedVehicle.sort();
				
				//alert($("vehicle_display_sort_table_dropdown option:selected").val());
				if($("#vehicle_display_sort_table_dropdown option:selected").text()=="Default"){
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();
						$("#display_vehicle_table tbody").empty();
						//adding data to page table
						jQuery.each(vehicleCollection, function(i, vehicle){
							//stopsName.push(route.stops);
							loadVehicleDataToTable(vehicle.name);						
						});	
						changeDefaultTextColorOfRouteRow();
					},300);
				}
				else if($("#vehicle_display_sort_table_dropdown option:selected").text()=="Name"){	
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();									
						$("#display_vehicle_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedVehicle, function(i, vehicle){
							loadVehicleDataToTable(vehicle);						
						});
						changeDefaultTextColorOfRouteRow();
					},300);			
				}
			}
			
			
	
			


	  </script>	  
   </body>
</html>