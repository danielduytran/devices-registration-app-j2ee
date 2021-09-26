<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
<link rel="stylesheet" href="styles.css">
  <title>Project - Thanh Duy Tran - J2EE</title>
</head>
<body>
<% if (session.getAttribute("validUser") == null) {
	response.sendRedirect("userSignIn.html");
}
%>
<% session.setAttribute("serialNumber", request.getParameter("serialNumber")); %>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<c:if test="${validUser}">
	<sql:query dataSource = "${db}" var="result">
            SELECT * FROM claims c
            JOIN devices d ON c.deviceid = d.deviceid
            JOIN users u ON c.userid = u.userid
            WHERE c.userid = ? and c.deviceid = ?;
            <sql:param value="${userid}" />
            <sql:param value="${param.deviceid}" />  
    </sql:query>
    
	<c:choose>
	<c:when test="${result != null}">
	<div class="container col-7 border border-primary p-4">
 <jsp:include page="menu.jsp" /> 
          <h2 class="text-primary">Claims information</h2>
          <table class="table table-striped table-hover">
  <thead>
    <tr>
      <th scope="col">Username</th>
      <th scope="col">Device's serial number</th>
      <th scope="col">Claim date</th>
      <th scope="col">Claim description</th>
      <th scope="col">Claim status</th>
    </tr>
  </thead>
  <tbody>
           <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.username}"/></td>
               <td> <c:out value = "${row.serialnumber}"/></td>
               <td> <c:out value = "${row.claimdate}"/></td>
               <td> <c:out value = "${row.description}"/></td>
               <td> 
               <c:choose>
               		<c:when test="${row.status == 'Pending' }">
               		<a class="btn btn-warning text-light"><c:out value = "${row.status}"/></a>
               		</c:when>
               		<c:when test="${row.status == 'Approved' }">
               		<a class="btn btn-success text-light"><c:out value = "${row.status}"/></a>
               		</c:when>
               		<c:otherwise>
               		<a class="btn btn-danger text-light"><c:out value = "${row.status}"/></a>
               		</c:otherwise>
               </c:choose>
               </td>
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

<% session.removeAttribute("serialNumber"); %>
</body>
</html>