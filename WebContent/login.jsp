<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>
<body>
<h2>Please Enter Your Login</h2>

<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("loginMessage") != null)
	out.println("<p id='loginError'>" + session.getAttribute("loginMessage").toString() + "</p>");
%>
<br>

<!--  Form (note that ACTION $pageContext works)-->
<form name="MyForm" method=post action="${pageContext.servletContext.contextPath}/validateLogin.jsp"> 
	<table width="40%">
		<tr>
			<td><div align="right">Username:</div></td>
			<td><input type="text" name="username" size=8 value=""></td>
		</tr>
		<tr>
			<td><div align="right">Password:</div></td>
			<td><input type="password" name="password" size=8 value=""></td>
		</tr>
	</table>
	<input type="submit" name="Submit" value="Log In">
</form>
</body>
</html>