<%@page import="objects.*"%>
<%@page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>testQuery</title>
</head>
<body>

<!-- Beyond Page -->
<a href='beyondPage.jsp'>Go Beyond></a>

<h1> Test Query:</h1>

<p>Getting user 'BarrettSharpe'.<p>
<%
//New DAO
DataAccessObject dao=new DataAccessObject();

//Candidate BarrettSharpe
Candidate can=new Candidate();
Map<String,Object> m=dao.getUser("BarrettSharpe");
can.setCandidate(dao.getCandidate(Integer.parseInt(m.get("cid").toString())));
%>

<p>Closing the DAO</p>
<%
dao.closeConnection();
%>

<p>Printing BarrettSharpe</p>
<%
out.println("<p>"+can.printoutString(true)+"</p>");
%>

</body>
</html>