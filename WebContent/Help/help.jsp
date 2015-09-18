<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Help</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Help/help.css' rel='stylesheet' type='text/css'>

</head>

<body>

<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href='../homePage.jsp'>To Homepage</a></div>");
%>

<!-- Title -->
<h2>Need Help? What Would You Like To Know About?</h2>

<br>

<h3>Are you looking for:</h3>
<ul>
	<li id='candidate'><a href='#candidate'>Candidate Help</a></li>
	<li id='company'><a href='#company'>Company Help</a></li>
</ul>

<br> <br> <br>

<fieldset id='candidate'>
<a name='candidate'></a>
<legend>Candidate Help</legend>

<h4>Here are the help categories for Candidates</h4>
<ul>
	<li><a href='faq.jsp'>FAQ - Frequently Asked Questions</a></li>
	<li><a href='resumeHelp.jsp'>How to get your resume on your Profile</a></li>
</ul>
</fieldset>

<br> <br> <br> <br>

<fieldset id='company'>
<a name='company'></a>
<legend>Company Help</legend>

<h4>Here are the help categories for Companies</h4>
<ul>
	<li><a href='faq.jsp'>FAQ - Frequently Asked Questions</a></li>
	<li>How your Profile Page should be used</li>
</ul>


</fieldset>

</body>
</html>