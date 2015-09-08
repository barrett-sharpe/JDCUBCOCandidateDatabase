<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Login Page</title>

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
<h2>Please Enter Your Login</h2>

<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("loginMessage") != null)
	out.println("<p id='loginError'>" + session.getAttribute("loginMessage").toString() + "</p>");
%>

<!--  Form (note that ACTION $pageContext works)-->
<form name="MyForm" method=post action="${pageContext.servletContext.contextPath}/validateLogin.jsp"> 
	
	<table width="40%">
		<tr>
			<td>
				<div class='fieldName'>
				Username:
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='textInput'>
					<input type="text" name="username" value="">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='fieldName'>
				Password:
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='textInput'>
					<input type="password" name="password" value="">
				</div>
			</td>
		</tr>
	</table>
	
	<!-- Submit -->
	<br>
	<input class='myButton' type="submit" name="Submit" value="Log In">

</form>

</body>
</html>

<!-- Old Table

<table width="40%">
		<tr>
			<td>
				<div class='fieldName'>
				Username:
				</div>
			</td>
			<td>
				<div class='textInput'>
					<input type="text" name="username" value="">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='fieldName'>
				Password:
				</div>
			</td>
			<td>
				<div class='textInput'>
					<input type="password" name="password" value="">
				</div>
			</td>
		</tr>
	</table>

 -->