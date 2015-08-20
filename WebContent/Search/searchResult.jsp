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
<%! String[] args;%>

<!-- Get Session/Query -->
<%
	//Grab session object from request.
	session = request.getSession();
	//Get "QueryString"
	query=request.getParameter("queryString");
	//Get the arguments (args). Either "on" or "null"
	args=new String[5];
	//By Daniel's Request, No Ability To Filter By Gender
	//args[0]=request.getParameter("isMale");
	//args[1]=request.getParameter("isFemale");
	//args[2]=request.getParameter("isTrans");
	//args[3]=request.getParameter("isOther");
	args[0]=null;
	args[1]=null;
	args[2]=null;
	args[3]=null;
	args[4]=request.getParameter("area");
%>

<!-- Header -->
<h3>Search Results for "<%out.print(query);%>"</h3>


<!-- Java Object -->
<%
//TEST PRINT Args
for(String s: args){
	out.println(s);
}

//new Search object
//Search s=new Search();

%>
</body>
</html>