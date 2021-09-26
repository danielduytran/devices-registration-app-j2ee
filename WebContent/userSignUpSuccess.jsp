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
<body>
<% if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}
%>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<sql:query dataSource = "${db}" var="result">
	SELECT userid FROM users WHERE username = ?;
    <sql:param value="${username}" />
 </sql:query>

<c:forEach var="row" items="${result.rows}">
	<c:set var="userid" value="${row.userid}" scope="session"/>
</c:forEach>

<div class="my-5 container">
      <div class="row">
        <div class="col-7 p-3 border border-2 border-primary">
          <h2 class="text-primary">You have successfully registered an account!</h2>
          <h5>Thank you for signing up!</h5>
          <a href="userDashboard.jsp" role="button" class="btn btn-info">Go to Dashboard</a>
        </div>
      </div>
</div>
</body>
</html>