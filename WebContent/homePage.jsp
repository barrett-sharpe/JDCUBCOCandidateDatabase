<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Candidate Database</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/homePage.css' rel='stylesheet' type='text/css'>

</head>

<body>

<!-- Title -->
<h2><u>JDC West UBC Okanagan - Candidate Database</u></h2>

<!-- Table -->
<h3> Please select one of the below options:</h3>
<table id='table'>
<tr>
	<td>
		<div class="divBox">
			<a href="login.jsp">Login</a>
		</div>
	</td>
	<td>
		Already a user? Log in to your account by clicking "Login".
	</td>
</tr>
<tr>
	<td>
		<div class="divBox">
		<a href="Recovery/recoveryLogin.jsp">Forgot Password</a>
		</div>
	</td>
	<td>
		Forgotten the password for your account? Click on "Forgot Password" to begin to reset your password.
	</td>
</tr>
<tr>
	<td>
		<div class="divBox">
		<a href="AccountCreation/Candidate/createCandidateCredentials.jsp">New Candidate</a>
		</div>
	</td>
	<td>
		Are you looking to start a profile, and have your resume viewed by companies looking to hire? Click on "New Candidate" to get started creating your profile.
	</td>
</tr>

<!-- Change Below to Company -->
<tr>
	<td>
		<div class="divBox">
		<a href="AccountCreation/Company/createCompanyCredentials.jsp">New Company</a>
		</div>
	</td>
	<td>
		Are you a corporate sponsor of JDC West UBC Okanagan, or looking to access the potential of JDC West UBC Okanagan's candidate pool? Click on "New Company" to begin creating an account for your organization.
	</td>
</tr>
</table>

<!-- Help -->
<h4>New To The Candidate Database? Need Help? Lost?</h4>
<table id='table'>
	<tr>
		<td>
			<div class="divBox" id='help'>
				<a href="Help/help.jsp">Help</a>
			</div>
		</td>
		<td>Read our Help pages</td>
	</tr>
	<tr>
		<td>
			<div class="divBox" id='help'>
				<a href="http://ubcojdcwest.com/">UBCOJDCW</a>
			</div>
		</td>
		<td>Return to Team UBC Okanagan's JDC West Page.</td>
	</tr>
</table>

<!-- Copyright -->
<h6>&copy; Copyright of <a href='https://ca.linkedin.com/pub/barrett-sharpe/bb/6a9/597'>Barrett Sharpe</a>, 2015. Licensed to JDC West Team UBC Okanagan.</h6>

</body>

</html>

<!-- 
JSP using MVC and JDBC
http://stackoverflow.com/questions/5003142/jsp-using-mvc-and-jdbc/5003701#5003701

Should eventually use a java.util.Properties file to connect to database instead of hardcoded user/password

PHPMyAdmin needs 2 versions of a user: host %, and host localhost. See user 'iamroot'

[DONE] Set up online repo.
 -->