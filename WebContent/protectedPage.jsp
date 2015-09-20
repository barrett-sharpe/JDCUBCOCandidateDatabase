<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Welcome Back</title>
<!-- Require $pagecontext for css ref -->
<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/protectedPage.css' rel='stylesheet' type='text/css'>

</head>

<body>

<!-- Authorized Page -->
<%@ include file="auth.jsp"%>

<!-- Session -->
<%
	// Grab session object from request.
	session = request.getSession();
	//Get Session info
	String user = (String) session.getAttribute("authenticatedUser");
	String id = (String) session.getAttribute("uid");
	boolean isCompany = Boolean.parseBoolean(String.valueOf(session.getAttribute("isCompany")));
	
	//Set Session Info
	session.setAttribute("isCompany", isCompany); //isCompany
	session.setAttribute("uid", id);				//uid (either cid or coid)
	session.setAttribute("authenticatedUser", user);
%>

<!-- Logout -->
<%
out.println("<div class='logout'><a href='logout.jsp'>Log Out</a></div>");
%>

<!-- Named Header -->
<%
DataAccessObject dao=new DataAccessObject();
String name=dao.fetchNameString(id, isCompany);
out.println("<h1> Welcome back, " +name+ "!</h1>");
dao.closeConnection();
%>


<!-- List of Links -->

<% 

	if(isCompany){
		//Company
		//out.println("<h3><u><a href='profilePage.jsp'> View Company Profile</a></u></h3>");
		//out.println("<h3><u> Edit Company Profile</u></h3>");
		//out.println("<h3><u><a href='companyDirectory.jsp'>Directory Of All Companies</a></u></h3>");
		//out.println("<h3><u><a href='Search/search.jsp'>Search For A Candidate</a></u></h3>");
		//out.println("<h3><u><a href='Recovery/recoveryNewPassword.jsp'>Change Account Password</a></u></h3>");
		
		//table form
		out.println("<table>");
		//row 1
		out.println("<tr>");
		out.println("<td><div class='divBox'><a href='profilePage.jsp'> View Company Profile</a></div></td>");
		out.println("<td><p>View your Company's profile.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 2
		out.println("<td><div class='divBox'><a href='AccountEdit/Company/editCompany.jsp'> Edit Company Profile</a></div></td>");
		out.println("<td><p>Update information on your Company's Profile.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 3
		out.println("<td><div class='divBox'><a href='companyDirectory.jsp'>Directory Of Companies</a></div></td>");
		out.println("<td><p>View the directory of all of the other Companies that are also using the Candidate Database.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 4
		out.println("<td><div class='divBox'><a href='Search/search.jsp'>Search For A Candidate</a></div></td>");
		out.println("<td><p>Search the Candidate Database for an ideal Candidate.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 5
		out.println("<td><div class='divBox'><a href='Recovery/recoveryNewPassword.jsp'>Change Password</a></div></td>");
		out.println("<td><p>Change your Company's account password.</p></td>");
		//
		out.println("</tr>");
		out.println("</table>");
	}else{
		//Candidate
		//out.println("<h3><u><a href='profilePage.jsp'> View Your Profile</a></u></h3>");
		//out.println("<h3><u><a href='AccountEdit/Candidate/editCandidate.jsp'> Edit Your Profile</a></u></h3>");
		//out.println("<h3><u><a href='companyDirectory.jsp'>Directory Of All Companies</a></u></h3>");
		//out.println("<h3><u><a href='Recovery/recoveryNewPassword.jsp'>Change Account Password</a></u></h3>");
		
		//table form
		out.println("<table>");
		out.println("<tr>");
		//row 1
		out.println("<td><div class='divBox'><a href='profilePage.jsp'> View Your Profile</a></div></td>");
		out.println("<td><p>View your profile page.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 2
		out.println("<td><div class='divBox'><a href='AccountEdit/Candidate/editCandidate.jsp'> Edit Your Profile</a></div></td>");
		out.println("<td><p>Update information on your Profile page.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 3
		out.println("<td><div class='divBox'><a href='companyDirectory.jsp'>Directory Of Companies</a></div></td>");
		out.println("<td><p>View the Profiles of all of the Companies that are using the Candidate Database.</p></td>");
		//
		out.println("</tr>");
		out.println("<tr>");
		//row 4
		out.println("<td><div class='divBox'><a href='Recovery/recoveryNewPassword.jsp'>Change Password</a></div></td>");
		out.println("<td><p>Change your account password.</p></td>");
		//
		out.println("</tr>");
		out.println("</table>");
	}

%>



</body>
</html>