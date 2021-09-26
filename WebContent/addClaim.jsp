<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Project - Thanh Duy Tran - J2EE</title>
</head>
  <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
      crossorigin="anonymous"
    />
      <link rel="stylesheet" href="styles.css">
<body>
<% if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}
%>
<% String serialNumber = (String) session.getAttribute("serialNumber"); %>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<c:if test="${param.register != null}">
	<sql:update dataSource="${db}" var="count">  
		INSERT INTO claims (userid, deviceid, claimdate, description, status) VALUES (?, ?, ?, ?, ?);
		<sql:param value="${userid}" />  
		<sql:param value="${deviceid}" />  
		<sql:param value="${param.claimDate}" />  
		<sql:param value="${param.claimDescription}" />  
		<sql:param value="Pending" />   
	</sql:update>  

        <c:if test="${count >=1}">
        <div class="container col-5 border border-primary p-4">
	<jsp:include page="menu.jsp" />  
	<div class="row text-center">
		<h2 class="text-primary">SUCCESS!</h2>
		<h5>Thank you for submitting your claim!</h5>
		<h5>We will review your claim and come back to you as soon as possible!</h5>
	</div>
</div>

        </c:if> 
</c:if>
<% session.removeAttribute("deviceid"); %>
</body>
</html>