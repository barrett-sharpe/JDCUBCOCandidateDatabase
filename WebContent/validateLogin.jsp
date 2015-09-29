
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
	
	
	<!-- DAO-based Validation -->
	<%
	//Variables
	DataAccessObject access=new DataAccessObject();
	Map<String, Object> c=null;
	String id="";
	boolean isCompany=false;
	boolean valid=false;
	boolean exists=false;
	
	//Check if user exists (candidate||company)
	if((access.userInCandidateDB(usr)||(access.userInCompanyDB(usr)))){
		//username exists, get User
		c=access.getUser(usr);
		//determine user isCompany
		isCompany=access.getIsCompany(usr);
		
		//check valididty
		if(isCompany){
			valid=access.validateCompany(usr, pswd);
			//if Company username/password is valid, get coid
			if(valid){
				id=c.get("coid").toString(); 
			}
		}else{
			valid=access.validateCandidate(usr, pswd);
			//if Candidate username/password is valid, get cid number
			if(valid){
				id=c.get("cid").toString();
			}
		}
	}else{
		//username given not either candidate or company
		valid=false;
	}
	
	//If valid Login
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