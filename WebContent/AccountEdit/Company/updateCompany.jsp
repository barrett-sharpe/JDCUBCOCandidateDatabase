<%@page import="objects.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="verify.verifyCoMap"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="objects.CoMap"%>
<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating Company...</title>
</head>
<body>

<!-- Declared Vars -->
<%!
String name="";
boolean updated=false;
DataAccessObject dao=new DataAccessObject();
CoMap co=new CoMap();
%>

<!-- Session Object Request for coname/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//get the coid
	String coid=String.valueOf(session.getAttribute("uid"));
	
	//Clean session of unwanted attributes
	session.removeAttribute("problemList");
	%>
<!-- Attempt to add the Company to the db -->
<%
	//collect the elements of the request into a CanMap
	co.put("coid",coid);
	co.put("coName",request.getParameter("coName"));
	co.put("coYearEstablished", request.getParameter("coYearEstablished"));
	co.put("coEmail", request.getParameter("coEmail"));
	co.put("coUrl", request.getParameter("coUrl"));
	co.put("coContactName", request.getParameter("coContactName"));
	co.put("coAddress", request.getParameter("coAddress"));
	co.put("coTel", request.getParameter("coTel"));
	co.put("coDescription", request.getParameter("coDescription"));
	co.put("coSocial", request.getParameter("coSocial"));
	
	//skipping date transfer
	
	//verify CoMap
	ArrayList<String> problems=verifyCoMap.verify(co);
	
	//update
	if(problems.isEmpty() || problems==null){
		updated=dao.updateCompany(co);
	}else{
		//Add problems to session attribute
		String problemString="";
		for(String p: problems){
			problemString+="~ "+p+"\n";
		}
		session.setAttribute("problemList", problemString);
	}
%>

<!-- Redirect To Login Page -->
<% 
if(updated){
	out.println("<h1> Thank you "+request.getParameter("coName")+" ! Information Updated.</h1>" ); 
	response.sendRedirect("../../protectedPage.jsp");
}else{
	session.setAttribute("UpdateMessage", "Some of the information you entered was not valid. Please try again.");
	out.println("<h1>Error.</h1>" ); 
	response.sendRedirect("editCompany.jsp");
}
%>

</body>
</html>
<!-- 
${pageContext.request.contextPath}
 -->