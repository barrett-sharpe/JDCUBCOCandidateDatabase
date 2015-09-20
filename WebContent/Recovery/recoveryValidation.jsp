<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validating</title>
</head>
<body>

<!-- Declarations and Constants -->
	<%! String usr; %>
	<%! String token; %>

<!-- Session Object Request for Username/Token-->
	<%
	// Grab session object from request.
	session = request.getSession();
			
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("recoveryLoginMessage");
	
	//Collect the username (usr) and recoveryString (token) entered by the user, from the session.
	usr = request.getParameter("username");
	token = request.getParameter("token");
	%>

<!-- DAO validation -->
<%
	DataAccessObject access=new DataAccessObject();

	//check that a username and string were entered, and that user exists in either candidate or company
	if((access.userInCandidateDB(usr)||access.userInCompanyDB(usr))){
		
		//check validity
		boolean valid=access.validateRecoveryToken(usr, token);
		
		if(valid){
			//Successful Login by user
			session.setAttribute("authenticatedUser", usr);
			session.setAttribute("recoveryLoginMessage", null);
			response.sendRedirect("recoveryNewPassword.jsp");
		}else{
			//redirect back to login page with a message
			session.setAttribute("recoveryLoginMessage", "Incorrect Username or Recovery String.");
			response.sendRedirect("recoveryLogin.jsp");
		}
	}else{
		//redirect back to login page with a message
		session.setAttribute("recoveryLoginMessage", "Incorrect Username or Recovery String.");
		response.sendRedirect("recoveryLogin.jsp");	
	}
%>



</body>
</html>