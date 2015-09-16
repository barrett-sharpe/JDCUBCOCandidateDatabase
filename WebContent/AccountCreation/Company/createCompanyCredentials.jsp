<%@page import="objects.Captcha"%>
<%@page import="objects.DataAccessObject"%>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Sign Up with JDC West UBC Okanagan</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>

<style type="text/css">
body{
	font-family: Roboto;
	background-color: #F9F9F9; /* off white*/
}

/*error*/
#error{
	font-style: "color:red";
}

/*legend*/
legend{
	font-weight: bold; 
}

/*Captcha*/
img{
	border: 2px solid #999999;
}

/*button*/
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

<h1>Join the JDC West UBC Okanagan Candidate Database Today!</h1>
	
<!-- Print Prior Error Account Message If Needed -->
<%
	if (session.getAttribute("CompanyCredentialsMessage") != null)
	out.println("<span style='color:red><p>" + session.getAttribute("CompanyCredentialsMessage").toString() + "</p></span>");
%>

<!-- Account Form -->
<form name="CompanyCredentialsForm" action="addCompanyCredentials.jsp" method=POST>

<fieldset >
<legend>Step 1: Account</legend>
<p>Please create a Username and a Password for your new account.</p>
	<table width="70%">
	<tr>
		<td>Username:</td>
	</tr>
	<tr>
		<td><input type='text' name='uname' value=''></td>
	</tr>
	<tr>
		<td>Password:</td>
	</tr>
	<tr>
		<td><input type='password' name='pword' value=''></td>
	</tr>
	<tr>
		<td>Retype Password:</td>
	</tr>
	<tr>
		<td><input type='password' name='pword2' value=''></td>
	</tr>	
	</table>
</fieldset>
<br>
<fieldset>
<legend>Step 2: Recovery String</legend>
<p>This functions like a secret word or phrase. If you forget your password, you can use this word or phrase to reset your password. Do not forget this secret word or phrase, as this is the <span style = "color:red">ONLY</span> way to recover your account. We suggest that you write this down somewhere!</p>
<table width="70%">
	<tr>
		<td>Recovery String:</td>
	</tr>
	<tr>
		<td><input type='password' name='rs1' value=''></td>
	</tr>
	<tr>
		<td>Retype Recovery String:</td>
	</tr>
	<tr>
		<td><input type='password' name='rs2' value=''></td>
	</tr>
</table>	
</fieldset>
<br>
<fieldset>
<legend>Step 3: Captcha</legend>
<p>Please complete the following captcha, to prevent a robot uprising in our database. Thank-you :)</p>

	<!-- //Capcha -->	
	<%
	Captcha c=new Captcha();
	Integer id=c.getRandomCaptchaID();
	session.setAttribute("capid", id.toString()); //this makes it work!
	%>
	<img src="${pageContext.request.contextPath}/captcha?capid=<%=id%>" />
	<br>Captcha:<br>
	<input type="text" name='capinput'>
	
	<br>
	
</fieldset>	
	
	<br>
	<br>
	<input class='myButton' type="submit" name="submit" value="Create Account">
</form>
</body>
</html>
