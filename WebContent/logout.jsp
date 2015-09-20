<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging Out</title>
</head>
<body>
<p> You are being logged out.</p>

<!-- Clear session and redirect -->
<%
session=request.getSession();
session.removeAttribute("authenticatedUser");
session.invalidate();
%>

<!-- Redirect to homepage -->
<%
response.sendRedirect("homePage.jsp");
%>


</body>
</html>