
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


<!-- JDBC Driver and Authentication 

//Check for JDBC Driver
	try{
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("Class.forName(com.mysql.jdbc.Driver) was FOUND");
	}catch(ClassNotFoundException x){
		System.out.println("Got no class... :'(\n");
		x.printStackTrace();
	}
	
	
	//Authenticate User's Credentials
	String authenticatedUser= null;
	try {
		authenticatedUser= validateLogin(out,request,session);
	} catch(IOException e) {
		System.err.println(e);
	}
	
	System.out.println("Authentication Process is Complete; Valid="+(authenticatedUser!=null)); //TEST
	
	//if user failed login
	if(authenticatedUser== null){
		//redirect back to login page with a message
		session.setAttribute("loginMessage", "Invalid Username or Password");
		response.sendRedirect("login.jsp");
	}else{ 
		//Successful Login by user
		session.setAttribute("loginMessage", null);
		response.sendRedirect("protectedPage.jsp");
		
	}

-->



<!--DEPRICATED "validateLogin" Method 

//validateLogin method
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException, SQLException {
	
		String retStr = null;
		Connection con = null;
		ResultSet rst = null;
		String username ="";
		
		//
		System.out.println("Validating Login.");//TEST
				
		//Deal with the cryptography
		//Fetch the user's salt
		String userSalt=fetchSalt();
		
		//Compute the user's password hash		
		//String userHash=computeHash(userSalt, numIters);
		String userHash="9f953648689448b2bfb87cb14cba67b18ab8a9b3dcf451af"; //maunal override
			
		//Contact the db to confirm user's password hash	//!@#$ This method needs to be adapted for this specifc purpose, based on the structure of the cpoied method currently in its place
		System.out.println("Attempting to confirm hash with db.");//TEST
		try {
			con = DriverManager.getConnection(url, uid, pw);
			//Check that userHash is present in the db.
			String sql1="SELECT * FROM `credentials2` WHERE username='"+usr+"' AND passwordHash='"+userHash+"';";
			PreparedStatement stmt1= con.prepareStatement(sql1);
			ResultSet rst1= stmt1.executeQuery(sql1);
			//If there is a result found, the user's login was VALID
			if(rst1.first()){
				System.out.println("User Hash CONFIRMED!!.\nHash: "+userHash);
				retStr=usr; 
			}else{
				//NO result found, therfore the user's login was INVALID
				System.out.println("No User/Hash Pair Found for:\nUser:"+usr+"\nHash:"+userHash+"\n");
				retStr=null;
			}	
			
		} catch (SQLException ex){
			//TEST
			System.out.println("Caught an error in hash confirmation.");
			System.err.println(ex);
		} finally {
			if (con != null){
				try {
					con.close();
				}catch (SQLException ex) { 
					System.err.println(ex);
				}
			}
		}
		
		//Final Decision
		if(retStr != null){ 
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",retStr); //rst is closed, so using the retStr String value
		}else{ //Failed login
			session.setAttribute("loginMessage","Failed login.");
		}
	
	return retStr;
	}

-->


<!--DEPRICATED Crypto: Fetch User's Salt 

String fetchSalt(){
		Connection con=null;
		
		//String result for Salt
		String result="";
		
		//Get the usr's salt from the db
		System.out.println("Attempting to Fetch Salt.");//TEST
		try {
			con = DriverManager.getConnection(url, uid, pw);
			//Check that usr exists
			String sql1="SELECT COUNT(*) FROM `credentials2` WHERE username='"+usr+"';";
			PreparedStatement stmt1= con.prepareStatement(sql1);
			ResultSet rst1= stmt1.executeQuery(sql1);
			//If usr exists, get their salt.
			if(rst1.first()){
				System.out.println("Found User: "+usr+".");
				//Query for salt
				String sql2= "SELECT salt FROM credentials2 WHERE username='"+usr+"';"; //!@#$
				PreparedStatement stmt2= con.prepareStatement(sql2);
				ResultSet rst2= stmt2.executeQuery(sql2);
				rst2.first();
				result=rst2.getString(1);
			}else{
				System.out.println("Did Not Find User: "+usr+".");
				result=null;
			}	
			
			
		} catch (SQLException ex){
			System.out.println("Caught an error in fetchSalt.");
			System.err.println(ex);
		} finally {
			if (con != null){
				try {
					con.close();
				}catch (SQLException ex) { 
					System.err.println(ex);
				}
			}
		}
	
		System.out.println(usr+"'s Salt: "+result+"."); //TEST
		return result;
	}

-->


<!-- DEPRICATED Crypto: Hash usr/salt

String computeHash(String salt, Integer numIters){
		String result="";
		System.out.println("Attempting to compute password hash.");//TEST
		
		//First, convert salt from hexadecimal string -> bytes[]
		byte[] bytesOsalt=null;
		//bytesOsalt=PasswordHash.fromHexPublic(salt); //!@#$ the problem is here!
		bytesOsalt=salt.getBytes();
		//Second, preform "pbkdf2" hash function.
		byte[] hash = null;
		try{
			hash=PasswordHash.pbkdf2Public(pswd.toCharArray(), bytesOsalt, numIters, bytesOsalt.length); //!@#
		}catch(Exception x){
			System.out.println("Failed pbkdf2 hash generation. Shoot...  :'(");
			x.printStackTrace();
		}
		//Third, convert byte[] hash back to a hexadecimal string, and return the result
		result+=PasswordHash.toHexPublic(hash);
		return result;
	}

 -->
 
 
<!--DEPRICATED Testing credentials2 
void testCred2(){
		
		Connection con=null;
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String sql= "SELECT * FROM credentials2 WHERE username='"+usr+"';";
			PreparedStatement stmt= con.prepareStatement(sql);
			ResultSet rst= stmt.executeQuery(sql);
			
			while(rst.next()){
				System.out.println("\t-"+rst.getString(1)+" | "+rst.getString(2)+" | ");
			}
			
			
		} catch (SQLException ex){
			//TEST
			System.out.println("Caught an error.");
			System.err.println(ex);
		} finally {
			if (con != null){
				try {
					con.close();
				}catch (SQLException ex) { 
					System.err.println(ex);
				}
			}
		}
		
		}	

-->