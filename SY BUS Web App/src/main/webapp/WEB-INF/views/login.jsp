<%@page session="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<spring:url value="resources/images/favicon.png" var="favicon" />
<spring:url value="resources/css/bootstrap.min.css" var="bootstrapCss"/>
<spring:url value="resources/css/bootstrap-theme.min.css" var="bootstrapThemeCss"/>
<spring:url value="resources/css/signin.css" var="signinCss"/>

<spring:url value="resources/js/jquery-1.11.3.min.js" var="jqueryJs"/>
<spring:url value="resources/js/bootstrap.js" var="bootstrapJs"/>
<spring:url value="resources/js/ie10-viewport-bug-workaround.js" var="viewportBusJs"/>

<spring:url value="resources/images/icon.png" var="titleIcon" />

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
        <!-- Custom styles for this sign in page -->
        <link href="${signinCss}" rel="stylesheet">
        <!--Making the button background color green <style>.btn {background: green!important}</style> -->		
    </head>
    <spring:url value="resources/images/bg2.jpg" var="backgroundImage"/>
    <body style="background:url('${backgroundImage}');background-size:cover">
        <header class="navbar-inverse" role="banner">
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
                            <a class="navbar-brand" href="#" style="color:#DDD;font-size:22px;margin-top:-10px;">
                                <span style="float:left;margin-right:8px;margin-left:-18px"><img src="${titleIcon}" alt="icon" height="40" width="45"></span> 
                                <div style="font-size:28px;margin-top:5px; float:left;margin-right:10px">SY BUS<br><span style="font-size:12px;float:left">Vehicle Tracking &amp; Management System </span></div>
                            </a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Options <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a onclick="alert()">Help</a></li>
                                        <li><a onclick="alert()">Forget Password</a></li>
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
        <br><br><br><br><br><br>
        <!-- Main body-->
        <div class="container">
            <br>
            <form class="form-signin" method="POST" action="login">
                <h5 class="form-signin-heading">Please, sign-in to your account.</h5>
                <input type="username" id="inputUsername" name="username" class="form-control"  placeholder="Username" style="font-size:12px; height:32px;margin:2px" required autofocus oninvalid="this.setCustomValidity('Please, enter your username.')" oninput="this.setCustomValidity('')"/>
                <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" style="font-size:12px;height:32px; margin:2px;" required oninvalid="this.setCustomValidity('Please, enter your password.')" oninput="this.setCustomValidity('')"/>
                <div class="checkbox">
                    <label>
                    <input type="checkbox" name="checkbox" value="remember-me">  Remember me                     
                    <input type="hidden" value="on" name="checkbox"/>
                    </label>
                </div>
                <button class="btn btn-sm btn-success btn-block" type="submit">SIGN IN</button>				
                <div class="alert alert-danger" role="alert" id="signin_error_message" style="display:none; text-align:center; margin-top:10px;height:48px"><label></label></div>
            </form>
        </div>
        <br>
        <!-- Footer -->
        <div class="navbar-header" style="position: fixed;bottom: 0; width: 100%; height:40px;">
            <div  style="text-align:center; font-size:12px; margin-left:10px">
                <div class="container" style="margin-top:5px; font-weight:bold ">
                    <span><strong  style="color:Green">Copyright &copy; sybus.com 2015 </strong> <br> SAJHA YATAYAT VEHICLE TRACKING AND MANAGEMENT SYSTEM (SYBUS)  </span>
                </div>
            </div>
        </div>
        <!-- Latest compiled JQuery JavaScript -->
        <script src="${jqueryJs}"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="${bootstrapJs}"></script>
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="${viewportBusJs}"></script>
        <script type="text/javascript"> 
        	var errorMessage = "${message}";
        	//alert(errorMessage.length);
            //$(document).ready( function() {
            	if (errorMessage.length!=0){
                    $("#signin_error_message label").text(errorMessage);
                    $("#signin_error_message").fadeIn();
            	}
            	else{
                    $("#signin_error_message").hide();
            	}
            //});
        </script>
    </body>
</html>