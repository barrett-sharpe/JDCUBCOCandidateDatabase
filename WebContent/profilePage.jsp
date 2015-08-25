<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="objects.*" %>
<!-- Cannot have java.time.*. It's a 1.8 feature, and this project is compiler in 1.7 -->

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Authorized Page.-->
<%@ include file="auth.jsp"%>

<!-- Variables -->
<%!Candidate can;%>
<%!Company co;%>
<%!DataAccessObject dao=new DataAccessObject();%>

<!-- TEST: URL Parameter Parsing -->
<%
//String val1=request.getParameter("val1");
//String val2=request.getParameter("val1");
//out.println("Val1: "+val1+"; Val2: "+val2+";");
%>
<!-- Session -->
<%
	// Grab session object from request.
	session = request.getSession();
	//user's name
	String user = (String) session.getAttribute("authenticatedUser");
	String id = (String) session.getAttribute("uid");
	boolean isCompany = Boolean.parseBoolean(String.valueOf(session.getAttribute("isCompany")));
%>
<!-- Page Title / Grab user from DB -->
<%
	if(isCompany){
		co=new Company();
		co.setCompany(dao.getCompany(Integer.valueOf(id)));
		out.print("<title>"+co.getCoName()+"'s Profile"+"</title>");
	}else{
		can=new Candidate();
		can.setCandidate(dao.getCandidate(Integer.valueOf(id)));
		out.print("<title>"+can.getcFirstName()+" "+can.getcLastName()+"'s Profile"+"</title>");
	}
%>

</head>
<body>

<!-- Profile Info Table -->
<%
if(isCompany){
	//Company Profile
	out.println("<h3>"+co.getCoName()+"</h3>");
	out.println("<table id=theTable>");
	out.println("<tr><td>"+"CoID:"+"</td><td>"+co.getCoid()+"</td></tr>"); //coid
	out.println("<tr><td>"+"Company Name:"+"</td><td>"+co.getCoName()+"</td></tr>"); //coName
	out.println("<tr><td>"+"Company Established:"+"</td><td>"+co.getCoYearEstablished()+"</td></tr>"); //coYearEst
	out.println("<tr><td>"+"Company Email:"+"</td><td>"+co.getCoEmail()+"</td></tr>"); //coEmail
	out.println("<tr><td>"+"Company Website:"+"</td><td><a href='"+co.getCoUrl()+"'>"+co.getCoUrl()+"</a></td></tr>"); //coUrl
	out.println("<tr><td>"+"Contact Name:"+"</td><td>"+co.getCoContactName()+"</td></tr>"); //coContactName
	out.println("<tr><td>"+"Company Address:"+"</td><td>"+co.getCoAddress()+"</td></tr>"); //coAddress
	out.println("<tr><td>"+"Telephone:"+"</td><td>"+co.getCoTel()+"</td></tr>"); //coTel
	out.println("<tr><td>"+"Brief Description:"+"</td><td>"+co.getCoDescription()+"</td></tr>"); //coDscription
	out.println("<tr><td>"+"Social Medial:"+"</td><td><a href='"+co.getCoSocial()+"'>"+co.getCoSocial()+"</a></td></tr>"); //coSocial
	out.println("<tr><td>"+"Profile Created:"+"</td><td>"+co.getCoDateCreated()+"</td></tr>"); //dateCreate
	out.println("<tr><td>"+"Profile Last Modified:"+"</td><td>"+co.getCoDateLastModified()+"</td></tr>"); //dateLastModified
	out.println("</table>");
}else{
	//Candidate Profile
	
	//prep the dob string
	String dob=can.getDob().toString();
	dob=(String)dob.subSequence(0,dob.length()-11); //" 00:00:00" is 11 indexes (9 chars+space)	
	//profile html
	out.println("<h3>"+can.getcFirstName()+" "+can.getcLastName()+"</h3>");
	out.println("<table id=theTable>");
	out.println("<tr><td>"+"Candidate ID:"+"</td><td>"+can.getCid()+"</td></tr>"); //cid
	out.println("<tr><td>"+"Gender:"+"</td><td>"+can.getGender().toString()+"</td></tr>"); //Gender
	out.println("<tr><td>"+"Date Of Birth:"+"</td><td>"+dob+"</td></tr>"); //date of birth //!@#
	out.println("<tr><td>"+"Year Of Study:"+"</td><td>"+can.getcYear()+"</td></tr>"); //year of study
	out.println("<tr><td>"+"Degree/Area:"+"</td><td>"+can.getDegree().toString()+"</td></tr>"); //DEGREE
	out.println("<tr><td>"+"Job History:"+"</td><td>"+can.getcJobHistory()+"</td></tr>"); //job history
	out.println("<tr><td>"+"Email Address:"+"</td><td>"+can.getcEmail()+"</td></tr>"); //email
	out.println("<tr><td>"+"Phone Number:"+"</td><td>"+can.getcPhoneNumber()+"</td></tr>"); //phone number
	out.println("<tr><td>"+"Resume HyperLink:"+"</td><td><a href='"+can.getcResumeLink()+"'>"+can.getcResumeLink()+"</a></td></tr>"); //resume link
	out.println("<tr><td>"+"Biography:"+"</td><td>"+can.getcDescription()+"</td></tr>"); //description/biography
	out.println("<tr><td>"+"Profile Created:"+"</td><td>"+can.getcDateCreated()+"</td></tr>"); //cdatecreated
	out.println("<tr><td>"+"Profile Last Modified:"+"</td><td>"+can.getcDateLastModified()+"</td></tr>"); //clastmodified
	out.println("</table>");
}
%>

</body>

</html>