
<%@page import="hashing.*" %>
<%@page import="objects.*" %>

<%@page import="java.util.Map"%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.io.*, java.sql.*"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.spec.InvalidKeySpecException"%>
<%@page import=" java.security.SecureRandom"%>
<%@page import="javax.crypto.spec.PBEKeySpec"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="java.math.BigInteger"%>




<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	
	<!-- Declarations and Constants -->
	<%! String usr; %>
	<%! String pswd; %>
	
	<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
			
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("loginMessage");
	
	//Collect the username (usr) and password (psw), entered by the user, from the session.
	usr = request.getParameter("username");
	pswd = request.getParameter("password");
	//System.out.println("Username: "+usr+"\nPassword: "+pswd+"."); //TESTPrint
	%>
	
	
	<!-- NEW DAO-based Validation -->
	<%
	DataAccessObject access=new DataAccessObject();
	boolean isCompany=access.getIsCompany(usr);
	boolean valid;
	Map<String, Object> c=access.getUser(usr);
	String id="";
	if(isCompany){
		valid=access.validateCompany(usr, pswd);
		//if Company is valid, get coid
		if(valid){
			id=c.get("coid").toString(); 
		}
	}else{
		valid=access.validateCandidate(usr, pswd);
		//if Candidate is valid, get cid number
		if(valid){
			id=c.get("cid").toString();
		}
	}
	
	
	
	
	//System.out.println("ID: "+valid+"."); //TEST PRINT
	
	if(valid){
		//Successful Login by user
		session.setAttribute("isCompany", String.valueOf(isCompany)); //isCompany string
		session.setAttribute("uid", id);				//uid (either cid or coid)
		session.setAttribute("authenticatedUser", usr);
		session.setAttribute("loginMessage", null);
		response.sendRedirect("protectedPage.jsp");	
	}else{
		//redirect back to login page with a message
		session.setAttribute("loginMessage", "Invalid Username or Password");
		response.sendRedirect("login.jsp");	
	}
	
	%>

	

		
	
	
</body>
</html>