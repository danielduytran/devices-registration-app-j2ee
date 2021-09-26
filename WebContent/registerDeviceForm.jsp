<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="ISO-8859-1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
 <link rel="stylesheet" href="styles.css">
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

<sql:query dataSource = "${db}" var="result">
	SELECT productid, productname FROM products; 
</sql:query>
    
  <div class="container col-5 border border-primary p-4">
  <jsp:include page="menu.jsp" />  
    <div class="row">
    
      <h2 class="text-primary">REGISTER YOUR DEVICE</h2>
    </div>
    <form action="registerDevice.jsp" method="POST">
      <fieldset class="border border-primary my-4 p-2">
        <legend class="w-auto">Fill in your device's information</legend>
        
        <div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Product Name:</label>
          </div>
          <div class="col-5">
            <select name="productName">
            <option value="Select product name">Select product name</option>
            <c:forEach var = "row" items = "${result.rows}">
              <option value="${row.productname}"><c:out value="${row.productname}"/></option> 
         	</c:forEach>
            </select>
          </div>
        </div>
        
        <div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Serial Number:</label>
          </div>
          <div class="col-5">
            <input type="text" class="form-control" name="serialNumber" required/>
          </div>
        </div>

		<div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Purchase Date:</label>
          </div>
          <div class="col-5">
            <input type="date" class="form-control" name="purchaseDate" required/>
          </div>
        </div>
      </fieldset>

      <!-- FIELD SET 4-->
      <fieldset class="border my-4 p-2 border-primary">
        <legend class="w-auto">Submit Registration</legend>
        <div class="row">
          <div class="col-4 text-center">
            <input class="btn btn-primary btn-lg" type="submit" value="Register" name="register" />
          </div>
          <div class="col-4 text-center">
            <input class="btn btn-primary btn-lg" type="reset" value="Reset" />
          </div>
        </div>
      </fieldset>
    </form>
  </div>
</body>

</html>
