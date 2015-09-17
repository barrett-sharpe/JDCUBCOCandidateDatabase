<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Set New Password</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Recovery/recoveryNewPassword.css' rel='stylesheet' type='text/css'>

</head>
<body>
<!-- Authorized Page -->
<%@ include file="../auth.jsp"%>


<!-- Title -->
<h2>Enter Your New Password</h2>
<p>Please enter your new password below. Retype your password to confirm.

<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("recoveryNewPasswordMessage") != null)
	out.println("<font color='red'><p>" + session.getAttribute("recoveryNewPasswordMessage").toString() + "</p></font>");
%>

<!--  Form -->
<form name="recovNewPass" method=post action="recoveryUpdatePassword.jsp"> 
	<table width="40%">
		<tr>
			<td><div class='fieldName'>New Password:</div></td>
		</tr>
		<tr>
			<td><input class='textInput' type="password" name="pass1" value=""></td>
		</tr>
		<tr>
			<td><div class='fieldName'>Retype:</div></td>
		</tr>
		<tr>
			<td><input class='textInput' type="password" name="pass2" value=""></td>
		</tr>
	</table>
	<br>
	<input class='myButton' type="submit" name="Submit" value="Change Password">
</form>


</body>
</html>