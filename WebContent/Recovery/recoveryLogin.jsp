<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Reset Your Password</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Recovery/recoveryLogin.css' rel='stylesheet' type='text/css'>


</head>
<body>
<h2>Password Reset</h2>
<p>In order to reset your password, please login below with your Username, and the 'Recovery String' that you gave when you created the account.</p>
<p>This is the only way to recover your account.</p>


<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("recoveryLoginMessage") != null)
	out.println("<p id='loginError'>" + session.getAttribute("recoveryLoginMessage").toString() + "</p>");
%>

<!--  Form (note that ACTION $pageContext works)-->
<form name="recovlogin" method=post action="recoveryValidation.jsp"> 
	<table width="70%">
		<tr>
			<td><div class='fieldName'>Username:</div></td>
		</tr>
		<tr>
			<td><input class='textInput' type="text" name="username" value=""></td>
		</tr>
		<tr>
			<td><div class='fieldName'>Recovery String:</div></td>
		</tr>
		<tr>
			<td><input class='textInput' type="password" name="token" value=""></td>
		</tr>
	</table>
	<br>
	<input class='myButton' type="submit" name="Submit" value="Recover">
</form>


</body>
</html>