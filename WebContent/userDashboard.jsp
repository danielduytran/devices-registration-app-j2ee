<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="ISO-8859-1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
  <link rel="stylesheet" href="styles.css">
  <title>Project - Thanh Duy Tran - J2EE</title>
  <style>
  .btn {
  	width: auto;
  }
  </style>
</head>

<body>
<% if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}
String username = (String) session.getAttribute("username");	
%>

<div class="container col-5 border border-primary p-4">
	<jsp:include page="menu.jsp" />  
	
	<div class="row text-center">
		<h2 class="text-primary">DASHBOARD</h2>
		<h5>Welcome, ${username}!</h5>
	</div>
	
	<div class="d-grid gap-2 col-6 mx-auto">
		<a href="registerDeviceForm.jsp" class="btn btn-outline-primary btn-lg" type="button">Register a device</a>
		<a href="viewDevices.jsp" class="btn btn-outline-primary btn-lg" type="button">View your registered devices</a>
	</div>
</div>
</body>

</html>
