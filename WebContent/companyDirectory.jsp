<%@page import="java.util.AbstractMap"%>
<%@page import="objects.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Directory</title>
</head>
<body>

<!-- Authorized Page.-->
<%@ include file="auth.jsp"%>

<!-- Variables -->
<%! UserDAO udao=new UserDAO(); %>

<!-- Session -->
<%
	// Grab session object from request.
	session = request.getSession();
	
//user's name
	//String user = (String) session.getAttribute("authenticatedUser");
	//String id = (String) session.getAttribute("uid");
	//boolean isCompany = Boolean.parseBoolean(String.valueOf(session.getAttribute("isCompany")));
%>

<!-- UserDao for table -->
<%
//!@# hardcoded 0,1,3,5,9
//int[] attrs=new int[]{0,1,3,4,5,9};
int[] attrs=new int[]{0,1,3,4,9};
ArrayList<CoMap> result=udao.getCompanyDirectory(attrs, 0, 0, 900000);

%>

<!-- Back Button -->
<%
out.println("<a href=\"protectedPage.jsp\">Return To Page</a>");
%>

<!-- Print Table -->
<%
out.println("<h1>Company Directory for JDC West UBC Okanagan</h1>");
out.println("<table id=directoryCompany>");

//Print The Column Names, selected by the attribute index []
ArrayList<String> coMapNames=new ArrayList<String>();
ArrayList<String> columnNames=new ArrayList<String>();
for(int i: attrs){
	switch(i){
	case 0: //coid
		coMapNames.add("coid");  columnNames.add("Co. ID");
		break;
	case 1:  //coname
		coMapNames.add("coName");  columnNames.add("Co. Name");
		break;
	case 2: //coyearestablished
		coMapNames.add("coYearEstablished");  columnNames.add("Established");
		break;
	case 3: //coemail
		coMapNames.add("coEmail");  columnNames.add("Co. Email");
		break;
	case 4: //courl
		coMapNames.add("coUrl");  columnNames.add("Co. Website");
		break;
	case 5:	//cocontactname
		coMapNames.add("coContactName");  columnNames.add("Co. Contact Name");
		break;
	case 6: //coaddress
		coMapNames.add("coAddress");  columnNames.add("Co. Address");
		break;
	case 7: //cotel
		coMapNames.add("coTel");  columnNames.add("Co. Telephone");
		break;
	case 8: //codescription
		coMapNames.add("coDescription");  columnNames.add("Description");
		break;
	case 9: //cosocial
		coMapNames.add("coSocial");  columnNames.add("Social Media");
		break;
	default:
		coMapNames.add("coid");  columnNames.add("whaaaaaa");
		System.err.println("going to default coid. "+i+" not recognized");
		break;
	}//switch
}

//Print Column Names
out.println("<tr>");
for(String s: columnNames){
	out.println("<td><h3><b><u>"+s+"</u></b></h3></td>");
}

	//TEST Extra row for buttons
	out.println("<td><h3><b><u>Profile</u></b></h3></td>");

out.println("</tr>");

			
//Print Company Directory
for(CoMap c:result){
	String row="";
	row+="<tr>";
	for(String s: coMapNames){
		Object o=c.get(s);
		//if String s is suppose to be a link
		if(s.equalsIgnoreCase("courl") || s.equalsIgnoreCase("cosocial")){
			//row+="<td>"+"<a href='"+o.toString()+"'>"+o.toString()+"</a></td>";
			row+="<td>"+"<a href='"+o.toString()+"'>"+"Hyperlink"+"</a></td>";
		}else{
			row+="<td>"+o.toString()+"</td>";
		}		
	}
	
	//Print "Full Profile" buttons
	String id=(String)c.get("coid");
	row+="<td><form name='toProfile' method=post action='Profile.jsp?uid="+id+"&isCompany="+"true"+"'><input type='submit' value='Full Profile'></form></td>";
	
	//finalize and print row
	row+="</tr>";
	out.println(row);
}//each row

out.println("</table>");

%>

</body>
</html>

<!-- 

ArrayList<String> columnNames=new ArrayList<String>();

//Determine Column Names
CoMap cm=result.get(0);
for(int i: attrs){
	switch(i){
	case 0: //coid
		columnNames.add("coid");
		break;
	case 1:  //coname
		columnNames.add("coName");
		break;
	case 2: //coyearestablished
		columnNames.add("coYearEstablished");
		break;
	case 3: //coemail
		columnNames.add("coEmail");
		break;
	case 4: //courl
		columnNames.add("coUrl");
		break;
	case 5:	//cocontactname
		columnNames.add("coContactName");
		break;
	case 6: //coaddress
		columnNames.add("coAddress");
		break;
	case 7: //cotel
		columnNames.add("coTel");
		break;
	case 8: //codescription
		columnNames.add("coDescription");
		break;
	case 9: //cosocial
		columnNames.add("coSocial");
		break;
	default:
		columnNames.add("coid");
		System.err.println("going to default coid. "+i+" not recognized");
		break;
	}//switch
}
//Print Column Names
out.println("<tr>");
for(String s: columnNames){
	out.println("<td>"+s+"</td>");
}
out.println("</tr>");

//Print Company Directory
for(CoMap c:result){
	String row="";
	row+="<tr>";
	for(String s: columnNames){ //could potentially be different names...!@#
		Object o=c.get(s);
		row+="<td>"+o.toString()+"</td>";
	}
	row+="</tr>";
	
	out.println(row);
}


out.println("</table>");

 -->
