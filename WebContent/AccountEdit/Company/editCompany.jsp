<%@page import="objects.Company"%>
<%@page import="objects.DataAccessObject"%>
<%@page import="objects.CoMap"%>
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
<link href='${pageContext.request.contextPath}/css/AccountEdit/Company/editCompany.css' rel='stylesheet' type='text/css'>

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
	Integer coid=Integer.parseInt((String)session.getAttribute("uid")); 
	
	//Clean session of unwanted attributes
	
	
	%>

<!-- Print Prior Error Account Message If Needed -->
<%
	// Print prior error login message if needed
	if (session.getAttribute("UpdateMessage") != null){
		out.println("<p class='error'>" + session.getAttribute("UpdateMessage").toString() + "</p>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 class='error'>" + session.getAttribute("problemList").toString() + "</h5>");
	}
%>

<!-- Get the Company's Info from the DB -->
<%
	CoMap co=dao.getCompany(coid);
%>

<!-- Form -->
<form name="EditUserForm" action="updateCompany.jsp" method=POST>
	<table width="70%">
	<tr>
		<td> Company ID:</td>
		<td><%out.println(coid);%></td>
	</tr>
	<tr>
		<td>Company Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='coName' value='<%=co.get("coName").toString()%>'></td>
	</tr>
	<tr>
		<td>Established:</td>
		<td>
		
			<!-- <input type="text" name='coYearEstablished' value=''>-->
			<select name='coYearEstablished'>
			<%
			//get the year
			Integer year=Integer.parseInt(co.get("coYearEstablished").toString());
			
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
				VAL = "1900";
				VIEW = "1900";
				output3+=VAL+"'";
				if(year==1900){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 1:
				VAL = "1901";
				VIEW = "1901";
				output3+=VAL+"'";
				if(year==1901){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 2:
				VAL = "1902";
				VIEW = "1902";
				output3+=VAL+"'";
				if(year==1902){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 3:
				VAL = "1903";
				VIEW = "1903";
				output3+=VAL+"'";
				if(year==1903){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 4:
				VAL = "1904";
				VIEW = "1904";
				output3+=VAL+"'";
				if(year==1904){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 5:
				VAL = "1905";
				VIEW = "1905";
				output3+=VAL+"'";
				if(year==1905){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 6:
				VAL = "1906";
				VIEW = "1906";
				output3+=VAL+"'";
				if(year==1906){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 7:
				VAL = "1907";
				VIEW = "1907";
				output3+=VAL+"'";
				if(year==1907){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 8:
				VAL = "1908";
				VIEW = "1908";
				output3+=VAL+"'";
				if(year==1908){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 9:
				VAL = "1909";
				VIEW = "1909";
				output3+=VAL+"'";
				if(year==1909){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 10:
				VAL = "1910";
				VIEW = "1910";
				output3+=VAL+"'";
				if(year==1910){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 11:
				VAL = "1911";
				VIEW = "1911";
				output3+=VAL+"'";
				if(year==1911){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 12:
				VAL = "1912";
				VIEW = "1912";
				output3+=VAL+"'";
				if(year==1912){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 13:
				VAL = "1913";
				VIEW = "1913";
				output3+=VAL+"'";
				if(year==1913){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 14:
				VAL = "1914";
				VIEW = "1914";
				output3+=VAL+"'";
				if(year==1914){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 15:
				VAL = "1915";
				VIEW = "1915";
				output3+=VAL+"'";
				if(year==1915){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 16:
				VAL = "1916";
				VIEW = "1916";
				output3+=VAL+"'";
				if(year==1916){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 17:
				VAL = "1917";
				VIEW = "1917";
				output3+=VAL+"'";
				if(year==1917){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 18:
				VAL = "1918";
				VIEW = "1918";
				output3+=VAL+"'";
				if(year==1918){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 19:
				VAL = "1919";
				VIEW = "1919";
				output3+=VAL+"'";
				if(year==1919){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 20:
				VAL = "1920";
				VIEW = "1920";
				output3+=VAL+"'";
				if(year==1920){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 21:
				VAL = "1921";
				VIEW = "1921";
				output3+=VAL+"'";
				if(year==1921){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 22:
				VAL = "1922";
				VIEW = "1922";
				output3+=VAL+"'";
				if(year==1922){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 23:
				VAL = "1923";
				VIEW = "1923";
				output3+=VAL+"'";
				if(year==1923){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 24:
				VAL = "1924";
				VIEW = "1924";
				output3+=VAL+"'";
				if(year==1924){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 25:
				VAL = "1925";
				VIEW = "1925";
				output3+=VAL+"'";
				if(year==1925){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 26:
				VAL = "1926";
				VIEW = "1926";
				output3+=VAL+"'";
				if(year==1926){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 27:
				VAL = "1927";
				VIEW = "1927";
				output3+=VAL+"'";
				if(year==1927){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 28:
				VAL = "1928";
				VIEW = "1928";
				output3+=VAL+"'";
				if(year==1928){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 29:
				VAL = "1929";
				VIEW = "1929";
				output3+=VAL+"'";
				if(year==1929){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 30:
				VAL = "1930";
				VIEW = "1930";
				output3+=VAL+"'";
				if(year==1930){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 31:
				VAL = "1931";
				VIEW = "1931";
				output3+=VAL+"'";
				if(year==1931){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 32:
				VAL = "1932";
				VIEW = "1932";
				output3+=VAL+"'";
				if(year==1932){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 33:
				VAL = "1933";
				VIEW = "1933";
				output3+=VAL+"'";
				if(year==1933){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 34:
				VAL = "1934";
				VIEW = "1934";
				output3+=VAL+"'";
				if(year==1934){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 35:
				VAL = "1935";
				VIEW = "1935";
				output3+=VAL+"'";
				if(year==1935){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 36:
				VAL = "1936";
				VIEW = "1936";
				output3+=VAL+"'";
				if(year==1936){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 37:
				VAL = "1937";
				VIEW = "1937";
				output3+=VAL+"'";
				if(year==1937){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 38:
				VAL = "1938";
				VIEW = "1938";
				output3+=VAL+"'";
				if(year==1938){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 39:
				VAL = "1939";
				VIEW = "1939";
				output3+=VAL+"'";
				if(year==1939){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 40:
				VAL = "1940";
				VIEW = "1940";
				output3+=VAL+"'";
				if(year==1940){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 41:
				VAL = "1941";
				VIEW = "1941";
				output3+=VAL+"'";
				if(year==1941){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 42:
				VAL = "1942";
				VIEW = "1942";
				output3+=VAL+"'";
				if(year==1942){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 43:
				VAL = "1943";
				VIEW = "1943";
				output3+=VAL+"'";
				if(year==1943){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 44:
				VAL = "1944";
				VIEW = "1944";
				output3+=VAL+"'";
				if(year==1944){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 45:
				VAL = "1945";
				VIEW = "1945";
				output3+=VAL+"'";
				if(year==1945){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 46:
				VAL = "1946";
				VIEW = "1946";
				output3+=VAL+"'";
				if(year==1946){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 47:
				VAL = "1947";
				VIEW = "1947";
				output3+=VAL+"'";
				if(year==1947){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 48:
				VAL = "1948";
				VIEW = "1948";
				output3+=VAL+"'";
				if(year==1948){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 49:
				VAL = "1949";
				VIEW = "1949";
				output3+=VAL+"'";
				if(year==1949){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 50:
				VAL = "1950";
				VIEW = "1950";
				output3+=VAL+"'";
				if(year==1950){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 51:
				VAL = "1951";
				VIEW = "1951";
				output3+=VAL+"'";
				if(year==1951){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 52:
				VAL = "1952";
				VIEW = "1952";
				output3+=VAL+"'";
				if(year==1952){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 53:
				VAL = "1953";
				VIEW = "1953";
				output3+=VAL+"'";
				if(year==1953){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 54:
				VAL = "1954";
				VIEW = "1954";
				output3+=VAL+"'";
				if(year==1954){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 55:
				VAL = "1955";
				VIEW = "1955";
				output3+=VAL+"'";
				if(year==1955){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 56:
				VAL = "1956";
				VIEW = "1956";
				output3+=VAL+"'";
				if(year==1956){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 57:
				VAL = "1957";
				VIEW = "1957";
				output3+=VAL+"'";
				if(year==1957){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 58:
				VAL = "1958";
				VIEW = "1958";
				output3+=VAL+"'";
				if(year==1958){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 59:
				VAL = "1959";
				VIEW = "1959";
				output3+=VAL+"'";
				if(year==1959){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 60:
				VAL = "1960";
				VIEW = "1960";
				output3+=VAL+"'";
				if(year==1960){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 61:
				VAL = "1961";
				VIEW = "1961";
				output3+=VAL+"'";
				if(year==1961){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 62:
				VAL = "1962";
				VIEW = "1962";
				output3+=VAL+"'";
				if(year==1962){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 63:
				VAL = "1963";
				VIEW = "1963";
				output3+=VAL+"'";
				if(year==1963){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 64:
				VAL = "1964";
				VIEW = "1964";
				output3+=VAL+"'";
				if(year==1964){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 65:
				VAL = "1965";
				VIEW = "1965";
				output3+=VAL+"'";
				if(year==1965){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 66:
				VAL = "1966";
				VIEW = "1966";
				output3+=VAL+"'";
				if(year==1966){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 67:
				VAL = "1967";
				VIEW = "1967";
				output3+=VAL+"'";
				if(year==1967){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 68:
				VAL = "1968";
				VIEW = "1968";
				output3+=VAL+"'";
				if(year==1968){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 69:
				VAL = "1969";
				VIEW = "1969";
				output3+=VAL+"'";
				if(year==1969){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 70:
				VAL = "1970";
				VIEW = "1970";
				output3+=VAL+"'";
				if(year==1970){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 71:
				VAL = "1971";
				VIEW = "1971";
				output3+=VAL+"'";
				if(year==1971){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 72:
				VAL = "1972";
				VIEW = "1972";
				output3+=VAL+"'";
				if(year==1972){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 73:
				VAL = "1973";
				VIEW = "1973";
				output3+=VAL+"'";
				if(year==1973){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 74:
				VAL = "1974";
				VIEW = "1974";
				output3+=VAL+"'";
				if(year==1974){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 75:
				VAL = "1975";
				VIEW = "1975";
				output3+=VAL+"'";
				if(year==1975){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 76:
				VAL = "1976";
				VIEW = "1976";
				output3+=VAL+"'";
				if(year==1976){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 77:
				VAL = "1977";
				VIEW = "1977";
				output3+=VAL+"'";
				if(year==1977){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 78:
				VAL = "1978";
				VIEW = "1978";
				output3+=VAL+"'";
				if(year==1978){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 79:
				VAL = "1979";
				VIEW = "1979";
				output3+=VAL+"'";
				if(year==1979){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 80:
				VAL = "1980";
				VIEW = "1980";
				output3+=VAL+"'";
				if(year==1980){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 81:
				VAL = "1981";
				VIEW = "1981";
				output3+=VAL+"'";
				if(year==1981){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 82:
				VAL = "1982";
				VIEW = "1982";
				output3+=VAL+"'";
				if(year==1982){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 83:
				VAL = "1983";
				VIEW = "1983";
				output3+=VAL+"'";
				if(year==1983){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 84:
				VAL = "1984";
				VIEW = "1984";
				output3+=VAL+"'";
				if(year==1984){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 85:
				VAL = "1985";
				VIEW = "1985";
				output3+=VAL+"'";
				if(year==1985){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 86:
				VAL = "1986";
				VIEW = "1986";
				output3+=VAL+"'";
				if(year==1986){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 87:
				VAL = "1987";
				VIEW = "1987";
				output3+=VAL+"'";
				if(year==1987){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 88:
				VAL = "1988";
				VIEW = "1988";
				output3+=VAL+"'";
				if(year==1988){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 89:
				VAL = "1989";
				VIEW = "1989";
				output3+=VAL+"'";
				if(year==1989){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 90:
				VAL = "1990";
				VIEW = "1990";
				output3+=VAL+"'";
				if(year==1990){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 91:
				VAL = "1991";
				VIEW = "1991";
				output3+=VAL+"'";
				if(year==1991){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 92:
				VAL = "1992";
				VIEW = "1992";
				output3+=VAL+"'";
				if(year==1992){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 93:
				VAL = "1993";
				VIEW = "1993";
				output3+=VAL+"'";
				if(year==1993){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 94:
				VAL = "1994";
				VIEW = "1994";
				output3+=VAL+"'";
				if(year==1994){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 95:
				VAL = "1995";
				VIEW = "1995";
				output3+=VAL+"'";
				if(year==1995){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 96:
				VAL = "1996";
				VIEW = "1996";
				output3+=VAL+"'";
				if(year==1996){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 97:
				VAL = "1997";
				VIEW = "1997";
				output3+=VAL+"'";
				if(year==1997){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 98:
				VAL = "1998";
				VIEW = "1998";
				output3+=VAL+"'";
				if(year==1998){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 99:
				VAL = "1999";
				VIEW = "1999";
				output3+=VAL+"'";
				if(year==1999){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 100:
				VAL = "2000";
				VIEW = "2000";
				output3+=VAL+"'";
				if(year==2000){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 101:
				VAL = "2001";
				VIEW = "2001";
				output3+=VAL+"'";
				if(year==2001){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 102:
				VAL = "2002";
				VIEW = "2002";
				output3+=VAL+"'";
				if(year==2002){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 103:
				VAL = "2003";
				VIEW = "2003";
				output3+=VAL+"'";
				if(year==2003){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 104:
				VAL = "2004";
				VIEW = "2004";
				output3+=VAL+"'";
				if(year==2004){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 105:
				VAL = "2005";
				VIEW = "2005";
				output3+=VAL+"'";
				if(year==2005){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 106:
				VAL = "2006";
				VIEW = "2006";
				output3+=VAL+"'";
				if(year==2006){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 107:
				VAL = "2007";
				VIEW = "2007";
				output3+=VAL+"'";
				if(year==2007){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 108:
				VAL = "2008";
				VIEW = "2008";
				output3+=VAL+"'";
				if(year==2008){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 109:
				VAL = "2009";
				VIEW = "2009";
				output3+=VAL+"'";
				if(year==2009){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 110:
				VAL = "2010";
				VIEW = "2010";
				output3+=VAL+"'";
				if(year==2010){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 111:
				VAL = "2011";
				VIEW = "2011";
				output3+=VAL+"'";
				if(year==2011){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 112:
				VAL = "2012";
				VIEW = "2012";
				output3+=VAL+"'";
				if(year==2012){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 113:
				VAL = "2013";
				VIEW = "2013";
				output3+=VAL+"'";
				if(year==2013){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 114:
				VAL = "2014";
				VIEW = "2014";
				output3+=VAL+"'";
				if(year==2014){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 115:
				VAL = "2015";
				VIEW = "2015";
				output3+=VAL+"'";
				if(year==2015){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 116:
				VAL = "2016";
				VIEW = "2016";
				output3+=VAL+"'";
				if(year==2016){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 117:
				VAL = "2017";
				VIEW = "2017";
				output3+=VAL+"'";
				if(year==2017){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 118:
				VAL = "2018";
				VIEW = "2018";
				output3+=VAL+"'";
				if(year==2018){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 119:
				VAL = "2019";
				VIEW = "2019";
				output3+=VAL+"'";
				if(year==2019){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 120:
				VAL = "2020";
				VIEW = "2020";
				output3+=VAL+"'";
				if(year==2020){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 121:
				VAL = "2021";
				VIEW = "2021";
				output3+=VAL+"'";
				if(year==2021){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 122:
				VAL = "2022";
				VIEW = "2022";
				output3+=VAL+"'";
				if(year==2022){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 123:
				VAL = "2023";
				VIEW = "2023";
				output3+=VAL+"'";
				if(year==2023){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 124:
				VAL = "2024";
				VIEW = "2024";
				output3+=VAL+"'";
				if(year==2024){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 125:
				VAL = "2025";
				VIEW = "2025";
				output3+=VAL+"'";
				if(year==2025){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 126:
				VAL = "2026";
				VIEW = "2026";
				output3+=VAL+"'";
				if(year==2026){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 127:
				VAL = "2027";
				VIEW = "2027";
				output3+=VAL+"'";
				if(year==2027){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 128:
				VAL = "2028";
				VIEW = "2028";
				output3+=VAL+"'";
				if(year==2028){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 129:
				VAL = "2029";
				VIEW = "2029";
				output3+=VAL+"'";
				if(year==2029){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 130:
				VAL = "2030";
				VIEW = "2030";
				output3+=VAL+"'";
				if(year==2030){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 131:
				VAL = "2031";
				VIEW = "2031";
				output3+=VAL+"'";
				if(year==2031){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 132:
				VAL = "2032";
				VIEW = "2032";
				output3+=VAL+"'";
				if(year==2032){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 133:
				VAL = "2033";
				VIEW = "2033";
				output3+=VAL+"'";
				if(year==2033){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 134:
				VAL = "2034";
				VIEW = "2034";
				output3+=VAL+"'";
				if(year==2034){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 135:
				VAL = "2035";
				VIEW = "2035";
				output3+=VAL+"'";
				if(year==2035){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 136:
				VAL = "2036";
				VIEW = "2036";
				output3+=VAL+"'";
				if(year==2036){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 137:
				VAL = "2037";
				VIEW = "2037";
				output3+=VAL+"'";
				if(year==2037){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 138:
				VAL = "2038";
				VIEW = "2038";
				output3+=VAL+"'";
				if(year==2038){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 139:
				VAL = "2039";
				VIEW = "2039";
				output3+=VAL+"'";
				if(year==2039){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 140:
				VAL = "2040";
				VIEW = "2040";
				output3+=VAL+"'";
				if(year==2040){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 141:
				VAL = "2041";
				VIEW = "2041";
				output3+=VAL+"'";
				if(year==2041){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 142:
				VAL = "2042";
				VIEW = "2042";
				output3+=VAL+"'";
				if(year==2042){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 143:
				VAL = "2043";
				VIEW = "2043";
				output3+=VAL+"'";
				if(year==2043){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 144:
				VAL = "2044";
				VIEW = "2044";
				output3+=VAL+"'";
				if(year==2044){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 145:
				VAL = "2045";
				VIEW = "2045";
				output3+=VAL+"'";
				if(year==2045){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 146:
				VAL = "2046";
				VIEW = "2046";
				output3+=VAL+"'";
				if(year==2046){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 147:
				VAL = "2047";
				VIEW = "2047";
				output3+=VAL+"'";
				if(year==2047){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 148:
				VAL = "2048";
				VIEW = "2048";
				output3+=VAL+"'";
				if(year==2048){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 149:
				VAL = "2049";
				VIEW = "2049";
				output3+=VAL+"'";
				if(year==2049){
					output3+=" selected='selected'";
				}
				output3+=">"+VIEW;
				break;
			case 150:
				VAL = "2050";
				VIEW = "2050";
				output3+=VAL+"'";
				if(year==2050){
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
		
		
		</td>
	</tr>
	<tr>
		<td>Company Address:</td>
		<td><input type="text" name='coAddress' value='<%=co.get("coAddress").toString()%>'></td>
	</tr>
	<tr>
		<td>Telephone:</td>
		<td><input type="text" name='coTel' value='<%=co.get("coTel").toString()%>'></td>
	</tr>
	<tr>	
		<td>Company Email:</td>
		<td><input type="text" name='coEmail' value='<%=co.get("coEmail").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Contact:</td>
		<td><input type="text" name='coContactName' value='<%=co.get("coContactName").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Website:</td>
		<td><input type="text" name='coUrl' value='<%=co.get("coUrl").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Social:</td>
		<td><input type="text" name='coSocial' value='<%=co.get("coSocial").toString()%>'></td>
	</tr>
	<tr>
		<td>Company Description:</td>
		<td><textarea rows="5" cols="80" name='coDescription'><%=co.get("coDescription").toString()%></textarea>
	</tr>
	</table>	
	<br>
	<input class='myButton' type="submit" name="submit" value="Save Changes">
</form>

</body>
</html>
