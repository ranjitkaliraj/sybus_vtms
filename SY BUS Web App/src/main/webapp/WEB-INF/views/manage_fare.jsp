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
      <title>SY Bus - Fare Tracking and Management System for Sajha Yatayat</title>
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
                        <div style="font-size:28px;margin-top:5px; float:left;margin-right:10px">SY BUS<br><span style="font-size:12px;float:left">Fare Tracking &amp; Management System </span></div>
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
                              <li><a id="target" href="#">Manage Fares</a></li>
                              <li><a href="#">Manage Fares</a></li>
                              <li><a href="#">Manage Fare</a></li>
                              <li><a href="#">Manage Fares</a></li>
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
			  <li class="active" >Fare</li>
			</ol>

		</div>


          <ul class="nav nav-sidebar" style="padding:2px">
            <li><a style="color:#000; font-weight:bold;border-top:1px solid rgba(0,0,0,0.3)" href="manage.html">Overview <span class="sr-only">(current)</span></a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-route">MANAGE ROUTE</a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-schedule">MANAGE SCHEDULE</a></li>
            <li><a style="color:rgba(0,0,0,0.5)" href="manage-vehicle">MANAGE VEHICLE</a></li>
            <li class="active"><a style="font-weight:bold; background:none;color:#000;border:1px solid #9E9E9E"href="#">MANAGE FARE</a></li>
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
					<li role="presentation" class="active"><a id="fare_tab_header" id="fares" href="#fares_tab" aria-controls="fares_tab" role="tab" data-toggle="tab" style="height:36px; padding:8px">FARE</a></li>

					<!--add, edit and delete buttons-->
					<div class="btn-group" role="group" aria-label="..." style="float:right;margin-right:18px; margin-top:2px">
					  <button id="add_button" data-toggle="tooltip" data-placement="bottom" title="Add" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Add new Fare Details"><span class="glyphicon glyphicon-plus"></span></button>
					  <button id="edit_button" data-toggle="tooltip" data-placement="bottom" title="Edit" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Edit and update existing Fare Details"><span class="glyphicon glyphicon-edit"></span></button>
					  <button id="delete_button" data-toggle="tooltip" data-placement="bottom" title="Delete" style="background:none;padding:0px; height:28px;width:60px" type="button" class="btn btn-default pull-left tooltip-bottom" title="Delete all or particular Fare Details"><span class="glyphicon glyphicon-trash"></span></button>
					</div>
					</ul>
					</div>
					
					
					<!-- Tab panes to display detail content-->
				<div id ="tab_pane" class="tab-content container-fluid" style="height:100%; width:100%">

								
				<!--title for the content pane for tab. which will be switched accordingly. also this div is fixed.-->
				<div class="page-header row-fluid" style=" height:32px;padding-left:18px;padding-right:18px; padding-bottom:0px; margin-bottom:0px; margin-top:-12px">
				<div id="content_header">
				  <h3><span style="color:#4CAF50" id="content_header_title">CURRENT FARES</span><small id="content_header_subtitle"> List of currently available fares.</small>
					 

					 <!--Refresh Button-->
					  <button id="content_header_button_refresh" type="button" class="btn btn-sm"  style="display:nones; background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:24px;width:80px; margin-top:2px" onClick="refresh()">
					  <span id="content_header_icon_refresh" class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Refresh
					  </button>		
					  
					<!--Sort section-->
					<div id="sort_table" class="input-group" style="padding:0px;margin:0px; float:right; width:120px; margin-right:8px; margin-top:2px">
							<span class="input-group-addon" style="height:24px; padding:4px;margin:0px; font-weight:normal font-size:12px; background:none">Sort</span>
							  <select id="fare_display_sort_table_dropdown" style="height:24px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" title="Select Bus stop from the list." onChange="sortTable()">
								<option value="1">Default</option>
								<option value="2">Distance</option>
								<option value="2">Amount</option>
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
				
				<!--add edit fare section-->
				<div class="container-fluid col-md-12" style="padding-left:48px; padding-right:48px; margin-top:12px">
				
					<!--Add new fare status message section-->				
					<div id="add_fare_submit_message_alert" class="alert in fade alert-success col-md-12" style="padding:12px; padding-left:18px;display:none; background:nosne; border:1px solid #BDBDBD; height:">
						<h3 style="color:#595959;"><span style="color:#4CAF50" id="add_fare_submit_message_alert_title">ADD SUCCESSFUL.</span>
						<small id="add_fare_submit_message_alert_details"> You have successfully added a new fare details. </small>
						
							<button  id="fare_add_success_exit" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:6px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">EXIT</button>
							
							<button  id="fare_add_success_add_again" type="button" class="btn btn-sm" style="margin-top:-6px; margin-right:18px;  float:right; background:none; border:1px solid #9E9E9E; padding:0px; height:32px;width:96px; margin-left:-10px">ADD NEW</button>
						</h3>
					</div>
										
						<!--no route or fare available error, duplicate add entry error message-->
						<div id="fare_add_timeout_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong id="fare_add_timeout_error_message_header">WARNING.</strong><small id="fare_add_timeout_error_message_detail"> Cannot add the new Fare at the moment. Currently, no Fares and Route information ara available to display.</small></div>
						
					<!--add new Fare section-->
					<div id="fare_add_edit_section" class="panel panel-default col-md-12" style="padding:0px;border:1px solid #BDBDBD;display:none; height:96px">		
					<div class="panel-heading" style="height:28px; padding:4px; text-align:center; background:none;background-color:#424242;color:#CCC">ADD NEW FARE</div>
					<div class="panel-body" style="padding:6px; margin-top:12px; font-size:12px">
						
						
						
						<div class="form-group row-fluid  col-md-4" style="padding:0px;padding-left:4px; padding-right:4px;">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div  class="input-group" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="padding:0px;margin:0px; font-weight:normal font-size:12px; color:#000; padding:6px">DISTANCE</span>
								   <input id ="add_edit_fare_form_distance_input" style="height:28px; font-size:12px;color:#000" type="text" class="form-control" placeholder="Enter Distance" aria-describedby="basic-addon1">
								</div>
						</div>
						
						<div class="form-group row-fluid  col-md-5" style="padding:0px;padding-left:4px; padding-right:4px; margin-right:-24px">
								<!--<label class="col-md-3 control-label"> Add Stops:</label>-->
								<div  class="input-group" style="padding:0px;margin:0px">
								<span class="input-group-addon" style="padding:0px;margin:0px; font-weight:normal font-size:12px; color:#000; padding:6px">AMOUNT</span>
								   <input id ="add_edit_fare_form_amount_input" style="height:28px; font-size:12px;color:#000" type="text" class="form-control" placeholder="Enter Amount" aria-describedby="basic-addon1">
								</div>
						</div>

						
						
						<div class="form-group row-fluid col-md-3" style="padding:0px;padding-left:6px; margin-left:8px">							
							<!--reset button-->
							<button id="fare_add_edit_reset_button" type="button" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Reset" style="float:left; margin-left:8px; padding:4px; background:none; border:1px solid #9E9E9E; height:28px;width:28px" onClick="">
							  <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
							</button>
							
							
							<!--save and cancel button for edit/delete mode fare edit mode-->			
							<button id="fare_add_edit_exit_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; margin-right:-16px; background:none; border:1px solid #9E9E9E;height:28px;width:86px; margin-left:4px; margin-right:-12px" onClick="">
							  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> EXIT
							</button>
							
							<button id="fare_add_edit_add_button" type="button" class="btn btn-sm" style="float:right;margin-bottom:5px; background:none; border:1px solid #9E9E9E; height:28px;width:86px" onClick="">
							  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <span id="fare_add_edit_form_submit_button">UPDATE</span>
							</button>
							
							<!--submit animation logo-->
							<span id="fare_add_edit_loading_icon" data-toggle="tooltip" data-placement="bottom" title="Loading..." style="display:none; float:right; margin-right:8px;margin-top:2px"><img src="${actionLoadingIcon}" height="24" width="24"></span>	
							
										
						</div>	
			 						
					  </div>						
					</div>
				</div>
				
				<!--#####################################################################################################################################-->
				<!--Tab main content-->
				<!--#####################################################################################################################################-->
				<div role="tabpanel" class="tab-pane fade in active" id="fares_tab" style="height:100%; width:100%;  padding-left:56px; padding-right:56px;overflow-y:hidden!important; margin-top:-12px">
				
				<span id="fare_tab_span_container">  <!--This span is used for hiding the section when reloading or loading-->
				
				<div style="height:12px; width:100%"></div>		<!--Just to fill gap of 12px between header and content pane-->
				

				<!--this is temporary heading for fare display when add fare form appears-->
				<div id="temp_fare_heading" class="page-header row-fluid col-md-12" style="display:none;padding:0px; margin-bottom:2px; margin-top:-12px">
				  <h3 style="margin:0px"><span id="temp_fare_heading_title" style="color:#4CAF50">CURRENT FARES</span> <small> List of currently available fares. </small>			
				  </h3>
				</div>
				
				
				<!--Fare table list section-->
				<div class="col-md-12 container-fluid" style="padding:0px;font-family:Arial, Helvetica, sans-serif; font-size:12px; height:100%; width:100%;overflow-y:auto!important">

			
			<!--Display message when there is no-fare to display in table.-->
			  <div id="display_fare_message_alert" class="alert in fade alert-success col-md-9" role="alert" style="display:none;background:none; border:1px solid #595959">
				<h2 style="color:#595959;"><span style="color:#4CAF50" id="display_fare_message_title">Fare not Available.</span><small id="display_fare_message_detail">There is nothing to display. Please, add a new fare details. Your added details will be displayed here.</small></h2>
				
			</div>
			
			
									  	
					<!--Save edit fare detail status message-->				
				 <div id="fare_save_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Successful.</strong><small> New changes to the selected fare has been successfully updated.</small></div>
				 <div id="fare_save_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Update Failed.</strong><small> Something went wrong. New changes to the selected fare cannot be made at the moment.</small></div>
				 <div id="fare_save_already_saved_error_message" tabindex="1" class="alert alert-warning row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Unable to Save.</strong><small> No modification has been made to any fare details or changes are already saved.</small></div>
				 
				
				
			 <!--delete fare detail status message-->				
			 <div id="fare_delete_success_message" tabindex="1" class="alert alert-success row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Successful.</strong><small> Selected Fares has been successfully deleted.</small></div>
			 <div id="fare_delete_danger_message" tabindex="1" class="alert alert-danger row-fluid" role="alert" style="display:none; font-size:14px; height:48px; margin-bottom:6px"><strong>Delete Failed.</strong><small> Something went wrong. Deletion to the selected Fares cannot be made at the moment.</small></div>
			 
			 
			 
			
			<div id="main_table_container" style="width:80%; margin:auto; overflow-y:auto!important"">


			<!--Delete fare check box to select all-->	
			<div id="display_fare_fare_delete_select_all_checkbox" style="display:none; width:94px"><div style="float:left; margin-top:3px;font-weight:bold">SELECT ALL: </div><div style="float:right"><input id="fare_delete_select_all_checkbox" type="checkbox" aria-label="..." onClick="selectAllCheckBox()"></div></div>
			
			
			
		  <table class="table table-condensed table-striped table-bordered" id="display_fare_table" style="display:none">
            <thead>
              <tr style="height:28px; background-color:#424242;color:#CCC">
                <th style="text-align:center" width="4%">SN</th>
                <th style="text-align:center"width="38%">DISTANCE</th>	
                <th style="text-align:center"width="47%">AMOUNT</th>				
              </tr>
            </thead>
            <tbody>
             <!--<tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Fare 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>
             <tr tabindex="1">
                <td>1</td>
                <td style="text-align:center">BA 10 PA 3477</td>
                <td style="text-align:center">Fare 1</td>
                <td style="text-align:center">12:00</td>				
              </tr>-->
			  </tbody>
			  </table>
			  
			  			<!--Delete button-->
			  <div id="delete_fare_apply_and_cancel_buttons" style="display:none; margin-bottom:6px; margin-top:-6px">
			  <hr>
			  	<button id="delete_fare_button" type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;height:32px; width:96px">
				  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DELETE
				</button>
				
				 <!--delete option close/cancel button-->
			  	<button type="button" class="btn btn-sm" style="margin-top:-12px; background-color:#FFF; border:1px solid #9E9E9E; margin-bottom:20px;margin-left:5px; height:32px; width:96px" onClick="cancelFareDeleteOption()">
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
			setTabHeader("CURRENT FARES", " List of currently available Fares.");
			//activateHeaderButton("refresh");  //initially setting refresh button
			
			//if the + button on top clicked show the add route form.
			$("#add_button").click(function(){
				openAddFareForm();
				//making form unfocused so that blue color edege will not seen.
				$("#fare_add_edit_section").blur();
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
				$("#display_fare_table").fadeIn();
			},600);*/
			
			//misc. just to hide to foucs effect on form.
			$("#fare_add_edit_section").click(function(){
				$("#fare_add_edit_section").blur();
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
				//$("#fare_tab_span_container").hide();
				//setTimeout(function(){				
				//	$("#fare_tab_span_container").fadeIn();		
					//emptying the local array first.
					fareCollection = [];		
					
					//emptying the table row.
					$("#display_fare_table tbody").empty();
					
					//now loading the data.
					loadFareData();
					//$("#loading_1").fadeOut();			
				//},2000);			
				
			}
			
			//####################################################LOAD DATA ##############################################################
			
			//example data.
			var fare1 = {distance:5, amount:15};
			var fare2 = {distance:6, amount:16};
			var fare3 = {distance:8, amount:18};
			var fare9 = {distance:19, amount:40};
			var fare10 = {distance:20, amount:45};
			var fare4 = {distance:10, amount:25};
			var fare5 = {distance:12, amount:26};
			var fare6 = {distance:15, amount:30};
			var fare7 = {distance:16, amount:32};
			var fare8 = {distance:18, amount:35};
			
			
			
			//this variable array holds the all the route data retrived from the server. also added updated and deleted route will be updated here as well
			var fareCollection = [];	
			
			
			//this function get the route list when the page is first loaded.\\\
			function loadFareData(){
				//loading from server code here  example is route 1 route 2 and route 3 and route 4
				
				$("#loading_1").fadeIn();	
				$("#display_fare_table").hide();
				//fareCollection.push(fare1,fare2,fare3,fare4,fare5,fare6,fare7,fare8,fare9,fare10);
				console.log("Loading Fare data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "load_fare_data",
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS LOADING FARE DATA");
							//updateRouteServerStatus = status;
							fareCollection=data;
							if (fareCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_fare_message_alert").fadeIn();	
								$("#display_fare_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(fareCollection, function(i, fare){
									//stopsName.push(route.stops);
									loadFareDataToTable(fare.distance, fare.amount);						
								});	
									
								//making the table font color to black since it is changed by to blue by loadFareDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_fare_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_fare_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
									$("#display_fare_table").fadeIn();
								//},600);
							}
						},
						error : function(e) {
							console.log("ERROR WHILE LOADING FARE DATA");
							//updateRouteServerStatus = false;	
							fareCollection=[];
							if (fareCollection.length==0){
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
								$("#display_fare_message_alert").fadeIn();	
								$("#display_fare_table").hide();
								//},600);	
								//cancelRouteDeleteOption();
							}
							else{					
								enableAddEditDeleteButtons();
								//adding data to page table
								jQuery.each(fareCollection, function(i, fare){
									//stopsName.push(route.stops);
									loadFareDataToTable(fare.distance, fare.amount);						
								});	
									
								//making the table font color to black since it is changed by to blue by loadFareDataToTable() function. this function need to work with update or add which highlight color and that code can not be changed so manually changing color here.
								$("#display_fare_table tbody").find("tr").css({"color":"#424242"});				

								$("#display_fare_message_alert").hide();									
								//$("#loading_1").fadeIn();	
								//setTimeout(function(){
									$("#loading_1").fadeOut();	
									$("#display_fare_table").fadeIn();
								//},600);
							}					
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);			
			}						
			loadFareData();
			
			//#############################################################################################
			//#SERVER INTERACTTION CODES

			function addFareToServer(distance, amount){
				var fareData = {distance:distance,amount:amount};
				console.log("Adding new fare data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "save_fare_data",
						data : JSON.stringify(fareData),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS ADDING FARE DATA");
							//updateRouteServerStatus = status;
							afterAddRouteData(true, distance, amount);
						},
						error : function(e) {
							console.log("ERROR WHILE ADDING FARE DATA");
							//updateRouteServerStatus = false;	
							afterAddRouteData(false, distance, amount);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}	


			function updateFareToServer(updatedFares){
				console.log("Updating fare data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "update_fare_data",
						data : JSON.stringify(updatedFares),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS UPDATING FARE DATA");
							//updateRouteServerStatus = status;
							afterUpdateFareData(true, updatedFares);
						},
						error : function(e) {
							console.log("ERROR WHILE UPDATING FARE DATA");
							//updateRouteServerStatus = false;	
							afterUpdateFareData(false, updatedFares);						
						},
						done : function(e) {
							console.log("DONE");
							//updateRouteServerStatus = true;
						}
					});
				},1600);
			}


			function deleteFareToServer(toDeleteFares){
				console.log("Deleting fare data.");
				setTimeout(function(){
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : "delete_fare_data",
						data : JSON.stringify(toDeleteFares),
						dataType : 'json',
						timeout : 100000,
						success : function(data) {
							console.log("SUCCESS DELETING FARE DATA");
							//updateRouteServerStatus = status;
							afterDeleteFareData(true, toDeleteFares);
						},
						error : function(e) {
							console.log("ERROR WHILE DELETING FARE DATA");
							//updateRouteServerStatus = false;	
							afterDeleteFareData(false, toDeleteFares);						
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
			function loadFareDataToTable(distance, amount){
				var index = $("#display_fare_table tbody").children().length;
				index = parseInt(index)+1;
				//adding to the table list.
				$("#display_fare_table tbody").append('<tr style="padding:0px; height:auto; color:#673AB7; font-size:11.5px" tabindex="1"><td style="height:24px">'+index+'</td><td style="text-align:center">'+distance+ ' Km'+'</td><td style="text-align:center">'+'Rs. '+amount+'</td></tr>');
			}
			
			//this function removes or clears the dropdown.
			
			
			//##############ADD NEW SCHEDULE #######################################################
			
			//this funciton is triggered when user click the add button in top right corner option panel.
			//this funciton shows the add form
			function openAddFareForm(){
				$("#fare_add_edit_section").slideDown().fadeIn();				
				$("#temp_fare_heading").fadeIn();
				disableAddEditDeleteButtons();	
				setTabHeader("ADD FARE"," Add a new Fare details.");
				$("#content_header_button_refresh").attr("disabled", true);		//refresh button
				$("#sort_table").css({"pointer-events":"none"});		//sort button			
				$("#display_fare_table").css({'pointer-events':'none','filter':'alpha(opacity=60)', 'opacity':'0.6'});
								
				$("#fare_add_edit_form_submit_button").text("ADD");			//this button is used for update as well. so ensureing it is displayed ADD .

				
				//adding click event on add button
				$("#fare_add_edit_add_button").off();
				$("#fare_add_edit_add_button").on('click', function(){
						addFare();
				});
				
				//adding click event on exit button
				$("#fare_add_edit_exit_button").off();
				$("#fare_add_edit_exit_button").on('click', function(){
					exitAddEditFareForm();
					
					$("#fare_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route fare available
				});	
				//adding click event on reset button
				$("#fare_add_edit_reset_button").on('click', function(){
					resetForm();
				});					
			}
			
			
			//reset add edit fare fomr
			function resetForm(){				
				$("#add_edit_fare_form_distance_input").val("");
				$("#add_edit_fare_form_amount_input").val("");
			}
			
			//this function add the fare details. it is triggeded by add button of add fare form
			function addFare(){
				var distance = $("#add_edit_fare_form_distance_input").val().trim();
				var amount = $("#add_edit_fare_form_amount_input").val().trim();
				//alert(fareName);
				
				if(distance=="" || distance==null){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Fare. Distance is not entered. Please, enter distance value and try again.");
					$("#alert_modal").modal('show');
				}
				else if(isNaN(distance)){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Fare. Distance must be number. Please, enter correct value and try again.");
					$("#alert_modal").modal('show');
				}
				else if(amount=="" || amount==null){
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Fare. Fare amount is not entered. Please, select enter a fare amount and try again.");
					$("#alert_modal").modal('show');
				}
				else if(isNaN(amount)){
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot add the Fare. Fare Amount must be number. Please, enter correct value and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(parseInt(distance), parseInt(amount))==true){
					//alert(checkForDuplicateEntry(route,fare,hour, min));
					$("#fare_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#fare_add_edit_loading_icon").fadeOut();					
						$("#fare_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#fare_add_timeout_error_message_detail").text(" The fare information is already exist. Please, provide non-duplicate data and add it.");
						$("#fare_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#fare_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{					
					$("#fare_add_edit_loading_icon").fadeIn();
					//setTimeout(function(){
							
							distance = parseInt(distance);
							amount = parseInt(amount);
							//##########################################################
							//Now sent the data to the server.
							//sending time in the form of 1212 not separated as 12:12. 
							addFareToServer(distance, amount);
							
							//#######################################################

						
							//var serverStatus = false;
							//error example
							//var errormessage = "Duplicate Fare. The fare is already added on the list.";
							//var returnSameObjectWithId = {id:1212, fare:"BA 10 PA 3477", route:"Route 1", time:"12:15"};  //or only download id.
							//so that new data will be stored in local array with id.
							
							//now add this object to the fareCollection;
							//#######################################################
							
							//if the returned id is null or server failed.
							/*if(serverStatus==true){
								//adding the data to local array
								//the id will be downloaded from the server.												//above id will be added here.
								fareCollection.push({distance:distance, amount:amount});
								//alert(JSON.stringify(fareCollection));
								//adding to the table
								loadFareDataToTable(distance, amount);
								
								////////////////////////////////////////////////////
								
								//the display successful message.
								$("#add_fare_submit_message_alert").fadeIn();
								$("#fare_add_edit_section").hide();

								//adding event listener to add again button.
								$("#fare_add_success_add_again").on('click',function(){						
									$("#add_fare_submit_message_alert").slideUp().fadeOut();
									openAddFareForm();
								});
								
								//adding click listener to exit button.
								$("#fare_add_success_exit").on('click',function(){						
									$("#add_fare_submit_message_alert").slideUp().fadeOut();
									exitAddEditFareForm();
								});
							}
							else{
								/*if(errormessage!=""){
									$("#fare_add_server_error_message_detail").text(errormessage);
									$("#fare_add_server_error_message2").slideDown().fadeIn();
									setTimeout(function (){						
										$("#fare_add_server_error_message2").slideUp().fadeOut();
									},4000);
								}
								//else{
									//display error message. may be server error or system error.
									$("#fare_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
									$("#fare_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the fare details at the moment.");
									$("#fare_add_timeout_error_message").slideDown().fadeIn();		
									setTimeout(function(){
										$("#fare_add_timeout_error_message").slideUp().fadeOut();
									},4000);
								//}
							}
							$("#fare_add_edit_loading_icon").fadeOut();
							resetForm();*/							
						//},2000);							
				}
			}
			
			
			//this function is triggered after the add fare ajax.
			function afterAddRouteData(status, distance, amount){
				if(status==true){
					//adding the data to local array
					//the id will be downloaded from the server.												//above id will be added here.
					fareCollection.push({distance:distance, amount:amount});
					//alert(JSON.stringify(fareCollection));
					//adding to the table
					loadFareDataToTable(distance, amount);
					$("#display_fare_message_alert").hide();	
					$("#display_fare_table").fadeIn();
					////////////////////////////////////////////////////
					
					//the display successful message.
					$("#add_fare_submit_message_alert").fadeIn();
					$("#fare_add_edit_section").hide();

					//adding event listener to add again button.
					$("#fare_add_success_add_again").on('click',function(){						
						$("#add_fare_submit_message_alert").slideUp().fadeOut();
						openAddFareForm();
					});
					
					//adding click listener to exit button.
					$("#fare_add_success_exit").on('click',function(){						
						$("#add_fare_submit_message_alert").slideUp().fadeOut();
						exitAddEditFareForm();
					});
				}
				else{
					/*if(errormessage!=""){
						$("#fare_add_server_error_message_detail").text(errormessage);
						$("#fare_add_server_error_message2").slideDown().fadeIn();
						setTimeout(function (){						
							$("#fare_add_server_error_message2").slideUp().fadeOut();
						},4000);
					}*/
					//else{
						//display error message. may be server error or system error.
						$("#fare_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
						$("#fare_add_timeout_error_message_detail").text(" Something went wrong. Cannot add the fare details at the moment.");
						$("#fare_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#fare_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					//}
				}
				$("#fare_add_edit_loading_icon").fadeOut();
				resetForm();
			}
			
			//this function exit the fare details. it is triggeded by exit button of add/edit fare form
			function exitAddEditFareForm(){	
				resetForm();
				$("#fare_add_edit_section").slideUp("slow").fadeOut("slow");
				$("#temp_fare_heading").hide();
				enableAddEditDeleteButtons();	
				setTabHeader("CURRENT FARES"," List of currently available Fares.");
				$("#content_header_button_refresh").attr("disabled", false);					
				$("#display_fare_table").css({'pointer-events':'auto','filter':'alpha(opacity=100)', 'opacity':'1'});
				$("#sort_table").css({"pointer-events":"auto"});		//sort button	
			}
			
			
			//this method check for duplicate data during adding or updating fare details
			function checkForDuplicateEntry(distance, amount){
				var isDuplicate = false;
				for(var i=0; i<fareCollection.length;i++){
					//alert(fareCollection[i].route+route + fareCollection[i].fare+fare +Number(time[0])+Number(hour) + Number(time[1])+Number(min));
					if(fareCollection[i].distance==distance && fareCollection[i].amount==amount){
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
					var original_table = $("#display_fare_table").clone();		//clonning original table
					
				<!--if there is no route available then edit mode must is unavailable-->
				if($("#display_fare_table").find("tbody").children().length==0){
					$("#display_fare_table").hide();				
					$("#display_fare_message_alert").hide();	
					$("#display_fare_message_title").text("Edit un-available.");						
					$("#display_fare_message_detail").text("Currently, no Fares are available to edit.");	
					$("#display_fare_message_alert").slideDown().fadeIn();	
					setTimeout(function(){
						$("#display_fare_message_alert").slideUp().fadeOut();						
						$("#display_fare_message_title").text("Fares un-available.");						
						$("#display_fare_message_detail").text("There is nothing to display. Please, add a new fare details. Your added details will be displayed here.");
						$("#display_fare_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{			
					$("#display_fare_table").hide();											
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
						saveUpdatedFareDetail();
						saveStatus = true;
					});
					$("#content_header_button_exit").click(function(){
						$("#loading_1").fadeIn();					
						$("#display_fare_table").hide();
						
						//reverting to original table on exit if changes are not saved.
						if(saveStatus==false){
							$("#display_fare_table").replaceWith(original_table);
						}
						cancelFareEditOption();
						setTimeout(function(){					
							$("#display_fare_table").fadeIn(100);
							$("#loading_1").hide();
						},600);
					});
					//setting the header					
					setTabHeader("EDIT FARE"," Please, click on edit button of any row to edit its details.");
					
					addEditButtonOnFareTable();
					disableAddEditDeleteButtons();
					$("#loading_1").fadeIn();
					setTimeout(function(){	
						$("#content_header_button_exit").fadeIn();	
						$("#content_header_button_save").fadeIn();							
						$("#display_fare_table").fadeIn(100);
						$("#loading_1").hide();
					},600);
				}
			}
			
		
		//this function add the edit button on each row of the table
		function addEditButtonOnFareTable(){
			$("#display_fare_table thead tr").append('<th width="12%"style="text-align:center">ACTION</th>');
			$("#display_fare_table tbody tr").append('<td height="24" style="margin:0px; padding:4px"><button type="button" class="btn btn-sm" style="padding:2px; font-size:11px;height:24px; margin:0px; width:100%; background:none; border:1px solid #424242" onclick="displayEditForm(this)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> EDIT </button></td>');	
		}
		
		//this function removes the edit button on each row of the table
		function removeEditButtonOnFareTable(){					
			$("#display_fare_table thead tr th:nth-child(4)").remove();
			$("#display_fare_table tbody tr td:nth-child(4)").each(function(){
				$(this).remove();
			});	
		}
		
		//this function cancel the fare edit option
		function cancelFareEditOption(){							//emptying the updated value.
				updated_Fares = [];
				
				$("#loading_1").fadeIn();
				$("#display_fare_table").hide();
				
				setTabHeader("CURRENT FARES", " List of currently available Fares.");
				
				removeEditButtonOnFareTable();
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
		
		//when user click a row edit button, the system will get first fare id from the local array and will be used to add with updated data. the updateFare array.
		//the process to update\
			//>>>> First, set to edit mode.
			//>>>> Then click to edit button
			//>>>> Then open the form. 
			//>>>> The fareIdtoUpdate is the retrieved from the local array and then stored untill the next edit form is triggered. then , this will replaced.
			//>>>> Then when user close and save, this id is used and stored to UpdatedFare array along with updated value.
			//>>>> later this array is send to server to make changes.
			//>>>> Program complete.
			
		//this variable holds the original id of the fare that will be updated when edit form is displayed.
		var fareToBeUpdated = null;
		
		//This function displays the edit form when edit button is clicked
		function displayEditForm(row){
			var distance = $(row).parent().parent().find("td:nth-child(2)").text().replace("Km","").trim();
			var amount = $(row).parent().parent().find("td:nth-child(3)").text().replace("Rs.","").trim();
			
			//setting the original fare name 
			fareToBeUpdated = {distance:distance, amount:amount};
			
			openEditFareForm(row, distance, amount);			
		}
			
			//this funciton is triggered when user click the edit button in top right corner option panel.
			//this funciton shows the add form
			function openEditFareForm(row, distance, amount){
				//highlightling the selected row				
				//$(row).parent().parent().css({"background":"#EEEEEE"});	
				$(row).parent().parent().focus();
				
				$("#fare_add_edit_section").slideDown().fadeIn();
								
				$("#fare_add_edit_form_submit_button").text("UPDATE");			//this button is used for update as well. so ensureing it is displayed ADD .
								
					//adding click event on add button
					$("#fare_add_edit_add_button").off();
					$("#fare_add_edit_add_button").on('click', function(){
							//alert();
							updatFare($(row));
					});
				//adding click event on exit button``
				$("#fare_add_edit_exit_button").off();
				$("#fare_add_edit_exit_button").on('click', function(){					
					$("#fare_add_edit_section").slideUp().fadeOut();
					resetForm();
					
					$("#fare_add_timeout_error_message").slideUp().fadeOut();	//if it is displayed due to no- route fare available
				});	
				//adding click event on reset button
				$("#fare_add_edit_reset_button").on('click', function(){
					resetForm();
				});			
				
				//setting the original value in input field.
				$("#add_edit_fare_form_distance_input").val(distance);
				$("#add_edit_fare_form_amount_input").val(amount);
			}
			
			
	
			//This function writes updated routes details to the edit mode table which will later saved after save button clicked.
			function updatFare(row){				
				var distance = $("#add_edit_fare_form_distance_input").val().trim();
				var amount = $("#add_edit_fare_form_amount_input").val().trim();

				if(distance=="" || distance==null){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot update the Fare. Distance is not entered. Please, enter distance value and try again.");
					$("#alert_modal").modal('show');
				}
				else if(isNaN(distance)){
				//alert("chinnappa");				
					//displaying alert
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot update the Fare. Distance must be number. Please, enter correct value and try again.");
					$("#alert_modal").modal('show');
				}
				else if(amount=="" || amount==null){
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot update the Fare. Fare amount is not entered. Please, select enter a fare amount and try again.");
					$("#alert_modal").modal('show');
				}
				else if(isNaN(amount)){
					$("#alert_modal_title").text("WARNING!!! INVALID INPUT");
					$("#alert_modal_content").text("Cannot update the Fare. Fare Amount must be number. Please, enter correct value and try again.");
					$("#alert_modal").modal('show');
				}
				//checking for duplicate entry
				else if(checkForDuplicateEntry(parseInt(distance), parseInt(amount))==true){
					//alert(checkForDuplicateEntry(route,fare,hour, min));
					$("#fare_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#fare_add_edit_loading_icon").fadeOut();					
						$("#fare_add_timeout_error_message_header").text("DUPLICATE ENTRY");
						$("#fare_add_timeout_error_message_detail").text(" The fare information is already exist. Please, provide non-duplicate data and add it.");
						$("#fare_add_timeout_error_message").slideDown().fadeIn();		
						setTimeout(function(){
							$("#fare_add_timeout_error_message").slideUp().fadeOut();
						},4000);
					},300);
				}
				else{
					distance = parseInt(distance);
					amount = parseInt(amount);
					
					$("#fare_add_edit_loading_icon").fadeIn();
					setTimeout(function(){	
						$("#fare_add_edit_loading_icon").fadeOut();
						
						//writing to the table row.
						$(row).parent().parent().find("td:nth-child(2)").text(distance+" Km");
						$(row).parent().parent().find("td:nth-child(3)").text("Rs. "+amount);
						
						$(row).parent().parent().css({"color":"#673AB7","font-weight":"bold"});	
						
						$("#fare_add_edit_section").slideUp().fadeOut();
						$(row).parent().parent().focus();
						
						resetForm();
						//now adding to the update array
						updated_Fares.push({oldDistance:fareToBeUpdated.distance, oldAmount:fareToBeUpdated.amount, distance:distance, amount:amount});
						//alert(JSON.stringify(updated_Fares));
					},600);				
				}
			}
			
		
		//this variable is to store as collection of all route details individual array.
		var updated_Fares = [];
		
		//This function saves all the updated fares details to the database server.
		function saveUpdatedFareDetail(){
			//alert(updated_Fares.length);
			if(updated_Fares.length==0){					
				$("#fare_save_already_saved_error_message").slideDown().fadeIn();
				setTimeout(function(){
					$("#fare_save_already_saved_error_message").slideUp().fadeOut();
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
						
						
						//updated_Fares need to send to serve.rad
						
						updateFareToServer(updated_Fares);
						
						
						//###################################################################################						
						
						/*if(serverStatus==true){
							$("#fare_save_success_message").slideDown().fadeIn();
							$("#fare_save_success_message").focus();
							$("#fare_save_success_message").blur();
							
							setTimeout(function(){
								$("#fare_save_success_message").slideUp().fadeOut();
							},5000);
							
							//reverting the edited row color to original color and font.
							changeDefaultTextColorOfRouteRow();
							
							//alert("apple");
							//modify the changes from the local array too.
							jQuery.each(updated_Fares, function(i,updated_fare){
								jQuery.each(fareCollection, function(i,old_fare){
									if(old_fare.amount==updated_fare.old_amount && old_fare.distance==updated_fare.old_distance){
										old_fare.amount=updated_fare.new_amount;
										old_fare.distance=updated_fare.new_distance;
										return true;
									}
								});
							});
							//delete updated routes array collection
							updated_Fares = [];
							//alert();
							//alert(JSON.stringify(fareCollection));
							
				
							//jQuery.each(updated_Fares, function(i, val){						
							//alert(i+" , "+val.name+" , "+val.stops);
							
							//re-enabling the save or exit button during saving data
							$("#content_header_button_save").prop("disabled",false);
							$("#content_header_button_exit").prop("disabled",false);
							//disabling the loading animation				
							$("#content_header_loading_icon").fadeOut();
							
						}
						else{
							$("#fare_save_danger_message").slideDown().fadeIn();
							setTimeout(function(){
								$("#fare_save_danger_message").slideUp().fadeOut();
							},5000);
						}*/
					//});
					
					
					
					
				//},2000);
			}
		}
		
		
		
		
		//This function is displayed after update fare ajax ends.
		function afterUpdateFareData(status, updated_Fares){
			if(status==true){
				$("#fare_save_success_message").slideDown().fadeIn();
				$("#fare_save_success_message").focus();
				$("#fare_save_success_message").blur();
				
				setTimeout(function(){
					$("#fare_save_success_message").slideUp().fadeOut();
				},5000);
				
				//reverting the edited row color to original color and font.
				changeDefaultTextColorOfRouteRow();
				
				//alert("apple");
				//modify the changes from the local array too.
				jQuery.each(updated_Fares, function(i,updated_fare){
					jQuery.each(fareCollection, function(i,old_fare){
						if(old_fare.amount==updated_fare.old_amount && old_fare.distance==updated_fare.old_distance){
							old_fare.amount=updated_fare.new_amount;
							old_fare.distance=updated_fare.new_distance;
							return true;
						}
					});
				});
				//delete updated routes array collection
				updated_Fares = [];
				//alert();
				//alert(JSON.stringify(fareCollection));
				
	
				//jQuery.each(updated_Fares, function(i, val){						
				//alert(i+" , "+val.name+" , "+val.stops);
				
				//re-enabling the save or exit button during saving data
				$("#content_header_button_save").prop("disabled",false);
				$("#content_header_button_exit").prop("disabled",false);
				//disabling the loading animation				
				$("#content_header_loading_icon").fadeOut();
				
			}
			else{
				$("#fare_save_danger_message").slideDown().fadeIn();
				setTimeout(function(){
					$("#fare_save_danger_message").slideUp().fadeOut();
				},5000);
			}
		}
		
		
		
		
		
		
			
			//this function revert back the text color to default black which has been changed in edit mode after update.
			function changeDefaultTextColorOfRouteRow(){
				$("#display_fare_table tbody tr").each(function(){
					$(this).css({"font-weight":"normal", "color":"#424242"});
				});
			}
			
			
			
			//##############DELETE SECTION#####################################################
			
			
			
			//this function display the delete option
			function displayDeleteOption(){
				//<!--if there is no route available then delete mode must is unavailable-->
				if($("#display_fare_table").find("tbody").children().length==0){
					$("#display_fare_table").hide();
					
					$("#display_fare_message_alert").hide();	
					$("#display_fare_message_title").text("Delete un-available.");						
					$("#display_fare_message_detail").text("Currently, no fares are available to delete.");	
					$("#display_fare_message_alert").fadeIn();	
					
					setTimeout(function(){	
					$("#display_fare_message_alert").slideUp().fadeOut();						
						$("#display_fare_message_title").text("Fares un-available.");						
						$("#display_fare_message_detail").text("There is nothing to display. Please, add a new fare details. Your added details will be displayed here.");
						$("#display_fare_message_alert").slideDown().fadeIn();	
					},3000);
				}
				else{	
					setTabHeader("DELETE FARES", " Please, check the rows that you want to delete.");
					//$("#temp_route_heading_title").text("DELETE ROUTE");
					//$("#temp_route_heading h3 small").text("Please, check the rows that you want to delete.");
					$("#display_fare_table").hide();
					addCheckBoxInTable();
					$("#delete_fare_apply_and_cancel_buttons").fadeIn();
					$("#display_fare_fare_delete_select_all_checkbox").slideDown().fadeIn();
					disableAddEditDeleteButtons();
					
					$("#content_header_button_refresh").prop("disabled", true);
					$("#sort_table").css({"pointer-events":"none"});		//sort button	
					$("#filter_table").css({"pointer-events":"none"});		//filter
					
					$("#display_fare_table").fadeIn('slow');
					
					//adding event listener to the delete button
					$("#delete_fare_button").off()
					$("#delete_fare_button").on('click',function(){
						displayFareDeleteModal();
					});
					
					//for cancel button cancelFareOption is already added in onclick event of button html attribute.
				}			
			}
			
						//This function add the checkbox to the route table list.
			function addCheckBoxInTable(){
				$("#display_fare_table thead tr").prepend('<th>MARK</th>');
				//var total_item = $("#display_route_table thead tr").find("tbody").children().length;
				//for(var i=0; i<total_item;i++){
					$("#display_fare_table tbody tr").prepend('<td style="padding:0px; margin:0px" width="4%"><span style="background:none;border:none" class="input-group-addon"><input type="checkbox" aria-label="..." onclick="unTickSelectAllCheckBox()"></span></td>');				
				//}
			}
			
			
			
			//Action of select all checkbox on delete route details option. the function will return either the checkbox is checked or not.
			//triggered by select all checkbox.
				function selectAllCheckBox(){
					if($("#fare_delete_select_all_checkbox").is(":checked")){					
					//alert("checked");
					//checking all the input checkboxes in the list.
					$("#display_fare_table tbody tr").find("input:checkbox").prop('checked', true);
					}
					else{
						//alert("not checked");					
						$("#display_fare_table tbody tr").find("input:checkbox").prop('checked', false);
					}
				}
				
			
			//This function unselect the select all Checkbox. This is to make the main select all tick box unticked when any of all selected boxes are manually unchecked during deletion.
			function unTickSelectAllCheckBox(){
				$("#fare_delete_select_all_checkbox").prop('checked', false);
			}
			
						
			//this function removes the checkbox from the route delete option
			function removeCheckBoxInTable(){
				$("#display_fare_table thead tr th:first").remove();
				$("#display_fare_table tbody tr td:nth-child(1)").each(function(){
					(this).remove();
				});
			}
			
			
						
			//this function get out of the delete option mode
			function cancelFareDeleteOption(){	
				setTabHeader("CURRENT FARES", " List of currently available Fares.");	
				
					$("#display_fare_table").hide();					
					$("#loading_1").fadeIn();
				//$("#temp_route_heading_title").text("CURRENT ROUTE");
				//$("#temp_route_heading h3 small").text("List of currently available routes.");
				removeCheckBoxInTable();
				
				$("#delete_fare_apply_and_cancel_buttons").hide();
				$("#display_fare_fare_delete_select_all_checkbox").hide();
				
				enableAddEditDeleteButtons();
				
				
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
					
					
				setTimeout(function(){					
					$("#display_fare_table").fadeIn();					
					$("#loading_1").fadeOut();
				},400);
			}
			
			

			
			//this function gets the fare route, fare and time detail and return.
			function getToDeleteFareDetails(){	
				//this variable holds the deleted fare or to delete fare details.					
				var toDeleteFares = [];
				$("#display_fare_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');						
						//toDeleteFares.push($(row).find("td:nth-child(3)").text());				
						//toDeleteFares.push($(row).find("td:nth-child(3)").text());
						
						var distance = parseInt($(row).find("td:nth-child(3)").text().replace("Km","").trim());
						var amount = parseInt($(row).find("td:nth-child(4)").text().replace("Rs.","").trim());
						
						toDeleteFares.push({distance:distance, amount:amount});						
					}
				});
				return toDeleteFares;
			}
			
			//this function delete route rows
			function deleteRowFares(){	
				$("#display_fare_table tbody tr").each(function(i, row){
					if($(row).find("input").is(":checked")){		//$row.find('input:checked');
						$(row).remove();
					}
				});
			}
		
		
			//this variable holds the id of the fare code to delete.			
			var faresToDelete = [];
			
			function deleteFareRowsExtended(){				
				$("#loading_1").fadeIn();
				
				//degetting the schdule details that need to be deleted.
				faresToDelete = getToDeleteFareDetails();	
				//alert(JSON.stringify(faresToDelete));
				
				//setTimeout(function(){					
				
				//alert(faresToDelete);
				//##################################################
				//Server codes
				//send toDeleteFares to server to delete.
				deleteFareToServer(faresToDelete);
				
				
				//####################################################
				
				/*if(deleteStatus == true){			
						//deleting fare from the local array.
						
						//alert(JSON.stringify(fareCollection));
						for(var i=0; i<faresToDelete.length;i++){
							for(var j=0; i<fareCollection.length;j++){
								if(fareCollection[j].distance==faresToDelete[i].distance && fareCollection[j].amount==faresToDelete[i].amount){
									fareCollection.splice(fareCollection.indexOf(fareCollection[j]),1);
									break;
								}
							}
						};
						
						//alert(JSON.stringify(fareCollection));
						
						deleteRowFares(); ///delete the row in the table displayed 					
					
						faresToDelete = [];		//empty the remove list
					
						$("#loading_1").fadeOut();
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayFareDetailAlertMessage()==false){										
						//displaying status message
							$("#fare_delete_success_message").slideDown().fadeIn();
							$("#fare_delete_success_message").focus();
							$("#fare_delete_success_message").blur();
							setTimeout(function(){
								$("#fare_delete_success_message").slideUp().fadeOut();
							},5000);
						}

					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#fare_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#fare_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the fare details at the moment.");
					$("#fare_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#fare_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}*/
				//},2000);
			}
			
			
			
			//This function is executed after delete fare ajax ends.
			function afterDeleteFareData(status, faresToDelete){
				if(status == true){			
						//deleting fare from the local array.
						
						if(fareCollection.length!=0){
							//alert(JSON.stringify(fareCollection));
							for(var i=0; i<faresToDelete.length;i++){
								for(var j=0; i<fareCollection.length;j++){
									if(fareCollection[j].distance==faresToDelete[i].distance && fareCollection[j].amount==faresToDelete[i].amount){
										fareCollection.splice(fareCollection.indexOf(fareCollection[j]),1);
										break;
									}
								}
							};
							
							//alert(JSON.stringify(fareCollection));
							
							deleteRowFares(); ///delete the row in the table displayed 					
						
							faresToDelete = [];		//empty the remove list
						
							$("#loading_1").fadeOut();
						}
						//displaying the no route message in screen if all route deleted.
						
						//if not all data are deleted and no global no data available mesg displayed then display these toast message.
						if (displayFareDetailAlertMessage()==false){										
						//displaying status message
							$("#fare_delete_success_message").slideDown().fadeIn();
							$("#fare_delete_success_message").focus();
							$("#fare_delete_success_message").blur();
							setTimeout(function(){
								$("#fare_delete_success_message").slideUp().fadeOut();
							},5000);
						}

					}
				
				else{
					$("#loading_1").fadeOut();
					//display error message. may be server error or system error.
					$("#fare_add_timeout_error_message_header").text("ERROR OCCURED!!! ");
					$("#fare_add_timeout_error_message_detail").text(" Something went wrong. Cannot delete the fare details at the moment.");
					$("#fare_add_timeout_error_message").slideDown().fadeIn();		
					setTimeout(function(){
						$("#fare_add_timeout_error_message").slideUp().fadeOut();
					},4000);
				}
			}
			
			
			
			
			
			
			
			//this function displays modal to ask user to delete the selected rows and then delete.
			function displayFareDeleteModal(){				
				var count = 0;
				$("#display_fare_table tbody tr").each(function(i, row){
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
					$("#action_modal_content").text("Are you sure want to delete this Fare detail?");
					$("#action_modal").modal('show');
					$('#action_modal_delete').off();
					$('#action_modal_delete').click(function (e) {
					  // deleting the route rows.
					  deleteFareRowsExtended();
					})
				}
			}
			
			//this message either display the empty route table message when there is no route rows to display or table.
			function displayFareDetailAlertMessage(){
			//alert($("#display_fare_table").find("tbody").children().length);
				if($("#display_fare_table").find("tbody").children().length==0){
					$("#display_fare_message_title").text("Fares un-available.");						
					$("#display_fare_message_detail").text("There is nothing to display. Please, add a new fare details. Your added details will be displayed here.");	
					$("#display_fare_message_alert").fadeIn();	
					//cancel button unhide the table so hiding table below it.
					//cancelRouteDeleteOption();	
					setTabHeader("CURRENT FARES", " List of currently available Fares.");	
					//$("#temp_route_heading_title").text("CURRENT ROUTE");
					//$("#temp_route_heading h3 small").text("List of currently available routes.");
					removeCheckBoxInTable();
					$("#delete_fare_apply_and_cancel_buttons").hide();
					$("#display_fare_fare_delete_select_all_checkbox").hide();
					
					enableAddEditDeleteButtons();
					$("#content_header_button_refresh").prop("disabled", false);
					$("#sort_table").css({"pointer-events":"auto"});		//sort button	
					$("#filter_table").css({"pointer-events":"auto"});		//filter
				
					$("#display_fare_table").hide();
					return true;
				}	
				else{
					$("#display_fare_message_alert").css({
						display:"none"
					});	
					$("#display_fare_table").fadeIn();
					return false;
				}
			}
			
			
			//##############SORT SECTION#######################################################
			function sortTable(){				
				var sortedDistance = [];	
				var sortedAmount = [];

				jQuery.each(fareCollection, function(i, fare){
					sortedDistance.push(fare.distance+":"+fare.amount);
					sortedAmount.push(fare.amount+":"+fare.distance);
				});
				
				sortedDistance = sortedDistance.sort(function(a, b){return a-b});;
				sortedAmount = sortedAmount.sort(function(a, b){return a-b});
				
				//alert($("fare_display_sort_table_dropdown option:selected").val());
				if($("#fare_display_sort_table_dropdown option:selected").text()=="Default"){
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();
						$("#display_fare_table tbody").empty();
						//adding data to page table
						jQuery.each(fareCollection, function(i, fare){
							//stopsName.push(route.stops);
							loadFareDataToTable(fare.distance, fare.amount);						
						});	
						changeDefaultTextColorOfRouteRow();
					},300);
				}
				else if($("#fare_display_sort_table_dropdown option:selected").text()=="Distance"){	
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();									
						$("#display_fare_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedDistance, function(i, fare){
							var arr = fare.split(":");
							loadFareDataToTable(parseInt(arr[0]),parseInt(arr[1]));						
						});
						changeDefaultTextColorOfRouteRow();
					},300);			
				}
				else if($("#fare_display_sort_table_dropdown option:selected").text()=="Amount"){	
					$("#loading_1").fadeIn();
					setTimeout(function(){			
						$("#loading_1").fadeOut();									
						$("#display_fare_table tbody").empty();
						//adding data to page table
						jQuery.each(sortedAmount, function(i, fare){
							var arr = fare.split(":");
							loadFareDataToTable(parseInt(arr[0]),parseInt(arr[1]));						
						});
						changeDefaultTextColorOfRouteRow();
					},300);			
				}
			}
			
			
	
			


	  </script>	  
   </body>
</html>