<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Candidate Database</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>

<style type="text/css">
body{
	font-family: Roboto;
	background-color: #F9F9F9; /* off white*/
}
td{
	padding: 5px;
	
	/*testing purposes only*/
	/*border: 1px solid #000000;*/
}
.divBox
{
    width: 120px;
    height: 45px;
    border: 2px solid #5F5F5F;
    background-color: #629DD1; /*JDCWUBCO blue*/
    font-weight: 700;
}
.divBox a
{
    width: 100%;
    height: 100%;
    text-align: center;
    text-decoration: none;
    display: block;
    color: #FFFFFF;
}
.divBox a:HOVER {
	/*
	background-color: #F0F0F0; /*light grey*/
	background-color: #A1C4E3; /*light JDC blue*/
}
.divBox a:VISITED a:ACTIVE a:AFTER {
	text-decoration: none;
}
</style>
</head>

<body>

<!-- Title -->
<h2><u>JDC West UBC Okanagan Candidate Database</u></h2>

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
		<a href="AccountCreation/Candidate/createCandidateCredentials.jsp">New Company</a>
		</div>
	</td>
	<td>
		Are you a corporate sponsor of JDC West UBC Okanagan, or looking to access the potential of JDC West UBC Okanagan's candidate pool? Click on "New Company" to begin creating an account for your organization.
	</td>
</tr>
</table>

<!-- words -->
<br>
<h3>Questions?:</h3>

<p><em>"What is this 'Candidate Database' website, and who uses it?"</em></p>
<p>This website is used by people and companies who are associated with the UBC Okanagan team of JDC West. The purpose of this website is to better facilitate the search process happening between people and companies when seeking an eligible job or candidate for a job position.
<br>
<p><em>"How does this work?"</em></p>  
<p>Well, we have two types of users of this database: 'Candidates' and 'Companies'.
<p>As a Candidate user, you can create a profile detailing your skills, including information about what area you are/were in, and a biography, job history, and a link to your resume. Browse our directory of companies, and the information they provide, learning more about them and what they are looking for in a candidate.</p>
<p>As a Comapny user, you can search our database of candidates in order to find only the relevant and eligible candidates for the positions you're looking to fill. Your company can also make a profile in our database, which can be viewed by the candidates, allowing you to detail job position and contact information, so that candidates can get an understanding of who you are and what's important to you.</p> 

</body>


</html>

<!-- 
JSP using MVC and JDBC
http://stackoverflow.com/questions/5003142/jsp-using-mvc-and-jdbc/5003701#5003701

Should eventually use a java.util.Properties file to connect to database instead of hardcoded user/password

PHPMyAdmin needs 2 versions of a user: host %, and host localhost. See user 'iamroot'

[DONE] Set up online repo.
 -->