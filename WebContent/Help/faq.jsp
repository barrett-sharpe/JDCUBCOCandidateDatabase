<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>FAQ - Frequently Asked Questions</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Help/faq.css' rel='stylesheet' type='text/css'>

</head>
<body>
<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href='help.jsp'>Return To Help</a></div>");
%>

<!-- Title -->
<h2>Frequently Asked Questions</h2>
<!-- words -->
<br>

<div class='question'>
<p><em>"What is this 'Resume Database' website, and who uses it?"</em></p>
<p>This website is used by people and companies who are associated with the UBC Okanagan team of JDC West. The purpose of this website is to better facilitate the search process happening between people and companies when looking for a job or seeking a candidate for a job position.</p>
</div>
<br>
<div class='question'>
<p><em>"So how does this website work?"</em></p>  
<p>Well, we have two types of users of this website and database: 'Candidates' and 'Companies'.
<p>As a Candidate user, you can create a profile detailing your skills, including information about what area you are/were in, and a biography, job history, and a link to your resume. Browse our directory of companies, and the information they provide, learning more about them and what they are looking for in a candidate.</p>
<p>As a Comapany user, you can search our database of candidates in order to find only the relevant and eligible candidates for the positions you're looking to fill. Your company can also make a profile in our database, which can be viewed by the candidates, allowing you to detail job position and contact information, so that candidates can get an understanding of who you are and what's important to you.</p> 
</div>


</body>
</html>