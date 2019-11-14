<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<jsp:useBean id="dbquery" class="dbtest.DBQuery" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>queryDB.jsp</title>
</head>
<body>
<h1>Welcome to My mysql Database:</h1>
<h2>
<%= dbquery.getDbName() %>
</h2>
This page will provide a overall of all tables, if your want a more detail, see this <a href="queryDB2.jsp">page</a>.

<form action="" method="post">
<select name="tableName">
	<option value="countries">countries</option>
	<option value="departments">departments</option>
	<option value="employees">employees</option>
	<option value="jobs">jobs</option>
	<option value="locations">locations</option>
	<option value="regions">regions</option>
</select>
<input type="submit" value="submit" name="submit" />
</form>
<jsp:setProperty name="dbquery" property="*" />

The DB query result:<br>
<jsp:getProperty name="dbquery" property="queryResult" />



</body>
</html>