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
<style>
.input-group {
	width: 300px;
}
.btn {
	width: auto;
}
</style>
<title>Project - Thanh Duy Tran - J2EE</title>
</head>

<body>
<% if (session.getAttribute("validAdmin") == null) {
	response.sendRedirect("userSignIn.html");
}
%>
<sql:setDataSource
	var="db" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false"
	user="root" password="12345"/>

<c:choose>
<c:when test="${param.search != null }">
	<sql:query dataSource = "${db}" var="result">
            SELECT * FROM devices d
            JOIN users u ON d.userid = u.userid
            JOIN products p ON d.productid = p.productid
            WHERE u.username LIKE ?;
            <sql:param value="%${param.search}%" />
    </sql:query>
</c:when>
<c:otherwise>
	<sql:query dataSource = "${db}" var="result">
            SELECT * FROM devices d
            JOIN users u ON d.userid = u.userid
            JOIN products p ON d.productid = p.productid;
    </sql:query>
    </c:otherwise>
</c:choose>


    
	<c:choose>
	<c:when test="${result != null}">
	<div class="container col-7 border border-primary p-4">
         <jsp:include page="menu.jsp" />
         <h2 class="text-primary">Registered devices information</h2>
<form action="adminViewDevices.jsp" method="GET">
<jsp:include page="searchBar.html" /> 
</form> 
         <table class="table table-striped table-hover">
  <thead>
    <tr>
      <th scope="col">Username</th>
      <th scope="col">Product Name</th>
      <th scope="col">Serial number</th>
      <th scope="col">Purchase date</th>
    </tr>
  </thead>
  <tbody>
           <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.username}"/></td>
               <td> <c:out value = "${row.productname}"/></td>
               <td> <c:out value = "${row.serialnumber}"/></td>
               <td> <c:out value = "${row.purchasedate}"/></td>
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

</body>
</html>