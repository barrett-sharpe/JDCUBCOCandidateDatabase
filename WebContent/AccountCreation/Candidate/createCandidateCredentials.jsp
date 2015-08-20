<%@page import="objects.DataAccessObject"%>

<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up with JDCWest</title>
</head>
<body>

<h1>Join JDC West Today!</h1>
<h3>
Please create a username and password for your account.<br>
</h3>
	
<!-- Print Prior Error Account Message If Needed -->
<%
	if (session.getAttribute("CandidateCredentialsMessage") != null)
	out.println("<p id='Error'>" + session.getAttribute("CandidateCredentialsMessage").toString() + "</p>");
%>

<!-- Account Form -->
<form name="CandidateCredentialsForm" action="addCandidateCredentials.jsp" method=POST>
	<table width="70%">
	<tr>
		<td>Username:</td>
		<td><input type='text' name='uname' value=''></td>
	</tr>
	<tr>
		<td>Password:</td>
		<td><input type='password' name='pword' value=''></td>
	</tr>	
	</table>
	
	<!-- //!@# Future Capcha to go here -->
	Capcha Here
	
	<br>
	<input type="submit" name="submit" value="Create Account">
</form>

</body>
</html>
