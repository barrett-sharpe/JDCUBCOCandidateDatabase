<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding Account...</title>
</head>
<body>


<!-- Declared Vars -->
<%!
String username="";
String password="";
Integer cid=0;
boolean exists=true;
DataAccessObject dao=new DataAccessObject();
%>

<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect the username (uname) entered by the user, from the session.
	username = request.getParameter("uname");
	password = request.getParameter("pword");
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("cid");
	session.removeAttribute("CandidateCredentialsMessage");
	session.removeAttribute("problemList");//?
	%>
<!-- Attempt to add the Candidate to the db -->
<%
	exists=dao.userInCandidateDB(username);
	if(!exists){
		cid=dao.addCredentialsCandidate(username, password);
	}
%>

<!-- Redirects-->
<% 
	if(!exists){
		out.println("<h1> Thank you "+username+"!</h3>" ); 
		session.setAttribute("cid", cid);
		response.sendRedirect("createCandidate.jsp");
	}else{
		out.println("<h1>Invalid</h1>");
		session.setAttribute("CandidateCredentialsMessage", "The username '"+username+"' already exists. Please choose another username.");
		response.sendRedirect("createCandidateCredentials.jsp");	
	}
%>

</body>
</html>