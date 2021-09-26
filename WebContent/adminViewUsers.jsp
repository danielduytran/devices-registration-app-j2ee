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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<title>Project - Thanh Duy Tran - J2EE</title>
<style>
.input-group {
	width: 300px;
}
.btn {
	width: auto;
}
</style>
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
            SELECT * FROM users
            WHERE username LIKE ?;
            <sql:param value="%${param.search}%" />
    </sql:query>
</c:when>
<c:otherwise>
<sql:query dataSource = "${db}" var="result">
            SELECT * FROM users;
    </sql:query>
    </c:otherwise>
</c:choose>
    
	<c:choose>
	<c:when test="${result != null}">
	<div class="container col-8 border border-primary p-4">
         <jsp:include page="menu.jsp" />  
          <h2 class="text-primary">Registered users information</h2>
          <form action="adminViewUsers.jsp" method="GET">
<jsp:include page="searchBar.html" /> 
          </form>
          <table class="table table-striped table-hover">
  <thead>
    <tr>
      <th scope="col">Username</th>
      <th scope="col">Phone</th>
      <th scope="col">Email</th>
      <th scope="col">First Name</th>
      <th scope="col">Last Name</th>
      <th scope="col">Address</th>
      <th scope="col">Is Admin</th>
    </tr>
  </thead>
  <tbody>
           <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.username}"/></td>
               <td> <c:out value = "${row.phone}"/></td>
               <td> <c:out value = "${row.email}"/></td>
               <td> <c:out value = "${row.firstname}"/></td>
               <td> <c:out value = "${row.lastname}"/></td>
               <td> <c:out value = "${row.address}"/></td>
               <td> <c:out value = "${row.isAdmin}"/></td>
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