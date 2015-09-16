<%@page import="objects.Company"%>
<%@page import="verify.verifyCoMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="objects.CoMap"%>
<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding User...</title>
</head>
<body>


<!-- Declared Vars -->
<%!
String name="";
boolean added=false;
DataAccessObject dao=new DataAccessObject();
CoMap co=new CoMap();
%>

<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	
	//get cid
	String coid=session.getAttribute("coid").toString();
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("problemList");
	%>
	
<!-- Attempt to add the Company to the DB -->
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
	co.put("cDateCreated", Timestamp.valueOf("1970-01-01 00:00:01").toString());
	co.put("cDateLastModified", Timestamp.valueOf("1970-01-01 00:00:01").toString());
	
	//verify CanMap
	ArrayList<String> problems=verifyCoMap.verify(co);
	
	//add
	if(problems.size()==0){
		added=dao.addCompany(co);
	}else{
		//Add problems to session attribute
		String problemString="";
		for(String p: problems){
			problemString+="~ "+p+"\n"; //?
		}
		session.setAttribute("problemList", problemString);
	}
%>

<!-- Redirect To Login Page -->
<% 
if(added){
	out.println("<h1> Thank you "+request.getParameter("coName")+" ! Information Updated.</h1>" ); 
	response.sendRedirect("../../protectedPage.jsp");
}else{
	session.setAttribute("UpdateMessage", "Some of the information you entered was not valid. Please try again.");
	out.println("<h1>Error.</h1>" ); 
	response.sendRedirect("createCompany.jsp");
}
%>

</body>
</html>
<!-- 
${pageContext.request.contextPath}
 -->