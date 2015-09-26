<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Uploading...</title>
</head>
<body>
<!-- Authorized Page.-->
<%@ include file="../auth.jsp"%>

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

<!-- Get picture -->
<%
byte[] b=Byte..getAttribute("picture");
%>

<!-- DAO and upload -->
<%
DataAccessObject dao=new DataAccessObject();
dao.
%>
</body>
</html>