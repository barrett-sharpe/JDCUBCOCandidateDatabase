<%@page import="objects.Company"%>
<%@page import="objects.DataAccessObject"%>
<%@page import="objects.CoMap"%>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Edit Your Profile</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/AccountEdit/Company/editCompany.css' rel='stylesheet' type='text/css'>

</head>
<body>

<h3>
Please edit your profile information below, and hit save at the bottom of the page.
</h3>
<p>(<span style = "color:red">*</span> - required)</p>

<!-- Variables -->
<%! DataAccessObject dao=new DataAccessObject(); %>
	
<!-- Session Object Request for Username-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect the user id (cid), from the session.
	Integer coid=Integer.parseInt((String)session.getAttribute("uid")); 
	
	//Clean session of unwanted attributes
	
	
	%>

<!-- Print Prior Error Account Message If Needed -->
<%
	// Print prior error login message if needed
	if (session.getAttribute("UpdateMessage") != null){
		out.println("<p id='loginError'>" + session.getAttribute("UpdateMessage").toString() + "</p>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 id='Error2'>" + session.getAttribute("problemList").toString() + "</h5>");
	}
%>

<!-- Get the Company's Info from the DB -->
<%
	CoMap co=dao.getCompany(coid);
%>

<!-- Form -->
<form name="EditUserForm" action="updateCompany.jsp" method=POST>
	<table width="70%">
	<tr>
		<td> Company ID:</td>
		<td><%out.println(coid);%></td>
	</tr>
	<tr>
		<td>Company Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='coName' value='<%=co.get("coName").toString()%>'></td>
	</tr>
	<tr>
		<td>Established:</td>
		<td><input type="text" name='coYearEstablished' value='<%=co.get("coYearEstablished").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Address:</td>
		<td><input type="text" name='coAddress' value='<%=co.get("coAddress").toString()%>'></td>
	</tr>
	<tr>
		<td>Telephone:</td>
		<td><input type="text" name='coTel' value='<%=co.get("coTel").toString()%>'></td>
	</tr>
	<tr>	
		<td>Company Email:</td>
		<td><input type="text" name='coEmail' value='<%=co.get("coEmail").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Contact:</td>
		<td><input type="text" name='coContactName' value='<%=co.get("coContactName").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Website:</td>
		<td><input type="text" name='coUrl' value='<%=co.get("coUrl").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Social:</td>
		<td><input type="text" name='coSocial' value='<%=co.get("coSocial").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Description:</td>
		<td><textarea rows="5" cols="80" name='coDescription'><%=co.get("coDescription").toString()%></textarea>
	</tr>
	</table>	
	<br>
	<input class='myButton' type="submit" name="submit" value="Save Changes">
</form>

</body>
</html>
