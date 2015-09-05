<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Set New Password</title>
</head>
<body>
<!-- Authorized Page -->
<%@ include file="../auth.jsp"%>


<!-- Title -->
<h1>Enter Your New Password</h1>
<p>Please enter your new password below. Retype your password to confirm.

<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("recoveryNewPasswordMessage") != null)
	out.println("<p id='loginError'>" + session.getAttribute("recoveryNewPasswordMessage").toString() + "</p>");
%>

<!--  Form -->
<form name="recovNewPass" method=post action="recoveryUpdatePassword.jsp"> 
	<table width="40%">
		<tr>
			<td><div align="right">New Password:</div></td>
			<td><input type="password" name="pass1" size=20 value=""></td>
		</tr>
		<tr>
			<td><div align="right">Retype:</div></td>
			<td><input type="password" name="pass2" size=20 value=""></td>
		</tr>
	</table>
	<input type="submit" name="Submit" value="Change Password">
</form>


</body>
</html>