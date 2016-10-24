<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<body>
<table class="table">
    <thead>
      <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Mobile Phone</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${contacts}" var="con">
      <tr>
        <td>${con.id}</td>
        <td>${con.name}</td>
        <td>${con.mobilePhone}</td>
        <td>${con.email}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

</body>
</html>