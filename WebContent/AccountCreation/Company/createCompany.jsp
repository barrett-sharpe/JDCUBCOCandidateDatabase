<%@page import="objects.DataAccessObject"%>

<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/AccountCreation/Company/createCompany.css' rel='stylesheet' type='text/css'>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Create Your Profile</title>

</head>
<body>

<h2>Create Your Profile!</h2>
<h3>
We just need some basic information in order to create your account with us.<br>
</h3>
<p>(<span style = "color:red">*</span> - required)</p>

<!-- Variables -->
<%! DataAccessObject dao=new DataAccessObject(); %>
	
<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect the username (uname) entered by the user, from the session.
	String coid=String.valueOf(session.getAttribute("coid"));
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("CompanyMessage");
	%>

<!-- Print Prior Error Account Message If Needed -->
<%
	if (session.getAttribute("CompanyMessage") != null){
		out.println("<h5 id='Error'>" + session.getAttribute("CompanyMessage").toString() + "</h5>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 id='Error2'>" + session.getAttribute("problemList").toString() + "</h5>");
	}
%>

<!-- Form -->
<form name="NewCompanyForm" action="addCompany.jsp" method=POST>
	<table width="70%">
	<tr>
		<td> Company ID:</td>
		<td><%out.println(coid);%></td>
	</tr>
	<tr>
		<td>Company Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='coName' value=''></td>
	</tr>
	<tr>
		<td>Established:</td>
		<td><input type="text" name='coYearEstablished' value=''></td>
	</tr>
	<tr>
		<td>Company Address:</td>
		<td><input type="text" name='coAddress' value=''></td>
	</tr>
	<tr>
		<td>Telephone:</td>
		<td><input type="text" name='coTel' value=''></td>
	</tr>
	<tr>	
		<td>Company Email:</td>
		<td><input type="text" name='coEmail' value=''></td>
	</tr>
	<tr>
		<td>Company Contact:</td>
		<td><input type="text" name='coContactName' value=''></td>
	</tr>
	<tr>
		<td>Company Website:</td>
		<td><input type="text" name='coUrl' value=''></td>
	</tr>
	<tr>
		<td>Company Social:</td>
		<td><input type="text" name='coSocial' value=''></td>
	</tr>
	<tr>
		<td>Company Description:</td>
		<td><textarea rows="5" cols="80" name='coDescription'></textarea>
	</tr>
	</table>
		
	<br>
	<input class='myButton' type="submit" name="submit" value="Create User">
</form>

</body>
</html>
