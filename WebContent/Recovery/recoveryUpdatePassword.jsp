<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Updating Password</title>

</head>
<body>

<!-- Authorized Page -->
<%@ include file="../auth.jsp"%>

<!-- Declarations and Constants -->
	<%! String pass1; %>
	<%! String pass2; %>

<!-- Variables -->
<%
session=request.getSession();
String user=(String)session.getAttribute("authenticatedUser");
//TEST
System.out.println("got the username "+user+" from the session");
%>

<!-- Session Object Request for Passwords-->
	<%
	// Grab session object from request.
	session = request.getSession();
			
	//Clean session of unwanted attributes
	session.removeAttribute("recoveryNewPasswordMessage");
	
	//Collect the username (usr) and password (psw), entered by the user, from the session.
	pass1 = request.getParameter("pass1");
	pass2 = request.getParameter("pass2");
	%>

<!-- Check if pass1==pass2 -->
<%

%>

<!-- DAO -->
<%
DataAccessObject dao=new DataAccessObject();
boolean reset=false;
boolean goodPassword=pass1.equals(pass2);

if(goodPassword){
	reset=dao.resetPassword(user, pass1);
}else{
	session.setAttribute("recoveryNewPasswordMessage", session.getAttribute("recoveryNewPasswordMessage")+" You passwords do not match. Please try again.");
}

//if properly reset and passwords match
if(reset && goodPassword){
	request.getRequestDispatcher("../login.jsp").forward(request, response);
}else{
	session.setAttribute("recoveryNewPasswordMessage", session.getAttribute("recoveryNewPasswordMessage")+" There was an error reseting your password. Please try again.");
	response.sendRedirect("recoveryNewPassword.jsp");
}
			
%>



</body>
</html>