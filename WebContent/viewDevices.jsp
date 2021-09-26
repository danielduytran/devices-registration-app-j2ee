<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
  <link rel="stylesheet" href="styles.css">
  <style>
    .btn {
      width: auto;
    }
  </style>
  <title>Project - Thanh Duy Tran - J2EE</title>
</head>
<body>
<% if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}
%>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<c:if test="${validUser}">
	<sql:query dataSource = "${db}" var="result">
            SELECT * FROM devices d
            JOIN products p ON d.productid = p.productid
            JOIN users u ON d.userid = u.userid
            WHERE u.userid = ?;
            <sql:param value="${userid}" />  
    </sql:query>

	<c:choose>
	<c:when test="${result != null}">
	<div class="container col-7 border border-primary p-4">
         <jsp:include page="menu.jsp" />  
          <h2 class="text-primary">Registered devices information</h2>
          <table class="table table-striped table-hover text-center">
  <thead>
    <tr>
      <th scope="col">Device name</th>
      <th scope="col">Serial number</th>
      <th scope="col">Purchase date</th>
      <th scope="col">Number of claims<br> (Max 03 claims)</th>
      <th scope="col">View Claims</th>
      <th scope="col">Add Claim</th>
    </tr>
  </thead>
  <tbody>
           <c:forEach var = "row" items = "${result.rows}">
			            <sql:query dataSource = "${db}" var="claimsResult">
			            SELECT COUNT(*) AS numclaims FROM claims c
			            JOIN devices d ON c.deviceid = d.deviceid
			            JOIN users u ON c.userid = u.userid
			            WHERE u.userid = ? and c.deviceid = ?;
			            <sql:param value="${userid}" />
			            <sql:param value="${row.deviceid}" />  
					    </sql:query>
					    <c:forEach var="rowClaims" items="${claimsResult.rows}">
							<c:set var="numclaims" value="${rowClaims.numclaims}" />
					    </c:forEach>
            	<tr>
               <td> <c:out value = "${row.productname}"/></td>
               <td> <c:out value = "${row.serialnumber}"/></td>
               <td> <c:out value = "${row.purchasedate}"/></td>
               
               <td> <c:out value = "${numclaims}"/></td>
               
               <td> <a class="btn btn-outline-info" href="viewClaims.jsp?deviceid=${row.deviceid}"><i class="fas fa-eye"></i></a></td>
               <c:choose>
               <c:when test="${numclaims < 3}">
               <td> <a class="btn btn-outline-primary" href="addClaimForm.jsp?deviceid=${row.deviceid}"><i class="fas fa-plus"></i></a></td>
               </c:when>
               <c:otherwise>
               <td> <a class="btn btn-outline-secondary disabled" href="#"><i class="fas fa-plus"></i></a></td>
               </c:otherwise>
               </c:choose>
               
            </tr>
         </c:forEach>
  </tbody>
</table>

 
    </div>

    </c:when>

	<c:otherwise>
	 <div class="my-5 container">
      <div class="row">
        <div class="col-7 p-3 border border-2 border-primary">
          <h2 class="text-danger">Error!</h2>
        </div>
      </div>
    </div>
	</c:otherwise>
	</c:choose> 
</c:if>
</body>
</html>