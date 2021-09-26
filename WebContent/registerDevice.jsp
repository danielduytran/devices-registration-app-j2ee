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
    <style>
    	.btn {
    		width: auto;
    	}
    </style>
<body>
<% 
if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}	
%>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<c:if test="${param.register != null}">
	<sql:query dataSource = "${db}" var="result">
            SELECT * FROM products WHERE productname = ?;
            <sql:param value="${param.productName}" />  
    </sql:query>
    <c:forEach var="row" items="${result.rows}">
    	<c:set var="productid" value="${row.productid}"/>
    </c:forEach>
	<c:choose>
	<c:when test="${result.getRowCount() == 1}">
	    <sql:update dataSource="${db}" var="count">  
		INSERT INTO devices (userid, productid, serialnumber, purchasedate) VALUES (?, ?, ?, ?);
		<sql:param value="${userid}" />  
		<sql:param value="${productid}" />  
		<sql:param value="${param.serialNumber}" />  
		<sql:param value="${param.purchaseDate}" />
	</sql:update> 

<c:if test="${count >= 1 }">
<div class="container col-5 border border-primary p-4">
	<jsp:include page="menu.jsp" />  
	<div class="row text-center">
		<h2 class="text-primary">SUCCESS!</h2>
		<h5>Thank you for registering your device!</h5>
	
	</div>
	<div class="row d-flex justify-content-center">
		<a href="registerDeviceForm.jsp" role="button" class="ms-2 btn btn-outline-primary">Register another devices</a>
		<a href="viewDevices.jsp" role="button" class="ms-2 btn btn-outline-primary">View registered devices</a>
	</div>
</div>

</c:if>
    </c:when>
	</c:choose> 
</c:if>
</body>
</html>