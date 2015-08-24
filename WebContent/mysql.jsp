<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="US-ASCII"%>
<%@ page import='java.sql.*' %>
<%@ page import='javax.sql.*' %>
<%@ page import='javax.naming.*' %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Tomcat Server Datasource Example</title>
</head>
<body>

<p>Future Home @:<p>
<p>resumebank.ubcojdcwest.rhcloud.com<p>
<p>internet names example:</p>
<%
Connection result = null;
try {
    InitialContext ic = new InitialContext();
    Context initialContext = (Context) ic.lookup("java:comp/env");
    DataSource datasource = (DataSource) initialContext.lookup("jdbc/MySQLDS");
    result = datasource.getConnection();
    Statement stmt = result.createStatement() ;
    String query = "select * from names;" ;
    ResultSet rs = stmt.executeQuery(query) ;
    out.println("<p> Attempting to fetch from rhcloud MySSQL 'names'.</p><br>");
    while (rs.next()) {
        out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br />");
    }
} catch (Exception ex) {
    out.println("Exception: " + ex + ex.getMessage());
}
%>

<p>Custom DAO names example</p>

<%
try{
	DataAccessObject dao=new DataAccessObject();
	Connection c=dao.getCon();
	String query="SELECT * FROM names;";
	PreparedStatement ps=c.prepareStatement(query);
	ResultSet rs = ps.executeQuery();
	out.println("<p> Attempting to fetch from rhcloud MySSQL 'names' using custom DataAccessObject connection.</p><br>");
while (rs.next()) {
    out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br />");
}
} catch (Exception ex) {
out.println("Exception: " + ex + ex.getMessage());
}
%>

</body>
</html>