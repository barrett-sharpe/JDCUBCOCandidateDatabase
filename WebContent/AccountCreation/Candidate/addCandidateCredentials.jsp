<%@page import="objects.Captcha"%>
<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding Account...</title>
</head>
<body>


<!-- Declared Vars -->
<%!
String username="";
String password="";
String recoveryString="";
String captchaInput="";
String capid="";
Integer cid=0;
boolean exists=true;
boolean capCorrect=false;
DataAccessObject dao=new DataAccessObject();
%>

<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect 
	username = request.getParameter("uname");
	password = request.getParameter("pword");
	recoveryString=request.getParameter("rs1");
	//recoveryString here and on page before
	
	//Collect the Captcha Input
	captchaInput=request.getParameter("capinput");
	//capid = (String)request.getSession().getAttribute("capid").toString(); //from internet. Works also!!! Inspired below line
	capid=session.getAttribute("capid").toString();
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("cid");
	session.removeAttribute("CandidateCredentialsMessage");
	session.removeAttribute("problemList");//?
	%>

<!-- Check the retypes -->
<%
//get retyped password
String repass=request.getParameter("pword2");
//passwords don't match
if(!(password.equals(repass))){
	session.setAttribute("CandidateCredentialsMessage", "The password was not retyped correctly.");
	response.sendRedirect("createCandidateCredentials.jsp");
}
//get retyped
String rerecov=request.getParameter("rs2");
//recoveries dont match
if(!(recoveryString.equals(rerecov))){
	session.setAttribute("CandidateCredentialsMessage", "The recovery string was not retyped correctly.");
	response.sendRedirect("createCandidateCredentials.jsp");
}

%>

<!-- Attempt to add the Candidate to the db -->
<%
	//VALIDATE CAPTCHA
	Captcha c=new Captcha();
	Integer id=Integer.parseInt(capid);//capid
	capCorrect=c.validateCaptchaAnswer(captchaInput, id );
	System.out.println("capCorrect:"+capCorrect);//TEST
	//Check If User Already Exists
	exists=dao.userInCandidateDB(username);
	
	//Attempt to add if human and available. Beep Boop Beep.
	if(!exists && capCorrect){
		//add
		cid=dao.addCredentialsCandidate(username, password); //!@#$ RESUME HERE needs to add recoveryString
	}
%>

<!-- Redirects-->
<% 
	if(!exists && capCorrect){
		out.println("<h1> Thank you "+username+" !</h3>" ); 
		session.setAttribute("cid", cid);
		response.sendRedirect("createCandidate.jsp");
	}else if(!exists && !capCorrect){
		out.println("<h1>Invalid</h1>");
		session.setAttribute("CandidateCredentialsMessage", "The captcha entered was incorrect. However, the username '"+username+"' is still available, so lucky for you!");
		response.sendRedirect("createCandidateCredentials.jsp");	
	}else{
		out.println("<h1>Invalid</h1>");
		session.setAttribute("CandidateCredentialsMessage", "The username '"+username+"' already exists. Please choose another username.");
		response.sendRedirect("createCandidateCredentials.jsp");
	}
%>

</body>
</html>