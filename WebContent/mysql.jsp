<%@page import="java.io.FileNotFoundException"%>
<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="US-ASCII"%>
<%@ page import='java.sql.*' %>
<%@ page import='javax.sql.*' %>
<%@ page import='javax.naming.*' %>

<%@ page import='java.io.FileInputStream'%>
<%@ page import='java.io.IOException'%>
<%@ page import='java.sql.SQLException'%>
<%@ page import='java.util.Properties'%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Tomcat Server Datasource Example</title>
</head>
<body>

<!-- 
<p>Future Home @:<p>
<p>resumebank.ubcojdcwest.rhcloud.com<p>

-->

<p>RedHat's DataSource:</p>
<%
Connection result2 = null;
try {
    InitialContext ic = new InitialContext();
    Context initialContext = (Context) ic.lookup("java:comp/env");
    DataSource datasource = (DataSource) initialContext.lookup("jdbc/MySQLDS");
    result2 = datasource.getConnection();
    Statement stmt = result2.createStatement() ;
    String query = "select * from names;" ;
    ResultSet rs = stmt.executeQuery(query) ;
    out.println("<p> Attempting to fetch from rhcloud MySQL 'names' using their DataSource connection.</p><br>");
    while (rs.next()) {
        out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br />");
    }
} catch (Exception ex) {
    out.println("<p>DataSource Exception:</p>");
    out.println("<p>getMessage(): " + ex.getMessage()+"</p>");
    out.println("<p>getLocalizedMessgae(): "+ex.getLocalizedMessage()+"</p>");
}
%>
<br>
<p>My DataAccessObject's establishConnection()</p>

<%
try{
	DataAccessObject dao2=new DataAccessObject();
	Connection c=dao2.getCon();
	if(c==null){
		out.println("<p>con was null :( </p>");
	}else{
		out.println("<p>con alive :) </p>");
	}
	String query="SELECT * FROM names;";
	PreparedStatement ps=c.prepareStatement(query);
	ResultSet rs = ps.executeQuery();
	out.println("<p> Attempting to fetch from rhcloud MySQL 'names' using my DataAccessObject connection.</p><br>");
while (rs.next()) {
    out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br />");
}
} catch (Exception ex) {
	out.println("<p>dao2 Exception:</p>");
    out.println("<p>getMessage(): " + ex.getMessage()+"</p>");
    out.println("<p>getLocalizedMessgae(): "+ex.getLocalizedMessage()+"</p>");
}
%>

<!-- 
<p> Properties File ReadIn </p>

String value=null;
//
Properties props = new Properties();
FileInputStream in=null;
try{
	in = new FileInputStream("db");
}catch(FileNotFoundException f){
	out.println("<p>File not found.<p>");
}
props.load(in);
in.close();
value=props.getProperty("TEST_PROPERTY").toString();
out.println("<p>Value:"+value+"</p>");
-->

</body>
</html>