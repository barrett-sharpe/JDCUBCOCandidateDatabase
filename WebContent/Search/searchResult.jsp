<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>

<%@page import="objects.*" %>
<!-- Variables -->
<%! String query;%>
<%! String area; %>
<%! %>

<!-- Get Session/Query -->
<%
	//Grab session object from request.
	session = request.getSession();
	//Get "QueryString"
	query=request.getParameter("queryString");
	//Get the arguments (args). Either "on" or "null"
%>

<!-- Header -->
<h3>Search Results for "<%out.print(query);%>"</h3>


<!-- Java Object -->
<%


//new Search object
//Search s=new Search();

%>
</body>
</html>