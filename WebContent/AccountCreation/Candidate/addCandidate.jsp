<%@page import="objects.Candidate"%>
<%@page import="verify.verifyCanMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="objects.CanMap"%>
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
CanMap user=new CanMap();
%>

<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	
	//get cid
	String cid=session.getAttribute("cid").toString();
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("problemList");
	%>
	
<!-- Normalize abnormal values -->
<%
	//dob
	String dob="";
	Integer y=Integer.parseInt((String)request.getParameter("yearOfBirth"));
	Integer m=Integer.parseInt((String)request.getParameter("monthOfBirth"));
	Integer d=Integer.parseInt((String)request.getParameter("dayOfBirth"));
	dob+=y.toString();
	dob+="-";
	if(m<10){
		dob+="0";
	}
	dob+=m.toString();
	dob+="-";
	if(d<10){
		dob+="0";
	}
	dob+=d.toString();
	//Use Candidate.formTimestamp() with above date
	dob=Candidate.formTimestamp(dob).toString();
%>
	
<!-- Attempt to add the Candidate to the DB -->
<%
	//collect the elements of the request into a CanMap
	user.put("cid",cid);
	user.put("cFirstName",request.getParameter("firstName"));
	user.put("cLastName", request.getParameter("lastName"));
	user.put("dob", dob);
	user.put("cYear", request.getParameter("yearOfStudy"));
	user.put("gender", request.getParameter("gender"));
	user.put("degree", request.getParameter("area"));
	user.put("cEmail", request.getParameter("emailAddress"));
	user.put("cResumeLink", request.getParameter("resumeHyperlink"));
	user.put("cPhoneNumber", request.getParameter("phoneNumber"));
	user.put("cDescription", request.getParameter("briefBiography"));
	user.put("cJobHistory", request.getParameter("jobHistory"));
	//ORIGINALS: might still work
	//user.put("cDateCreated", Timestamp.valueOf(LocalDateTime.now()).toString());
	//user.put("cDateLastModified", Timestamp.valueOf(LocalDateTime.now()).toString()); //didn't seem to work: Timestamp.valueOf("1000-1-1 00:00:00")
	//NEW: seems to also work, but check new candidates in db
	user.put("cDateCreated", Timestamp.valueOf("1000-1-1 00:00:00").toString());
	user.put("cDateLastModified", Timestamp.valueOf("1000-1-1 00:00:00").toString());
	
	//verify CanMap
	ArrayList<String> problems=verifyCanMap.verify(user);
	
	//add
	if(problems.size()==0){
		added=dao.addCandidate(user);
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
	out.println("<h1> Thank you "+request.getParameter("firstName")+" "+request.getParameter("lastName")+"! You're ready to login now.</h1>" ); 
	//response.sendRedirect("../WebContent/login.jsp");
	request.getRequestDispatcher("../../login.jsp").forward(request, response); //!@# /login.jsp also seems to work
	
}else{
	session.setAttribute("CandidateMessage", "Some of the information you entered was not valid. Please try again.");
	out.println("<h1>Error.</h1>" ); 
	response.sendRedirect("createCandidate.jsp");
}
%>

</body>
</html>
<!-- 
${pageContext.request.contextPath}
 -->