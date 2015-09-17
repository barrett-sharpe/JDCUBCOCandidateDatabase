<%@page import="objects.Candidate"%>
<%@page import="objects.DataAccessObject"%>
<%@page import="objects.CanMap"%>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Edit Your Profile</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/AccountEdit/Candidate/editCandidate.css' rel='stylesheet' type='text/css'>

</head>
<body>

<h3>
Please edit your profile information below, and hit save at the bottom of the page.
</h3>
<p>(<span style = "color:red">*</span> - required)</p>

<!-- Variables -->
<%! DataAccessObject dao=new DataAccessObject(); %>
	
<!-- Session Object Request for Username-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect the user id (cid), from the session.
	Integer cid=Integer.parseInt((String)session.getAttribute("uid")); 
	
	//Clean session of unwanted attributes
	
	
	%>

<!-- Print Prior Error Account Message If Needed -->
<%
	// Print prior error login message if needed
	if (session.getAttribute("UpdateMessage") != null){
		out.println("<h5 class='error'>" + session.getAttribute("UpdateMessage").toString() + "</h5>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 class='error'>" + session.getAttribute("problemList").toString() + "</h5>");
	}
%>

<!-- Get the Candidate's Info from the DB -->
<%
	CanMap can=dao.getCandidate(cid);
	//TEST
	//Candidate ct=new Candidate();
	//ct.setCandidate(can);
	//out.println("<br>"+ct.printoutString(true));
%>

