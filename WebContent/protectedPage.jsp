<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Protected Page</title>
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

<!-- Header -->
<%
out.println("<h1> Welcome back, " + user + ".</h1>");
%>


<!-- List of Links -->

<% 

	if(isCompany){
		//Company
		out.println("<h3><u><a href='profilePage.jsp'> View Company's Profile</a></u></h3>");
		out.println("<h3><u><a href='Search/search.jsp'>Search For A Candidate</a></u></h3>");
		//!@# to do
		out.println("<h3><p>To Do:</p></h3>");
		out.println("<h3><u> Edit Company Profile</u></h3>");
		
	}else{
		//Candidate
		out.println("<h3><u><a href='profilePage.jsp'> View Your Profile</a></u></h3>");
		out.println("<h3><u><a href='AccountEdit/Candidate/editCandidate.jsp'> Edit Profile</a></u></h3>");
		out.println("<h3><u><a href='companyDirectory.jsp'> Company Directory</a></u></h3>");
		
		//!@# to do
		out.println("<h3><p>To Do:</p></h3>");
		
	}

%>



</body>
</html>