<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<ul class="nav justify-content-center">
  <li class="nav-item">
    <a class="nav-link">User: <c:out value="${username}"/></a>
  </li>
  
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="Dashboard">Dashboard</a>
  </li>

  <li class="nav-item">
    <a class="nav-link" href="SignOut">Sign Out</a>
  </li>

</ul>