<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<spring:url value="resources/images/favicon.png" var="favicon" />

<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap-theme.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/css/dashboard.css" var="dashboardCss"/>

<spring:url value="resources/images/icon.png" var="titleIcon" />

<spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
<spring:url value="resources/js/jquery-ui.min.js" var="jqueryUiJs"/>
<spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>
<spring:url value="resources/js/jQuery.print.js" var="jqueryPrintJs"/>

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
						<li><a href="management">MANAGE</a></li>
                        <!--<li class="active" class="dropdown">
                           <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">MANAGE <span class="caret"></span></a>
                           <ul class="dropdown-menu">
                              <li><a id="target" href="#">Manage Fares</a></li>
                              <li><a href="#">Manage Fares</a></li>
                              <li><a href="#">Manage Fare</a></li>
                              <li><a href="#">Manage Fares</a></li>
                           </ul>
                        </li>-->
                                <li class="dropdown active">
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
			  <li class="active" >Report 1</li>
			</ol>

		</div>


          <ul class="nav nav-sidebar" style="padding:2px">
            <li><a style="color:#000; font-weight:bold;border-top:1px solid rgba(0,0,0,0.3)">REPORTING <span class="sr-only">(current)</span></a></li>
		  <li><a style="color:rgba(0,0,0,0.5)" href="route-with-most-passenger-travelling-report">Route with Most Passenger Travelling Report</a></li>
		  <li><a style="color:rgba(0,0,0,0.5)" href="route-with-most-traffic-condition-report">Route with Most Traffic Report</a></li>
		  <li><a style="color:rgba(0,0,0,0.5)" href="time-where-most-passenger-ride-bus-report">Time where Most Passenger Ride Bus Report</a></li>
		  <li class="active"><a style="font-weight:normal; background:none;color:#000;border:1px solid #9E9E9E" href="#">Vehicle, Schedule, Fare and Route Details Report</a></li>
		  <li><a style="color:rgba(0,0,0,0.5)" href="registered-passenger-details-report">Registered Passenger Details Report</a></li>
		  <li><a style="color:rgba(0,0,0,0.5)" href="bus-with-highest-and-lowest-travelling-time-report">Bus with Highest and Lowest Travelling Time Report</a></li>
          </ul>
        </div>
		
		
		<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="margin-bottom:40px;height:100%; width:89%">
        
				<!--title for the content pane for tab. which will be switched accordingly. also this div is fixed.-->
				<div class="page-header row-fluid" style=" height:32px; width:100%; padding-left:18px;padding-right:18px;margin-bottom:0px; margin-top:-28px; margin-left:-42px">
				<div id="content_header">
				  <h3><span style="color:#4CAF50; margin-left:8px;" id="content_header_title">Vehicle, Schedule, Fare and Route Details Report</span><small id="content_header_subtitle">  Generated Report</small>
					 

					 <!--Refresh Button-->
					<!--  <button id="refresh" type="button" class="btn btn-sm"  style="display:nones; background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:24px;width:80px; margin-top:2px; margin-right:8px" onClick="refresh()">
					  <span id="content_header_icon_refresh" class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Refresh
					  </button>	-->

					<!--Print Button-->
					  <button id="print" type="button" class="btn btn-sm"  style="display:nones; background:none; border:1px solid #9E9E9E; float:right;padding:0px; height:24px;width:80px; margin-top:2px; margin-right:8px" onClick="printData()">
					  <span id="content_header_icon_refresh" class="glyphicon glyphicon-print" aria-hidden="true"></span> Print
					  </button>						  
					  
					<!--Sort section-->
					<div id="sort" class="input-group" style="padding:0px;margin:0px; float:right; width:180px; margin-right:8px; margin-top:2px">
							<span class="input-group-addon" style="height:24px; padding:4px;margin:0px; font-weight:normal font-size:12px; background:none">Duration</span>
							  <select id="duration_dropdown" style="height:24px; font-size:12px; padding:0px; color:#424242" class="form-control tooltip-bottom" placeholder="apple" onChange="getDataByDuration()" disabled="disabled">
								<option value="1" selected>All Time</option>
								<option value="2">Today</option>
								<option value="3">Last Week</option>
								<option value="4">Last Month</option>
							  </select>
							</div>
			  </h3>
				</div>
				</div>	
				
				

		<!--<h1 class="page-header" style="margin-top:-10px">Dashboard</h1>-->
		  <div style="margin-left:-42px;margin-right:-42px;margin-top:8px; height:100%; width:100%; overflow-y:auto">
							
	


				<div class="container-fluid col-md-12" style="min-height:500px; padding-left:60px; padding-right:60px; margin-top:12px; overflow-y:auto">
						
				<div style="margin:auto; text-align:center">
					<!--no data available message.-->
				  <h1 id="not_available_mesage" style="display:none; color:#CCC; font-weight:bold; margin-top:200px;">Report Not Available.</h1>
				
				</div>
				
				
				<div id="table_panel" class="col-xs-12 panel panel-default" media='print' style="display:none; border:1px solid #BDBDBD; padding:0px; background:none; margin-top:0px; overflown-y:auto">
				
				<div id="report_header" media='print' class="col-xs-12 panel-heading" style="background:none"> 
				<span style="float:right" id="date"></span>
				<br>
				<h4 style="float:left">REPORT TITLE: <span style="color:#686868">Vehicle, Schedule, Fare and Route Details Report</span> </h4>
				<br><br>
				</div>			
				<div class="col-xs-12 panel-body" style="padding:14px; font-family:Arial, Helvetica, sans-serif; font-size:12px">
				  
						<!--route table.-->
						<table class="table table-condensed table-striped table-bordered" media='print' id="route_table">
						<caption style="font-size:16px">ROUTE INFORMATION REPORT</caption>
						<thead>
						<tr style="background:#424242; color:#CCC">
						<th style="text-align:center" width="2%">SN</th>
						<th style="text-align:center" width="38%">ROUTE NAME</th>
						<th style="text-align:center" width="60%">BUS STOPS</th>
						</tr>
						</thead>
						<tbody>	
						
						  </tbody>
						</table> 	
						<h1 id="route_not_available_mesage" media='print' style="display:none; color:#CCC; font-weight:bold; margin-top:8px;">Route Not Available.</h1>
				  						
						<!--schedule table.-->
						<table class="table table-condensed table-striped table-bordered" media='print' id="schedule_table">
						<caption style="font-size:16px">SCHEDULE INFORMATION REPORT</caption>
						<thead>
						<tr style="background:#424242; color:#CCC">
						<th style="text-align:center" width="3%">SN</th>
						<th style="text-align:center" width="32%">ROUTE NAME</th>
						<th style="text-align:center" width="32%">VEHICLE NAME</th>						
						<th style="text-align:center" width="33%">SCHEDULE</th>
						</tr>
						</thead>
						<tbody>	
						
						  </tbody>
						</table> 
						<h1 id="schedule_not_available_mesage" media='print' style="display:none; color:#CCC; font-weight:bold; margin-top:8px;">Schedule Not Available.</h1>

						<!--Vehicle table.-->
						<table class="table table-condensed table-striped table-bordered" media='print' id="vehicle_table">
						<caption style="font-size:16px">VEHICLE INFORMATION REPORT</caption>
						<thead>
						<tr style="background:#424242; color:#CCC">
						<th style="text-align:center" width="3%">SN</th>
						<th style="text-align:center" width="92%">VEHICLE NAME</th>
						</tr>
						</thead>
						<tbody>	
						
						  </tbody>
						</table> 
						<h1 id="vehicle_not_available_mesage" media='print' style="display:none; color:#CCC; font-weight:bold; margin-top:8px;">Vehicle Not Available.</h1>
						

						<!--fare table.-->
						<table class="table table-condensed table-striped table-bordered" media='print' id="fare_table">
						<caption style="font-size:16px">FARE INFORMATION REPORT</caption>
						<thead>
						<tr style="background:#424242; color:#CCC">
						<th style="text-align:center" width="2%">SN</th>
						<th style="text-align:center" width="49%">DISTANCE</th>
						<th style="text-align:center" width="49%">FARE AMOUNT</th>
						</tr>
						</thead>
						<tbody>	
						
						  </tbody>
						</table> 
						<h1 id="fare_not_available_mesage" media='print' style="display:none; color:#CCC; font-weight:bold; margin-top:8px;">Fare Not Available.</h1>
					

						
				</div>
				</div>
				
				</div>




				
				  </div>

				</div>
			</div>
		</div> 


		<!--loading icon animation-->
		<div id="loading_1" style="background:url('${loadingIcon}');background-repeat:no-repeat;background-position:center center;height:auto; width:auto; position: absolute;top:0;bottom: 0;left: 0;right: 0;margin-left:120px; position:absolute; z-index:9999; display:none"></div>

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
      <script src="${jqueryPrintJs}"></script>
	  
	  
	  <script type="text/javascript">
		$(document).ready(function() {	
			//original state of the add route form. so that it can use when it is closed the filled form will not appear when re-opening/adding new route.
			//var originalStateOfAddRouteForm = $("#add_route_section").clone();
			
			//page utilities javascripts

			//bootstrap tooltip activation
			$('[data-toggle="tooltip"]').tooltip();
			$('button').click(function(){$(this).tooltip('hide')});
			$('tr').click(function(){$(this).tooltip('hide')});
			
			$("#duration_dropdown option:selected").val(1);
		});
		
				
			//setting date.
			var date = new Date();
			var year = date.getFullYear();
			var month= date.getMonth();			
			var day = date.getDate();
			if(month==0){
				month="Jan";
			}
			else if(month==1){				
				month="Feb";
			}
			else if(month==2){
				month="Mar";			
			}
			else if(month==3){
				month="Apr";			
			}
			else if(month==4){
				month="May";			
			}
			else if(month==5){
				month="Jun";			
			}
			else if(month==6){
				month="Jul";			
			}
			else if(month==7){
				month="Aug";			
			}
			else if(month==8){
				month="Sep";			
			}
			else if(month==9){
				month="Oct";			
			}
			else if(month==10){
				month="Nov";			
			}
			else if(month==11){
				month="Dec";			
			}			
			var date_string = "Date: "+year+"-"+month+"-"+day;
			//alert(date_string);
			
			$("#date").text(date_string);
			
			
		
		
			//loading data.
			$("#loading_1").fadeIn();
			$("#table_panel").hide();
		
		
			
			
			//sample datas.
			
			
			//schedule
			var schedule1 = {vehicle:"BA 10 PA 3477", route:"Route 1", time:"12:15"};
			var schedule2 = {vehicle:"BA 11 PA 2327", route:"Route 1", time:"12:20"};
			var schedule3 = {vehicle:"BA 12 PA 6565", route:"Route 1", time:"12:25"};
			var schedule4 = {vehicle:"BA 13 PA 3434", route:"Route 3", time:"12:30"};
			var schedule5 = {vehicle:"BA 14 PA 5544", route:"Route 2", time:"12:35"};
			var schedule6 = {vehicle:"BA 15 PA 6655", route:"Route 3", time:"12:40"};
			var schedule7 = {vehicle:"BA 16 PA 7565", route:"Route 3", time:"12:45"};
			var schedule8 = {vehicle:"BA 17 PA 7666", route:"Route 3", time:"12:50"};
			var schedule9 = {vehicle:"BA 18 PA 7777", route:"Route 2", time:"12:55"};
			var schedule10 = {vehicle:"BA 10 PA 8866", route:"Route 2", time:"13:00"};
			var schedule11 = {vehicle:"BA 10 PA 3237", route:"Route 2", time:"13:05"};
			
			
			//routes   here need to remove longitude and latitude. only stop name.
			
			var route1 = {name:"Route 1", stops:["Swayambhu Bus Station","Sitapaila Bus Station","Kalanki Bus Station","SoaltiMood Bus Station","Kalimati Bus Station","Teku Bus Station","Tripureshwor1 Bus Station","Tripureshwor2 Bus Station","RNAC Bus Station","Jamal Bus Station","DurbarMarg Bus Station","Hattisar Bus Station","Kamalpokhari Bus Station","Gyaneshwor Bus Station","Maitidevi Bus Station","Ratopul Bus Station","Gaushala Bus Station","Tilganga Bus Station","Airport Bus Station"]};
			
			var route2 = {name:"Route 2", stops:["Swayambhu Bus Station","Sitapaila Bus Station","Kalanki Bus Station","SoaltiMood Bus Station","Kalimati Bus Station","Teku Bus Station","Tripureshwor1 Bus Station","Tripureshwor2 Bus Station","RNAC Bus Station"]};
			
			var route3 = {name:"Route 3", stops:["Jamal Bus Station","DurbarMarg Bus Station","Hattisar Bus Station","Kamalpokhari Bus Station","Gyaneshwor Bus Station","Maitidevi Bus Station","Ratopul Bus Station","Gaushala Bus Station"]};
			
			var route4 = {name:"Route 4", stops:["Kalanki Bus Station","SoaltiMood Bus Station","Kalimati Bus Station","Teku Bus Station","Tripureshwor1 Bus Station","Tripureshwor2 Bus Station","RNAC Bus Station","Jamal Bus Station","DurbarMarg Bus Station","Hattisar Bus Station","Kamalpokhari Bus Station","Gyaneshwor Bus Station","Maitidevi Bus Station","Ratopul Bus Station","Gaushala Bus Station"]};
			
			
			//vehicle data
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
			
			
			//fare data.
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
			
			
			
			//these variable holds all above data.
			routeCollection = [];
			scheduleCollection = [];
			fareCollection = [];
			vehicleCollection = [];
			
			
			//this will be set by sever.
			routeCollection.push(route1,route2,route3,route4);
			scheduleCollection.push(schedule1,schedule2,schedule3,schedule4,schedule5,schedule6,schedule7,schedule8,schedule9,schedule10,schedule11);
			vehicleCollection.push(vehicle1,vehicle2,vehicle3,vehicle4,vehicle5,vehicle6,vehicle7,vehicle8,vehicle9,vehicle10,vehicle11);
			fareCollection.push(fare1,fare2,fare3,fare4,fare5,fare6,fare7,fare8,fare9,fare10);
					
			
			//this functions get and load the roport data.
			function loadData(){
				$("#route_table tbody").empty();
				$("#vehicle_table tbody").empty();
				$("#fare_table tbody").empty();
				$("#schedule_table tbody").empty();
				
				if(routeCollection.length==0){
					$("#route_not_available_mesage").fadeIn();				
				}
				else{
					$("#route_not_available_mesage").hide();				
				}
				if(scheduleCollection.length==0){
					$("#schedule_not_available_mesage").fadeIn();				
				}
				else {
					$("#schedule_not_available_mesage").hide();				
				}
				if(vehicleCollection.length==0){
					$("#vehicle_not_available_mesage").fadeIn();				
				}
				else{
					$("#vehicle_not_available_mesage").hide();				
				}
				if(fareCollection.length==0){
					$("#fare_not_available_mesage").fadeIn();				
				}
				else{
					$("#fare_not_available_mesage").hide();				
				}
				//route table
				jQuery.each(routeCollection, function(i, val){
					$("#route_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+val.name+'</td><td style="text-align:center">'+val.stops+'</td></tr>');
				});
				
				//vehicle table
				jQuery.each(vehicleCollection, function(i, val){
					$("#vehicle_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+val.name+'</td></tr>');
				});
				
				//fare table
				jQuery.each(fareCollection, function(i, val){
					$("#fare_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+val.distance+'</td><td style="text-align:center">'+val.amount+'</td></tr>');
				});
				
				//schedule table
				jQuery.each(scheduleCollection, function(i, val){
					$("#schedule_table tbody").append('<tr><td>'+parseInt(i+1)+'</td><td style="text-align:center">'+val.vehicle+'</td><td style="text-align:center">'+val.route+'</td><td style="text-align:center">'+val.time+'</td></tr>');
				});				
				
				$("#route_table").fadeIn();
				$("#vehicle_table").fadeIn();
				$("#fare_table").fadeIn();
				$("#schedule_table").fadeIn();
				$("#report_header").fadeIn();
			}
			
			
			setTimeout(function(){				
				loadData();	
				$("#loading_1").fadeOut();
				$("#table_panel").fadeIn();		
			},1000);
			
			
			
			/*
			
			
			//this function get and filter data and set in the table according to the duration_dropdown
			function getDataByDuration(){
				var option = $('#duration_dropdown :selected').text();
				if(option=="All Time"){
					setDataToPage(1);
				}
				else if(option=="Today"){				
					setDataToPage(2);
				}
				else if(option=="Last Week"){				
					setDataToPage(3);
				}
				else if(option=="Last Month"){
					setDataToPage(4);				
				}
			}
			
			
			
			
			
			//this function get data from server.
			function setDataToPage(option){
				if(option==1){
					//get all time data
					//alert(1);
					$("#loading_1").fadeIn();
					$("#table_panel").hide();
					//data = {route_name:"Route 2", total_passenger:5445};		//new data downloaded
					setTimeout(function(){
						loadData(allTime);
						$("#loading_1").fadeOut();	
						$("#table_panel").fadeIn();	
						setDutationStatusMessage(option);					
					},600);
				}
				else if(option==2){
					//get today data
					//alert(2);
					$("#loading_1").fadeIn();
					$("#table_panel").hide();
					//data = {route_name:"Route 3", total_passenger:5445};		//new data downloaded
					setTimeout(function(){
						loadData(today);
						$("#loading_1").fadeOut();	
						$("#table_panel").fadeIn();
						setDutationStatusMessage(option);		
					},600);
				}
				else if(option==3){
					//get last week data.
					//alert(3);
					$("#loading_1").fadeIn();
					$("#table_panel").hide();
					//data = {route_name:"Route 4", total_passenger:5445};		//new data downloaded
					setTimeout(function(){
						loadData(lastWeek);
						$("#loading_1").fadeOut();	
						$("#table_panel").fadeIn();	
						setDutationStatusMessage(option);				
					},600);
				}
				else if(option==4){
					//get last month data.
					//alert(4);
					$("#loading_1").fadeIn();
					$("#table_panel").hide();
					//data = {route_name:"Route 5", total_passenger:5445};		//new data downloaded
					setTimeout(function(){
						loadData(lastMonth);
						$("#loading_1").fadeOut();	
						$("#table_panel").fadeIn();		
						setDutationStatusMessage(option);			
					},600);
				}			
			}
			
			
			//this function writes the duration according to the duration option selected.
			function setDutationStatusMessage(index){
				if(index==1){
					$("#duration_text").text("All Time.");
				}
				else if(index==2){	
					$("#duration_text").text("Today: "+year+"-"+month+"-"+day);
				}
				else if(index==3){
					//setting date.
					var ndate = new Date();
					ndate.setDate(ndate.getDate()-7);
					var nyear = ndate.getFullYear();
					var nmonth= ndate.getMonth();			
					var nday = ndate.getDate();
					if(nmonth==0){
						nmonth="Jan";
					}
					else if(nmonth==1){				
						nmonth="Feb";
					}
					else if(nmonth==2){
						nmonth="Mar";			
					}
					else if(nmonth==3){
						nmonth="Apr";			
					}
					else if(nmonth==4){
						nmonth="May";			
					}
					else if(nmonth==5){
						nmonth="Jun";			
					}
					else if(nmonth==6){
						nmonth="Jul";			
					}
					else if(nmonth==7){
						nmonth="Aug";			
					}
					else if(nmonth==8){
						nmonth="Sep";			
					}
					else if(nmonth==9){
						nmonth="Oct";			
					}
					else if(nmonth==10){
						nmonth="Nov";			
					}
					else if(nmonth==11){
						nmonth="Dec";			
					}
					$("#duration_text").text("From "+nyear+"-"+nmonth+"-"+nday+" to "+year+"-"+month+"-"+day);
				}
				else if(index==4){
					//setting date.
					var ndate = new Date();
					ndate.setDate(ndate.getDate()-30);
					var nyear = ndate.getFullYear();
					var nmonth= ndate.getMonth();			
					var nday = ndate.getDate();
					if(nmonth==0){
						nmonth="Jan";
					}
					else if(nmonth==1){				
						nmonth="Feb";
					}
					else if(nmonth==2){
						nmonth="Mar";			
					}
					else if(nmonth==3){
						nmonth="Apr";			
					}
					else if(nmonth==4){
						nmonth="May";			
					}
					else if(nmonth==5){
						nmonth="Jun";			
					}
					else if(nmonth==6){
						nmonth="Jul";			
					}
					else if(nmonth==7){
						nmonth="Aug";			
					}
					else if(nmonth==8){
						nmonth="Sep";			
					}
					else if(nmonth==9){
						nmonth="Oct";			
					}
					else if(nmonth==10){
						nmonth="Nov";			
					}
					else if(nmonth==11){
						nmonth="Dec";			
					}
					$("#duration_text").text("From "+nyear+"-"+nmonth+"-"+nday+" to "+year+"-"+month+"-"+day);
				}			
			}
			
			*/
			
				
				
				
				//this function print the report.
				function printData(){
				  /* var printArea=document.getElementById("table_panel");
				   newWin= window.open("");
				   newWin.document.write(printArea.innerHTML);
				   newWin.print();
				   //newWin.close();*/
				   $("#table_panel").print({ mediaPrint: true});
				}

	  </script>	  
   </body>
</html>