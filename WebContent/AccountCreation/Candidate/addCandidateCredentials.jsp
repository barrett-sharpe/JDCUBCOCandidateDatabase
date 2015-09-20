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
//Variables
String username="";
String password="";
String recoveryString="";
String captchaInput="";
String capid="";
String tos="";
Integer cid=0;

//Conditions
boolean exists=true;
boolean capCorrect=false;
boolean retyped=false;
boolean samePassword=false;
boolean agree=false;
String page="";
//DAO
DataAccessObject dao=new DataAccessObject();
%>

<!-- Session Object Request for Username/Password-->
<%
String repass="";
String rerecov="";
		
try{
		
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
	
	//get retyped password and string
	repass=request.getParameter("pword2");
	rerecov=request.getParameter("rs2");
	
	//get TermsOfService
	tos=((request.getParameter("agree").toString()==null)? "": "on");
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("cid");
	session.removeAttribute("CandidateCredentialsMessage");
	session.removeAttribute("problemList");//?
	
	//Prevent null from being in the error message
	session.setAttribute("CandidateCredentialsMessage", " ");
	

	
	//COLLECT CONDITIONS
	
	
	//Validate CAPTCHA
	Captcha c=new Captcha();
	Integer id=Integer.parseInt(capid);//capid
	capCorrect=c.validateCaptchaAnswer(captchaInput, id );
	//System.out.println("capCorrect:"+capCorrect);//TEST
	
	//Check If User Already Exists //!@#$problem. Need to check both db's because "user" candidate == "user" company
	if(!dao.userInCandidateDB(username)&&!dao.userInCompanyDB(username)){
		exists=false;
	}
	
	//Captcha and REcovery retyped corretly
	if(recoveryString.equals(rerecov)){
		retyped=true;
	}

	//passwords are not the same
	if(password.equals(repass)){
		samePassword=true;
	}
	
	//agree
	if(tos.equalsIgnoreCase("on")){
		agree=true;
	}


	//MESSAGES
		
	//if user already exists
	if(exists){
		session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage").toString()+"The username '"+username+"' has already been taken. Please select another username. ");
	}
	//passwords dont match
	if(!password.equals(repass)){
		session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage").toString()+"The password was not retyped correctly. ");
	}
	//if recoveries dont match
	if(!recoveryString.equals(rerecov)){
		session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage").toString()+"The recovery string was not retyped correctly. ");
	}
	//if captcha not correct
	if(!capCorrect){
		session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage").toString()+"The captcha entered was incorrect. ");
	}
	//if not agreed
	if(!agree){
		session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage").toString()+"You must agree to the Terms Of Service. ");
	}

	//REMOVE ERROR MESSAGES IF NEEDED
	
	
	if(session.getAttribute("CandidateCredentialsMessage").toString().length()<=1){
		session.setAttribute("CandidateCredentialsMessage", null);
	}
	
	//FINAL CONFIRMATION AND REDIRCET


//if all conditions met
	if(!exists && capCorrect && retyped && samePassword && agree){
		//Attempt to add.
		cid=dao.addCredentialsCandidate(username, password, recoveryString);
		//set and redirect appropriately
		out.println("<h1> Thank you "+username+" !</h3>" ); 
		session.setAttribute("cid", cid);
		response.sendRedirect("createCandidate.jsp");
	}else{
		//any condition false, throw a (different expection). Too lazy to write custom exception. Sorry, not sorry: it works
		throw new ArrayIndexOutOfBoundsException();
	}


	//CLOSE THE DAO
	dao.closeConnection();
	
	}catch(NullPointerException x){
		//If other messages, add them to all value message
		if(session.getAttribute("CandidateCredentialsMessage")==null){
			session.setAttribute("CandidateCredentialsMessage", "All values must be filled in on this sign up page. ");
		}else{
			session.setAttribute("CandidateCredentialsMessage", session.getAttribute("CandidateCredentialsMessage")+"All values must be filled in on this sign up page. ");
		}
		//redirect
		response.sendRedirect("createCandidateCredentials.jsp");
	}catch(ArrayIndexOutOfBoundsException a){
		//redirect
		response.sendRedirect("createCandidateCredentials.jsp");
	}

%>



</body>
</html>