<!-- Form -->
<form name="EditUserForm" action="updateCandidate.jsp" method=POST>
	<table width="70%">
	<tr>
		<td> Candidate ID:</td>
		<td><%out.println(cid);%></td>
	</tr>
	<tr>
		<td>First Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='firstName' value='<%=can.get("cFirstName").toString()%>'></td>
	</tr>
	<tr>
		<td>Last Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='lastName' value='<%=can.get("cLastName").toString()%>'></td>
	</tr>
	<tr>
		<td>Gender:<span style = "color:red">*</span></td>
		<td>
			<!-- JSP to select existing value -->
			<select name='gender'>
			<%	//Get can gender string value
				String gender=can.get("gender").toString();
				String output="";
				for(int i=0;i<5;i++){
					output="";
					String VAL="";
					output+="<option value='";
					switch(i){
					case 0:
						VAL = "NotDeclared";
						output+=VAL+"'";
						if(gender.equalsIgnoreCase(VAL)){
							output+=" selected='selected'"; 
						}
						output+=">"+VAL;
						break;
					case 1:
						VAL = "Male";
						output+=VAL+"'";
						if(gender.equalsIgnoreCase(VAL)){
							output+=" selected='selected'"; 
						}
						output+=">"+VAL;
						break;
					case 2:
						VAL = "Female";
						output+=VAL+"'";
						if(gender.equalsIgnoreCase(VAL)){
							output+=" selected='selected'"; 
						}
						output+=">"+VAL;
						break;
					case 3:
						VAL = "Transgendered";
						output+=VAL+"'";
						if(gender.equalsIgnoreCase(VAL)){
							output+=" selected='selected'"; 
						}
						output+=">"+VAL;
						break;
					case 4:
						VAL = "Other";
						output+=VAL+"'";
						if(gender.equalsIgnoreCase(VAL)){
							output+=" selected='selected'"; 
						}
						output+=">"+VAL;
						break;
					default:
						System.err.println("Goodbye Universe!");
						break;
					}//switch
					output+="</option>";
					out.println(output);
				}//for
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td>Date Of Birth:<span style = "color:red">*</span></td>

		<!-- OLD Date Of Birth 	
		
		//Change the date
		Timestamp ts=Timestamp.valueOf(can.get("dob").toString());
		String dob=Candidate.formStringDate(ts);
		//TESTPRINT
		//System.out.println("AccountEdit;\nTimestamp(from CanMap): "+ts.toString()+"\nString dob (in field): "+dob);
		
		-->
		<!-- old DOB 
		<td>Date Of Birth:<span style = "color:red">*</span></td>
		<td><input type='text' name='dateOfBirth' value='out.println(dob);'></td>
		-->
		
		
		<td>
		
		<!-- New DOB -->
		<%
		//get date[yaer,month,day]
		Timestamp ts=Timestamp.valueOf(can.get("dob").toString());
		String dob=Candidate.formStringDate(ts);
		Integer[] date=Candidate.extractDateFromString(dob);
		//System.out.println("[0]"+date[0]+"[1]"+date[1]+"[2]"+date[2]+"."); //TEST
		%>
		
		<!-- Year -->
		<select name='yearOfBirth'>
		<%		
		//FOR options
		String output3="";
		for(int i=0;i<136;i++){
			//Reset variables
			output3="";
			String VAL="";
			String VIEW="";
			//Option context
			output3+="<option value='";
			switch(i){
			case 0:
				VAL = "1915";
				VIEW = "1915";
				output3+=VAL+"'";
				if(date[0]==1915){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 1:
				VAL = "1916";
				VIEW = "1916";
				output3+=VAL+"'";
				if(date[0]==1916){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 2:
				VAL = "1917";
				VIEW = "1917";
				output3+=VAL+"'";
				if(date[0]==1917){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 3:
				VAL = "1918";
				VIEW = "1918";
				output3+=VAL+"'";
				if(date[0]==1918){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 4:
				VAL = "1919";
				VIEW = "1919";
				output3+=VAL+"'";
				if(date[0]==1919){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 5:
				VAL = "1920";
				VIEW = "1920";
				output3+=VAL+"'";
				if(date[0]==1920){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 6:
				VAL = "1921";
				VIEW = "1921";
				output3+=VAL+"'";
				if(date[0]==1921){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 7:
				VAL = "1922";
				VIEW = "1922";
				output3+=VAL+"'";
				if(date[0]==1922){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 8:
				VAL = "1923";
				VIEW = "1923";
				output3+=VAL+"'";
				if(date[0]==1923){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 9:
				VAL = "1924";
				VIEW = "1924";
				output3+=VAL+"'";
				if(date[0]==1924){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 10:
				VAL = "1925";
				VIEW = "1925";
				output3+=VAL+"'";
				if(date[0]==1925){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 11:
				VAL = "1926";
				VIEW = "1926";
				output3+=VAL+"'";
				if(date[0]==1926){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 12:
				VAL = "1927";
				VIEW = "1927";
				output3+=VAL+"'";
				if(date[0]==1927){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 13:
				VAL = "1928";
				VIEW = "1928";
				output3+=VAL+"'";
				if(date[0]==1928){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 14:
				VAL = "1929";
				VIEW = "1929";
				output3+=VAL+"'";
				if(date[0]==1929){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 15:
				VAL = "1930";
				VIEW = "1930";
				output3+=VAL+"'";
				if(date[0]==1930){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 16:
				VAL = "1931";
				VIEW = "1931";
				output3+=VAL+"'";
				if(date[0]==1931){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 17:
				VAL = "1932";
				VIEW = "1932";
				output3+=VAL+"'";
				if(date[0]==1932){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 18:
				VAL = "1933";
				VIEW = "1933";
				output3+=VAL+"'";
				if(date[0]==1933){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 19:
				VAL = "1934";
				VIEW = "1934";
				output3+=VAL+"'";
				if(date[0]==1934){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 20:
				VAL = "1935";
				VIEW = "1935";
				output3+=VAL+"'";
				if(date[0]==1935){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 21:
				VAL = "1936";
				VIEW = "1936";
				output3+=VAL+"'";
				if(date[0]==1936){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 22:
				VAL = "1937";
				VIEW = "1937";
				output3+=VAL+"'";
				if(date[0]==1937){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 23:
				VAL = "1938";
				VIEW = "1938";
				output3+=VAL+"'";
				if(date[0]==1938){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 24:
				VAL = "1939";
				VIEW = "1939";
				output3+=VAL+"'";
				if(date[0]==1939){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 25:
				VAL = "1940";
				VIEW = "1940";
				output3+=VAL+"'";
				if(date[0]==1940){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 26:
				VAL = "1941";
				VIEW = "1941";
				output3+=VAL+"'";
				if(date[0]==1941){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 27:
				VAL = "1942";
				VIEW = "1942";
				output3+=VAL+"'";
				if(date[0]==1942){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 28:
				VAL = "1943";
				VIEW = "1943";
				output3+=VAL+"'";
				if(date[0]==1943){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 29:
				VAL = "1944";
				VIEW = "1944";
				output3+=VAL+"'";
				if(date[0]==1944){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 30:
				VAL = "1945";
				VIEW = "1945";
				output3+=VAL+"'";
				if(date[0]==1945){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 31:
				VAL = "1946";
				VIEW = "1946";
				output3+=VAL+"'";
				if(date[0]==1946){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 32:
				VAL = "1947";
				VIEW = "1947";
				output3+=VAL+"'";
				if(date[0]==1947){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 33:
				VAL = "1948";
				VIEW = "1948";
				output3+=VAL+"'";
				if(date[0]==1948){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 34:
				VAL = "1949";
				VIEW = "1949";
				output3+=VAL+"'";
				if(date[0]==1949){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 35:
				VAL = "1950";
				VIEW = "1950";
				output3+=VAL+"'";
				if(date[0]==1950){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 36:
				VAL = "1951";
				VIEW = "1951";
				output3+=VAL+"'";
				if(date[0]==1951){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 37:
				VAL = "1952";
				VIEW = "1952";
				output3+=VAL+"'";
				if(date[0]==1952){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 38:
				VAL = "1953";
				VIEW = "1953";
				output3+=VAL+"'";
				if(date[0]==1953){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 39:
				VAL = "1954";
				VIEW = "1954";
				output3+=VAL+"'";
				if(date[0]==1954){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 40:
				VAL = "1955";
				VIEW = "1955";
				output3+=VAL+"'";
				if(date[0]==1955){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 41:
				VAL = "1956";
				VIEW = "1956";
				output3+=VAL+"'";
				if(date[0]==1956){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 42:
				VAL = "1957";
				VIEW = "1957";
				output3+=VAL+"'";
				if(date[0]==1957){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 43:
				VAL = "1958";
				VIEW = "1958";
				output3+=VAL+"'";
				if(date[0]==1958){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 44:
				VAL = "1959";
				VIEW = "1959";
				output3+=VAL+"'";
				if(date[0]==1959){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 45:
				VAL = "1960";
				VIEW = "1960";
				output3+=VAL+"'";
				if(date[0]==1960){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 46:
				VAL = "1961";
				VIEW = "1961";
				output3+=VAL+"'";
				if(date[0]==1961){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 47:
				VAL = "1962";
				VIEW = "1962";
				output3+=VAL+"'";
				if(date[0]==1962){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 48:
				VAL = "1963";
				VIEW = "1963";
				output3+=VAL+"'";
				if(date[0]==1963){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 49:
				VAL = "1964";
				VIEW = "1964";
				output3+=VAL+"'";
				if(date[0]==1964){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 50:
				VAL = "1965";
				VIEW = "1965";
				output3+=VAL+"'";
				if(date[0]==1965){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 51:
				VAL = "1966";
				VIEW = "1966";
				output3+=VAL+"'";
				if(date[0]==1966){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 52:
				VAL = "1967";
				VIEW = "1967";
				output3+=VAL+"'";
				if(date[0]==1967){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 53:
				VAL = "1968";
				VIEW = "1968";
				output3+=VAL+"'";
				if(date[0]==1968){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 54:
				VAL = "1969";
				VIEW = "1969";
				output3+=VAL+"'";
				if(date[0]==1969){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 55:
				VAL = "1970";
				VIEW = "1970";
				output3+=VAL+"'";
				if(date[0]==1970){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 56:
				VAL = "1971";
				VIEW = "1971";
				output3+=VAL+"'";
				if(date[0]==1971){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 57:
				VAL = "1972";
				VIEW = "1972";
				output3+=VAL+"'";
				if(date[0]==1972){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 58:
				VAL = "1973";
				VIEW = "1973";
				output3+=VAL+"'";
				if(date[0]==1973){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 59:
				VAL = "1974";
				VIEW = "1974";
				output3+=VAL+"'";
				if(date[0]==1974){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 60:
				VAL = "1975";
				VIEW = "1975";
				output3+=VAL+"'";
				if(date[0]==1975){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 61:
				VAL = "1976";
				VIEW = "1976";
				output3+=VAL+"'";
				if(date[0]==1976){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 62:
				VAL = "1977";
				VIEW = "1977";
				output3+=VAL+"'";
				if(date[0]==1977){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 63:
				VAL = "1978";
				VIEW = "1978";
				output3+=VAL+"'";
				if(date[0]==1978){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 64:
				VAL = "1979";
				VIEW = "1979";
				output3+=VAL+"'";
				if(date[0]==1979){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 65:
				VAL = "1980";
				VIEW = "1980";
				output3+=VAL+"'";
				if(date[0]==1980){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 66:
				VAL = "1981";
				VIEW = "1981";
				output3+=VAL+"'";
				if(date[0]==1981){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 67:
				VAL = "1982";
				VIEW = "1982";
				output3+=VAL+"'";
				if(date[0]==1982){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 68:
				VAL = "1983";
				VIEW = "1983";
				output3+=VAL+"'";
				if(date[0]==1983){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 69:
				VAL = "1984";
				VIEW = "1984";
				output3+=VAL+"'";
				if(date[0]==1984){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 70:
				VAL = "1985";
				VIEW = "1985";
				output3+=VAL+"'";
				if(date[0]==1985){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 71:
				VAL = "1986";
				VIEW = "1986";
				output3+=VAL+"'";
				if(date[0]==1986){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 72:
				VAL = "1987";
				VIEW = "1987";
				output3+=VAL+"'";
				if(date[0]==1987){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 73:
				VAL = "1988";
				VIEW = "1988";
				output3+=VAL+"'";
				if(date[0]==1988){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 74:
				VAL = "1989";
				VIEW = "1989";
				output3+=VAL+"'";
				if(date[0]==1989){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 75:
				VAL = "1990";
				VIEW = "1990";
				output3+=VAL+"'";
				if(date[0]==1990){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 76:
				VAL = "1991";
				VIEW = "1991";
				output3+=VAL+"'";
				if(date[0]==1991){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 77:
				VAL = "1992";
				VIEW = "1992";
				output3+=VAL+"'";
				if(date[0]==1992){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 78:
				VAL = "1993";
				VIEW = "1993";
				output3+=VAL+"'";
				if(date[0]==1993){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 79:
				VAL = "1994";
				VIEW = "1994";
				output3+=VAL+"'";
				if(date[0]==1994){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 80:
				VAL = "1995";
				VIEW = "1995";
				output3+=VAL+"'";
				if(date[0]==1995){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 81:
				VAL = "1996";
				VIEW = "1996";
				output3+=VAL+"'";
				if(date[0]==1996){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 82:
				VAL = "1997";
				VIEW = "1997";
				output3+=VAL+"'";
				if(date[0]==1997){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 83:
				VAL = "1998";
				VIEW = "1998";
				output3+=VAL+"'";
				if(date[0]==1998){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 84:
				VAL = "1999";
				VIEW = "1999";
				output3+=VAL+"'";
				if(date[0]==1999){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 85:
				VAL = "2000";
				VIEW = "2000";
				output3+=VAL+"'";
				if(date[0]==2000){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 86:
				VAL = "2001";
				VIEW = "2001";
				output3+=VAL+"'";
				if(date[0]==2001){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 87:
				VAL = "2002";
				VIEW = "2002";
				output3+=VAL+"'";
				if(date[0]==2002){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 88:
				VAL = "2003";
				VIEW = "2003";
				output3+=VAL+"'";
				if(date[0]==2003){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 89:
				VAL = "2004";
				VIEW = "2004";
				output3+=VAL+"'";
				if(date[0]==2004){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 90:
				VAL = "2005";
				VIEW = "2005";
				output3+=VAL+"'";
				if(date[0]==2005){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 91:
				VAL = "2006";
				VIEW = "2006";
				output3+=VAL+"'";
				if(date[0]==2006){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 92:
				VAL = "2007";
				VIEW = "2007";
				output3+=VAL+"'";
				if(date[0]==2007){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 93:
				VAL = "2008";
				VIEW = "2008";
				output3+=VAL+"'";
				if(date[0]==2008){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 94:
				VAL = "2009";
				VIEW = "2009";
				output3+=VAL+"'";
				if(date[0]==2009){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 95:
				VAL = "2010";
				VIEW = "2010";
				output3+=VAL+"'";
				if(date[0]==2010){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 96:
				VAL = "2011";
				VIEW = "2011";
				output3+=VAL+"'";
				if(date[0]==2011){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 97:
				VAL = "2012";
				VIEW = "2012";
				output3+=VAL+"'";
				if(date[0]==2012){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 98:
				VAL = "2013";
				VIEW = "2013";
				output3+=VAL+"'";
				if(date[0]==2013){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 99:
				VAL = "2014";
				VIEW = "2014";
				output3+=VAL+"'";
				if(date[0]==2014){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 100:
				VAL = "2015";
				VIEW = "2015";
				output3+=VAL+"'";
				if(date[0]==2015){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 101:
				VAL = "2016";
				VIEW = "2016";
				output3+=VAL+"'";
				if(date[0]==2016){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 102:
				VAL = "2017";
				VIEW = "2017";
				output3+=VAL+"'";
				if(date[0]==2017){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 103:
				VAL = "2018";
				VIEW = "2018";
				output3+=VAL+"'";
				if(date[0]==2018){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 104:
				VAL = "2019";
				VIEW = "2019";
				output3+=VAL+"'";
				if(date[0]==2019){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 105:
				VAL = "2020";
				VIEW = "2020";
				output3+=VAL+"'";
				if(date[0]==2020){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 106:
				VAL = "2021";
				VIEW = "2021";
				output3+=VAL+"'";
				if(date[0]==2021){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 107:
				VAL = "2022";
				VIEW = "2022";
				output3+=VAL+"'";
				if(date[0]==2022){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 108:
				VAL = "2023";
				VIEW = "2023";
				output3+=VAL+"'";
				if(date[0]==2023){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 109:
				VAL = "2024";
				VIEW = "2024";
				output3+=VAL+"'";
				if(date[0]==2024){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 110:
				VAL = "2025";
				VIEW = "2025";
				output3+=VAL+"'";
				if(date[0]==2025){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 111:
				VAL = "2026";
				VIEW = "2026";
				output3+=VAL+"'";
				if(date[0]==2026){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 112:
				VAL = "2027";
				VIEW = "2027";
				output3+=VAL+"'";
				if(date[0]==2027){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 113:
				VAL = "2028";
				VIEW = "2028";
				output3+=VAL+"'";
				if(date[0]==2028){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 114:
				VAL = "2029";
				VIEW = "2029";
				output3+=VAL+"'";
				if(date[0]==2029){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 115:
				VAL = "2030";
				VIEW = "2030";
				output3+=VAL+"'";
				if(date[0]==2030){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 116:
				VAL = "2031";
				VIEW = "2031";
				output3+=VAL+"'";
				if(date[0]==2031){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 117:
				VAL = "2032";
				VIEW = "2032";
				output3+=VAL+"'";
				if(date[0]==2032){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 118:
				VAL = "2033";
				VIEW = "2033";
				output3+=VAL+"'";
				if(date[0]==2033){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 119:
				VAL = "2034";
				VIEW = "2034";
				output3+=VAL+"'";
				if(date[0]==2034){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 120:
				VAL = "2035";
				VIEW = "2035";
				output3+=VAL+"'";
				if(date[0]==2035){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 121:
				VAL = "2036";
				VIEW = "2036";
				output3+=VAL+"'";
				if(date[0]==2036){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 122:
				VAL = "2037";
				VIEW = "2037";
				output3+=VAL+"'";
				if(date[0]==2037){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 123:
				VAL = "2038";
				VIEW = "2038";
				output3+=VAL+"'";
				if(date[0]==2038){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 124:
				VAL = "2039";
				VIEW = "2039";
				output3+=VAL+"'";
				if(date[0]==2039){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 125:
				VAL = "2040";
				VIEW = "2040";
				output3+=VAL+"'";
				if(date[0]==2040){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 126:
				VAL = "2041";
				VIEW = "2041";
				output3+=VAL+"'";
				if(date[0]==2041){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 127:
				VAL = "2042";
				VIEW = "2042";
				output3+=VAL+"'";
				if(date[0]==2042){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 128:
				VAL = "2043";
				VIEW = "2043";
				output3+=VAL+"'";
				if(date[0]==2043){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 129:
				VAL = "2044";
				VIEW = "2044";
				output3+=VAL+"'";
				if(date[0]==2044){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 130:
				VAL = "2045";
				VIEW = "2045";
				output3+=VAL+"'";
				if(date[0]==2045){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 131:
				VAL = "2046";
				VIEW = "2046";
				output3+=VAL+"'";
				if(date[0]==2046){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 132:
				VAL = "2047";
				VIEW = "2047";
				output3+=VAL+"'";
				if(date[0]==2047){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 133:
				VAL = "2048";
				VIEW = "2048";
				output3+=VAL+"'";
				if(date[0]==2048){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 134:
				VAL = "2049";
				VIEW = "2049";
				output3+=VAL+"'";
				if(date[0]==2049){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 135:
				VAL = "2050";
				VIEW = "2050";
				output3+=VAL+"'";
				if(date[0]==2050){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			default:
				System.err.println("Goodbye Universe!");
				break;
			}//switch
			output3+="</option>";
			out.println(output3);
		}//for
		%>
		</select>
		
		
		
		<!-- Month -->
		<select name='monthOfBirth'>
		<%
		//FOR options
		String output4="";
		for(int i=0;i<12;i++){
			//Reset variables
			output4="";
			String VAL="";
			String VIEW="";
			//Option context
			output4+="<option value='";
			switch(i){
			case 0:
				VAL = "1";
				VIEW = "January";
				output4+=VAL+"'";
				if(date[1]==1){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 1:
				VAL = "2";
				VIEW = "February";
				output4+=VAL+"'";
				if(date[1]==2){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 2:
				VAL = "3";
				VIEW = "March";
				output4+=VAL+"'";
				if(date[1]==3){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 3:
				VAL = "4";
				VIEW = "April";
				output4+=VAL+"'";
				if(date[1]==4){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 4:
				VAL = "5";
				VIEW = "May";
				output4+=VAL+"'";
				if(date[1]==5){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 5:
				VAL = "6";
				VIEW = "June";
				output4+=VAL+"'";
				if(date[1]==6){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 6:
				VAL = "7";
				VIEW = "July";
				output4+=VAL+"'";
				if(date[1]==7){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 7:
				VAL = "8";
				VIEW = "August";
				output4+=VAL+"'";
				if(date[1]==8){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 8:
				VAL = "9";
				VIEW = "September";
				output4+=VAL+"'";
				if(date[1]==9){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 9:
				VAL = "10";
				VIEW = "October";
				output4+=VAL+"'";
				if(date[1]==10){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 10:
				VAL = "11";
				VIEW = "November";
				output4+=VAL+"'";
				if(date[1]==11){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;
			case 11:
				VAL = "12";
				VIEW = "December";
				output4+=VAL+"'";
				if(date[1]==12){
					output4+=" selected='selected'";
				}
				output4+=">"+VIEW;
				break;			
			default:
				System.err.println("Goodbye Universe!");
				break;
			}//switch
			output4+="</option>";
			out.println(output4);
		}//for
		%>
		</select>
		
		
		<!-- Day -->
		<select name='dayOfBirth'>
		<%
		//FOR Options
		String output5="";
		for(int i=0;i<31;i++){
			//Reset variables
			output5="";
			String VAL="";
			String VIEW="";
			//Option context
			output5+="<option value='";
			switch(i){
			case 0:
				VAL = "1";
				VIEW = "1";
				output5+=VAL+"'";
				if(date[2]==1){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 1:
				VAL = "2";
				VIEW = "2";
				output5+=VAL+"'";
				if(date[2]==2){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 2:
				VAL = "3";
				VIEW = "3";
				output5+=VAL+"'";
				if(date[2]==3){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 3:
				VAL = "4";
				VIEW = "4";
				output5+=VAL+"'";
				if(date[2]==4){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 4:
				VAL = "5";
				VIEW = "5";
				output5+=VAL+"'";
				if(date[2]==5){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 5:
				VAL = "6";
				VIEW = "6";
				output5+=VAL+"'";
				if(date[2]==6){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 6:
				VAL = "7";
				VIEW = "7";
				output5+=VAL+"'";
				if(date[2]==7){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 7:
				VAL = "8";
				VIEW = "8";
				output5+=VAL+"'";
				if(date[2]==8){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 8:
				VAL = "9";
				VIEW = "9";
				output5+=VAL+"'";
				if(date[2]==9){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 9:
				VAL = "10";
				VIEW = "10";
				output5+=VAL+"'";
				if(date[2]==10){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 10:
				VAL = "11";
				VIEW = "11";
				output5+=VAL+"'";
				if(date[2]==11){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 11:
				VAL = "12";
				VIEW = "12";
				output5+=VAL+"'";
				if(date[2]==12){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 12:
				VAL = "13";
				VIEW = "13";
				output5+=VAL+"'";
				if(date[2]==13){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 13:
				VAL = "14";
				VIEW = "14";
				output5+=VAL+"'";
				if(date[2]==14){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 14:
				VAL = "15";
				VIEW = "15";
				output5+=VAL+"'";
				if(date[2]==15){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 15:
				VAL = "16";
				VIEW = "16";
				output5+=VAL+"'";
				if(date[2]==16){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 16:
				VAL = "17";
				VIEW = "17";
				output5+=VAL+"'";
				if(date[2]==17){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 17:
				VAL = "18";
				VIEW = "18";
				output5+=VAL+"'";
				if(date[2]==18){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 18:
				VAL = "19";
				VIEW = "19";
				output5+=VAL+"'";
				if(date[2]==19){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 19:
				VAL = "20";
				VIEW = "20";
				output5+=VAL+"'";
				if(date[2]==20){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 20:
				VAL = "21";
				VIEW = "21";
				output5+=VAL+"'";
				if(date[2]==21){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 21:
				VAL = "22";
				VIEW = "22";
				output5+=VAL+"'";
				if(date[2]==22){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 22:
				VAL = "23";
				VIEW = "23";
				output5+=VAL+"'";
				if(date[2]==23){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 23:
				VAL = "24";
				VIEW = "24";
				output5+=VAL+"'";
				if(date[2]==24){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 24:
				VAL = "25";
				VIEW = "25";
				output5+=VAL+"'";
				if(date[2]==25){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 25:
				VAL = "26";
				VIEW = "26";
				output5+=VAL+"'";
				if(date[2]==26){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 26:
				VAL = "27";
				VIEW = "27";
				output5+=VAL+"'";
				if(date[2]==27){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 27:
				VAL = "28";
				VIEW = "28";
				output5+=VAL+"'";
				if(date[2]==28){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 28:
				VAL = "29";
				VIEW = "29";
				output5+=VAL+"'";
				if(date[2]==29){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 29:
				VAL = "30";
				VIEW = "30";
				output5+=VAL+"'";
				if(date[2]==30){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			case 30:
				VAL = "31";
				VIEW = "31";
				output5+=VAL+"'";
				if(date[2]==31){
					output5+=" selected='selected'";
				}
				output5+=">"+VIEW;
				break;
			default:
				System.err.println("Goodbye Universe!");
				break;
			}//switch
			output5+="</option>";
			out.println(output5);
		}//for
		%>
		</select>
		
		</td>
	</tr>
	<tr>
		<td>Expected Graduating Year:<span style = "color:red">*</span></td>
		<td>
		<!-- old 
		<input type="text" name='yearOfStudy' value=' %=can.get("cYear").toString()%>'>
		-->
		
			<select name='yearOfStudy'>
			<%
			//options
			Integer cyear=Integer.parseInt(can.get("cYear").toString());
			String output6="";
			for(int i=0;i<51;i++){
				//Reset variables
				output6="";
				String VAL="";
				String VIEW="";
				//Option context
				output6+="<option value='";
				switch(i){
				case 0:
					VAL = "2015";
					VIEW = "2015";
					output6+=VAL+"'";
					if(cyear==2015){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 1:
					VAL = "2016";
					VIEW = "2016";
					output6+=VAL+"'";
					if(cyear==2016){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 2:
					VAL = "2017";
					VIEW = "2017";
					output6+=VAL+"'";
					if(cyear==2017){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 3:
					VAL = "2018";
					VIEW = "2018";
					output6+=VAL+"'";
					if(cyear==2018){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 4:
					VAL = "2019";
					VIEW = "2019";
					output6+=VAL+"'";
					if(cyear==2019){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 5:
					VAL = "2020";
					VIEW = "2020";
					output6+=VAL+"'";
					if(cyear==2020){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 6:
					VAL = "2021";
					VIEW = "2021";
					output6+=VAL+"'";
					if(cyear==2021){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 7:
					VAL = "2022";
					VIEW = "2022";
					output6+=VAL+"'";
					if(cyear==2022){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 8:
					VAL = "2023";
					VIEW = "2023";
					output6+=VAL+"'";
					if(cyear==2023){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 9:
					VAL = "2024";
					VIEW = "2024";
					output6+=VAL+"'";
					if(cyear==2024){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 10:
					VAL = "2025";
					VIEW = "2025";
					output6+=VAL+"'";
					if(cyear==2025){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 11:
					VAL = "2026";
					VIEW = "2026";
					output6+=VAL+"'";
					if(cyear==2026){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 12:
					VAL = "2027";
					VIEW = "2027";
					output6+=VAL+"'";
					if(cyear==2027){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 13:
					VAL = "2028";
					VIEW = "2028";
					output6+=VAL+"'";
					if(cyear==2028){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 14:
					VAL = "2029";
					VIEW = "2029";
					output6+=VAL+"'";
					if(cyear==2029){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 15:
					VAL = "2030";
					VIEW = "2030";
					output6+=VAL+"'";
					if(cyear==2030){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 16:
					VAL = "2031";
					VIEW = "2031";
					output6+=VAL+"'";
					if(cyear==2031){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 17:
					VAL = "2032";
					VIEW = "2032";
					output6+=VAL+"'";
					if(cyear==2032){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 18:
					VAL = "2033";
					VIEW = "2033";
					output6+=VAL+"'";
					if(cyear==2033){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 19:
					VAL = "2034";
					VIEW = "2034";
					output6+=VAL+"'";
					if(cyear==2034){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 20:
					VAL = "2035";
					VIEW = "2035";
					output6+=VAL+"'";
					if(cyear==2035){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 21:
					VAL = "2036";
					VIEW = "2036";
					output6+=VAL+"'";
					if(cyear==2036){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 22:
					VAL = "2037";
					VIEW = "2037";
					output6+=VAL+"'";
					if(cyear==2037){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 23:
					VAL = "2038";
					VIEW = "2038";
					output6+=VAL+"'";
					if(cyear==2038){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 24:
					VAL = "2039";
					VIEW = "2039";
					output6+=VAL+"'";
					if(cyear==2039){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 25:
					VAL = "2040";
					VIEW = "2040";
					output6+=VAL+"'";
					if(cyear==2040){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 26:
					VAL = "2041";
					VIEW = "2041";
					output6+=VAL+"'";
					if(cyear==2041){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 27:
					VAL = "2042";
					VIEW = "2042";
					output6+=VAL+"'";
					if(cyear==2042){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 28:
					VAL = "2043";
					VIEW = "2043";
					output6+=VAL+"'";
					if(cyear==2043){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 29:
					VAL = "2044";
					VIEW = "2044";
					output6+=VAL+"'";
					if(cyear==2044){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 30:
					VAL = "2045";
					VIEW = "2045";
					output6+=VAL+"'";
					if(cyear==2045){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 31:
					VAL = "2046";
					VIEW = "2046";
					output6+=VAL+"'";
					if(cyear==2046){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 32:
					VAL = "2047";
					VIEW = "2047";
					output6+=VAL+"'";
					if(cyear==2047){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 33:
					VAL = "2048";
					VIEW = "2048";
					output6+=VAL+"'";
					if(cyear==2048){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 34:
					VAL = "2049";
					VIEW = "2049";
					output6+=VAL+"'";
					if(cyear==2049){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 35:
					VAL = "2050";
					VIEW = "2050";
					output6+=VAL+"'";
					if(cyear==2050){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 36:
					VAL = "2051";
					VIEW = "2051";
					output6+=VAL+"'";
					if(cyear==2051){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 37:
					VAL = "2052";
					VIEW = "2052";
					output6+=VAL+"'";
					if(cyear==2052){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 38:
					VAL = "2053";
					VIEW = "2053";
					output6+=VAL+"'";
					if(cyear==2053){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 39:
					VAL = "2054";
					VIEW = "2054";
					output6+=VAL+"'";
					if(cyear==2054){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 40:
					VAL = "2055";
					VIEW = "2055";
					output6+=VAL+"'";
					if(cyear==2055){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 41:
					VAL = "2056";
					VIEW = "2056";
					output6+=VAL+"'";
					if(cyear==2056){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 42:
					VAL = "2057";
					VIEW = "2057";
					output6+=VAL+"'";
					if(cyear==2057){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 43:
					VAL = "2058";
					VIEW = "2058";
					output6+=VAL+"'";
					if(cyear==2058){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 44:
					VAL = "2059";
					VIEW = "2059";
					output6+=VAL+"'";
					if(cyear==2059){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 45:
					VAL = "2060";
					VIEW = "2060";
					output6+=VAL+"'";
					if(cyear==2060){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 46:
					VAL = "2061";
					VIEW = "2061";
					output6+=VAL+"'";
					if(cyear==2061){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 47:
					VAL = "2062";
					VIEW = "2062";
					output6+=VAL+"'";
					if(cyear==2062){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 48:
					VAL = "2063";
					VIEW = "2063";
					output6+=VAL+"'";
					if(cyear==2063){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 49:
					VAL = "2064";
					VIEW = "2064";
					output6+=VAL+"'";
					if(cyear==2064){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				case 50:
					VAL = "2065";
					VIEW = "2065";
					output6+=VAL+"'";
					if(cyear==2065){
						output6+=" selected='selected'";
					}
					output6+=">"+VIEW;
					break;
				default:
					System.err.println("Goodbye Universe!");
					break;
				}//switch
				output6+="</option>";
				out.println(output6);
			}//for
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td>Area of Degree/Program:<span style = "color:red">*</span></td>
		<td>
			<select name="area">
				<!-- JSP to select default value -->
				<%	//Get can gender string value
				String degree=can.get("degree").toString();
				String output2="";
				for(int i=1;i<29;i++){
					output2="";
					String VAL="";
					output2+="<option value='";
					switch(i){
					//case 0:
					//	VAL = "null";
					//	output2+=VAL+"'";
					//	if(degree.equalsIgnoreCase(VAL)){
					//		output2+=" selected='selected'"; 
					//	}
					//	output2+=">"+VAL;
					//	break;
					case 1:
						VAL = "Bachelors_Of_Applied_Science";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 2:
						VAL = "Bachelors_Of_Arts";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 3:
						VAL = "Bachelors_Of_Education";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 4:
						VAL = "Bachelors_Of_Engineering";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 5:
						VAL = "Bachelors_Of_Fine_Arts";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 6:
						VAL = "Bachelors_Of_Human_Kinetics";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 7:
						VAL = "Bachelors_Of_Management_Accounting";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 8:
						VAL = "Bachelors_Of_Management_Finance";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 9:
						VAL = "Bachelors_Of_Management_General";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 10:
						VAL = "Bachelors_Of_Management_Human_Resources";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 11:
						VAL = "Bachelors_Of_Management_Marketing";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 12:
						VAL = "Bachelors_Of_Management_Other";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 13:
						VAL = "Bachelors_Of_Management_Supply_Chain_Management";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 14:
						VAL = "Bachelors_Of_Science";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 15:
						VAL = "Bachelors_Of_Science_In_Nursing";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 16:
						VAL = "Doctor_Of_Philosophy";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 17:
						VAL = "Masters_Of_Applied_Science";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 18:
						VAL = "Masters_Of_Arts";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 19:
						VAL = "Masters_Of_Arts_In_Education";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 20:
						VAL = "Masters_Of_Arts_In_English";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 21:
						VAL = "Masters_Of_Education";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 22:
						VAL = "Masters_Of_Engineering";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 23:
						VAL = "Masters_Of_Fine_Arts";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 24:
						VAL = "Masters_Of_Management";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 25:
						VAL = "Masters_Of_Science";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 26:
						VAL = "Masters_Of_Science_In_Nursing";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 27:
						VAL = "Masters_Of_Social_Work";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					case 28:
						VAL = "None_Of_Above";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
					default:
						System.err.println("Goodbye Universe!");
						break;
					}//switch
					output2+="</option>";
					out.println(output2);
				}//for
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td>Phone Number:<span style = "color:red">*</span></td>
		<td><input type="text" name='phoneNumber' value='<%=can.get("cPhoneNumber").toString()%>'></td>
	</tr>
	<tr>
		<td>Email Address:</td>
		<td><input type="text" name='emailAddress' value='<%=can.get("cEmail").toString()%>'></td>
	</tr>
	<tr>
		<td>Resume HyperLink:</td>
		<td><input type="text" name='resumeHyperlink' value='<%=can.get("cResumeLink").toString()%>'></td>
	</tr>
	<tr>
		<td>Job History:</td>
		<!--
		<td><input type="text" name='jobHistory' value='<%=can.get("cJobHistory").toString()%>'></td>
		-->
		<td><textarea rows="5" cols="80" name='jobHistory'><%=can.get("cJobHistory").toString()%></textarea>
	</tr>
	<tr>
		<td>Brief Biography:</td>
		<!-- 
		<td><input type="text" name='briefBiography' value='<%=can.get("cDescription").toString()%>'></td>
		-->
		<td><textarea rows="5" cols="80" name='briefBiography'><%=can.get("cDescription").toString()%></textarea>
	</tr>
		
	</table>	
	<br>
	<input class='myButton' type="submit" name="submit" value="Save Changes">
</form>

</body>
</html>
