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
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/AccountCreation/Company/createCompanyCredentials.css' rel='stylesheet' type='text/css'>


</head>

<body>

<h1>Join the JDC West UBC Okanagan Candidate Database Today!</h1>
	
<!-- Print Prior Error Account Message If Needed -->
<%
	if(session.getAttribute("CompanyCredentialsMessage") != null){
		out.print("<h3><div class='error'>" + session.getAttribute("CompanyCredentialsMessage").toString() + "</div></h3>");
	}
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
	Integer id=c.getRandomCaptchaID(); //!@#$ Error (all platforms) here
	session.setAttribute("capid", id.toString()); //this makes it work!
	%>
	<img src="${pageContext.request.contextPath}/captcha?capid=<%=id%>" />
	<br>Captcha:<br>
	<input type="text" name='capinput'>
	
	<br>
	
</fieldset>	

<!-- TOS -->
<br>
<fieldset>
<legend>Step 4: Terms Of Service</legend>
<br>
<input type='checkbox' name='agree' id='tos'>
<label for='tos'>&nbsp;I agree to JDC West Team UBC Okanagan's <a href='http://ubcojdcwest.com/'>Terms Of Service</a> regarding the Candidate Database.</label>
<br>
<br>
</fieldset>
	
	<br>
	<br>
	<input class='myButton' type="submit" name="submit" value="Create Account">
</form>
</body>
</html>
