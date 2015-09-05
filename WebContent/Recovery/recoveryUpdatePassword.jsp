<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating Password</title>
</head>
<body>

<!-- Declarations and Constants -->
	<%! String pass1; %>
	<%! String pass2; %>

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
if(!pass1.equals(pass2)){
	//redirect back to login page with a message
	session.setAttribute("recoveryNewPasswordMessage", "You passwords do not match. Please try again.");
	response.sendRedirect("recoveryNewPassword.jsp");	
}
%>

<!-- DAO update (METHODS TO UPDATE PASSWOR DNOT IN PLACE YET. forward to login -->

<%request.getRequestDispatcher("../login.jsp").forward(request, response); %>

<!-- UNFUNCTIONAL AT THE MOMENT -->

DO DO DO DO DO DOD ODODODODODODDODODODO



</body>
</html>