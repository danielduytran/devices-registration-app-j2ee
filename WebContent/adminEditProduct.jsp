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
<% if (session.getAttribute("validAdmin") == null) {
	response.sendRedirect("userSignIn.html");
}
	session.setAttribute("productid", request.getParameter("productid"));
	session.setAttribute("productName", request.getParameter("productName"));
	session.setAttribute("model", request.getParameter("model"));
	session.setAttribute("brand", request.getParameter("brand"));
%>

  <div class="container col-5 border border-primary p-4">
  <jsp:include page="menu.jsp" />  
    <div class="row">
      <h2 class="text-primary">EDIT PRODUCT IN PROTECTION PLAN</h2>
    </div>
    <form action="AdminEditProduct" method="POST">
      <fieldset class="border border-primary my-4 p-2">
        <legend class="w-auto">Modify product's information</legend>
        
        <div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Product Name:</label>
          </div>
          <div class="col-5">
            <input type="text" class="form-control" name="productName" value="${productName}" />
          </div>
        </div>

        <div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Model:</label>
          </div>
          <div class="col-5">
            <input type="text" class="form-control" name="model" value="${model}" />
          </div>
        </div>

		<div class="row">
          <div class="col-3 text-end">
            <label class="form-label">Brand:</label>
          </div>
          <div class="col-5">
            <input type="text" class="form-control" name="brand" value="${brand}" />
          </div>
        </div>
      </fieldset>

      <!-- FIELD SET 4-->
      <fieldset class="border my-4 p-2 border-primary">
        <legend class="w-auto">Edit Product</legend>
        <div class="row">
          <div class="col-4 text-center">
            <input class="btn btn-primary btn-lg" type="submit" value="Edit" name="register" />
          </div>
          <div class="col-4 text-center">
            <input class="btn btn-primary btn-lg" type="reset" value="Reset" />
          </div>
        </div>
      </fieldset>
    </form>
  </div>
</body>
<%
session.removeAttribute("productName");
session.removeAttribute("brand");
session.removeAttribute("model");
%>
</html>
