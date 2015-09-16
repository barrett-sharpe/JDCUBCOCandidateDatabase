<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="objects.*" %>
<!-- Cannot have java.time.*. It's a 1.8 feature, and this project is compiler in 1.7 -->

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/profilePage.css' rel='stylesheet' type='text/css'>

</head>
<!-- Authorized Page.-->
<%@ include file="auth.jsp"%>

<!-- Variables -->
<%!Candidate can;%>
<%!Company co;%>
<%!DataAccessObject dao=new DataAccessObject();%>


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

<body>


<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href=\"protectedPage.jsp\">Return To Page</a></div>");
%>

<!--Check for Image -->
<br> <br> <br>
<%
if(dao.checkForProfileImage(Integer.parseInt(id))){
	out.println("<img src='${pageContext.request.contextPath}/profilePicture?uid="+id+"' align='right'/>");
}
%>
<!-- old image
<img src='${pageContext.request.contextPath}/profilePicture?uid=<%=Integer.valueOf(id)%>' align="right" />
-->

<!-- Profile Info Table -->
<%
if(isCompany){
	//Company Profile
	out.println("<h2>"+co.getCoName()+"</h2>");
	out.println("<table id=theTable>");
	out.println("<tr><td><div class='fieldName'>"+"CoID:"+"</div></td><td>"+co.getCoid()+"</td></tr>"); //coid
	out.println("<tr><td><div class='fieldName'>"+"Company Name:"+"</div></td><td>"+co.getCoName()+"</td></tr>"); //coName
	out.println("<tr><td><div class='fieldName'>"+"Company Established:"+"</div></td><td>"+co.getCoYearEstablished()+"</td></tr>"); //coYearEst
	out.println("<tr><td><div class='fieldName'>"+"Company Email:"+"</div></td><td>"+co.getCoEmail()+"</td></tr>"); //coEmail
	out.println("<tr><td><div class='fieldName'>"+"Company Website:"+"</div></td><td><a href='"+co.getCoUrl()+"'>"+co.getCoUrl()+"</a></td></tr>"); //coUrl
	out.println("<tr><td><div class='fieldName'>"+"Contact Name:"+"</div></td><td>"+co.getCoContactName()+"</td></tr>"); //coContactName
	out.println("<tr><td><div class='fieldName'>"+"Company Address:"+"</div></td><td>"+co.getCoAddress()+"</td></tr>"); //coAddress
	out.println("<tr><td><div class='fieldName'>"+"Telephone:"+"</div></td><td>"+co.getCoTel()+"</td></tr>"); //coTel
	out.println("<tr><td><div class='fieldName'>"+"Brief Description:"+"</div></td><td><div class='paragraph'>"+co.getCoDescription()+"</div></td></tr>"); //coDscription
	out.println("<tr><td><div class='fieldName'>"+"Social Medial:"+"</div></td><td><a href='"+co.getCoSocial()+"'>"+co.getCoSocial()+"</a></td></tr>"); //coSocial
	out.println("<tr><td><div class='fieldName'>"+"Profile Created:"+"</div></td><td>"+co.getCoDateCreated()+"</td></tr>"); //dateCreate
	out.println("<tr><td><div class='fieldName'>"+"Profile Last Modified:"+"</div></td><td>"+co.getCoDateLastModified()+"</td></tr>"); //dateLastModified
	out.println("</table>");
}else{
	//Candidate Profile
	
	//prep the dob string
	String dob=can.getDob().toString();
	dob=(String)dob.subSequence(0,dob.length()-11); //" 00:00:00" is 11 indexes (9 chars+space)	
	
	//Profile HTML	
	out.println("<h2>"+can.getcFirstName()+" "+can.getcLastName()+"</h2>");
	out.println("<table id=theTable>");
	out.println("<tr><td><div class='fieldName'>"+"Candidate ID:"+"</div></td><td>"+can.getCid()+"</td></tr>"); //cid
	out.println("<tr><td><div class='fieldName'>"+"Gender:"+"</div></td><td>"+can.getGender().toString()+"</td></tr>"); //Gender
	out.println("<tr><td><div class='fieldName'>"+"Date Of Birth:"+"</div></td><td>"+dob+"</td></tr>"); //date of birth //!@#
	out.println("<tr><td><div class='fieldName'>"+"Year Of Study:"+"</div></td><td>"+can.getcYear()+"</td></tr>"); //year of study
	out.println("<tr><td><div class='fieldName'>"+"Degree/Area:"+"</div></td><td>"+can.getDegree().toString()+"</td></tr>"); //DEGREE
	out.println("<tr><td><div class='fieldName'>"+"Job History:"+"</div></td><td><div class='paragraph'>"+can.getcJobHistory()+"</div></td></tr>"); //job history
	out.println("<tr><td><div class='fieldName'>"+"Email Address:"+"</div></td><td>"+can.getcEmail()+"</td></tr>"); //email
	out.println("<tr><td><div class='fieldName'>"+"Phone Number:"+"</div></td><td>"+can.getcPhoneNumber()+"</td></tr>"); //phone number
	out.println("<tr><td><div class='fieldName'>"+"Resume HyperLink:"+"</div></td><td><a href='"+can.getcResumeLink()+"'>"+can.getcResumeLink()+"</a></td></tr>"); //resume link
	out.println("<tr><td><div class='fieldName'>"+"Biography:"+"</div></td><td><div class='paragraph'>"+can.getcDescription()+"</div></td></tr>"); //description/biography
	out.println("<tr><td><div class='fieldName'>"+"Profile Created:"+"</div></td><td>"+can.getcDateCreated()+"</td></tr>"); //cdatecreated
	out.println("<tr><td><div class='fieldName'>"+"Profile Last Modified:"+"</div></td><td>"+can.getcDateLastModified()+"</td></tr>"); //clastmodified
	out.println("</table>");
}
%>

</body>

</html>