<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Set New Password</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>

<style type="text/css">
body{
	font-family: Roboto;
	background-color: #F9F9F9; /* off white*/
}
td{
	/*testing*/
	/*border: 1px solid #000000; */
}
.textInput{
	size: 80px;
}
.fieldName{
	align: right;
}

/*loginError*/
#loginError{
	font-style: "color:red";
}

/*test online button css*/
.myButton {
	-moz-box-shadow:inset 0px 1px 0px 0px #54a3f7;
	-webkit-box-shadow:inset 0px 1px 0px 0px #54a3f7;
	box-shadow:inset 0px 1px 0px 0px #54a3f7;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #629dd1), color-stop(1, #0061a7));
	background:-moz-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-webkit-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-o-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-ms-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:linear-gradient(to bottom, #629dd1 5%, #0061a7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#629dd1', endColorstr='#0061a7',GradientType=0);
	background-color:#629dd1;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #124d77;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #154682;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0061a7), color-stop(1, #629dd1));
	background:-moz-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-webkit-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-o-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-ms-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:linear-gradient(to bottom, #0061a7 5%, #629dd1 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0061a7', endColorstr='#629dd1',GradientType=0);
	background-color:#0061a7;
}
.myButton:active {
	position:relative;
	top:1px;
}
</style>

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