<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset Your Password</title>
</head>
<body>
<h1>Password Reset</h1>
<p>In order to reset your password, please login below with your username, and the 'recovery string' that you gave when you created the account.</p>
<p>This is the only way to recover your account.</p>


<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("recoveryLoginMessage") != null)
	out.println("<p id='loginError'>" + session.getAttribute("recoveryLoginMessage").toString() + "</p>");
%>

<!--  Form (note that ACTION $pageContext works)-->
<form name="recovlogin" method=post action="recoveryValidation.jsp"> 
	<table width="40%">
		<tr>
			<td><div align="right">Username:</div></td>
			<td><input type="text" name="username" size=20 value=""></td>
		</tr>
		<tr>
			<td><div align="right">Recovery String:</div></td>
			<td><input type="text" name="token" size=20 value=""></td>
		</tr>
	</table>
	<input type="submit" name="Submit" value="Recover">
</form>


</body>
</html>