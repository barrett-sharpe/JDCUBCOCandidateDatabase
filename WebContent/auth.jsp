<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<%
	Object authUser= session.getAttribute("authenticatedUser");
	boolean authenticated = (authUser==null)? false : true;
	if (!authenticated){
		String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
		session.setAttribute("loginMessage",loginMessage);
		response.sendRedirect("login.jsp");
		return;
	}
%>
</body>
</html>
