<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
<title>JSTL sql:update Tag</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="org.postgresql.Driver"
     url="jdbc:postgresql://localhost:5432/CGCDB_PRODUCT_2557"
     user="postgres"  password="Systemadmin007"/>

<sql:query dataSource="${snapshot}" var="result">
   SELECT * from memployee;
</sql:query>
 
<table border="1" width="100%">
<tr>
<th>Emp ID</th>
<th>First Name</th>
<th>Last Name</th>
<th>Age</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.fname}"/></td>
<td><c:out value="${row.lname}"/></td>
<td><c:out value="${row.last}"/></td>
<td><c:out value="${row.dept_id}"/></td>
</tr>
</c:forEach>
</table>

</body>
</html>