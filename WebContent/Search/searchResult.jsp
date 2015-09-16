<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Search Results</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Search/searchResult.css' rel='stylesheet' type='text/css'>


</head>
<body>

<%@page import="objects.*" %>
<%@page import="java.util.ArrayList" %>

<!-- Variables -->
<%! 
	String qFirst;
	String qLast;
	String qPhone;
	String qID;
	String qYearInt;
	String qYearLogic;
	String qArea;
	//
	int qOrderBy;
	String qOrderByDirection;
	int qNumResults;
	
	Search s;
	
%>


<!-- Get Session/Query -->
<%
	//Grab session object from request.
	session = request.getSession();
	
	//Get query variables
	qFirst=request.getParameter("queryFirst");
	qLast=request.getParameter("queryLast");
	qPhone=request.getParameter("queryPhone");
	qID=request.getParameter("queryID");
	qYearInt=request.getParameter("yearInt");
	qYearLogic=request.getParameter("yearLogic");
	qArea=request.getParameter("area");
	//
	qOrderBy=Integer.parseInt(request.getParameter("orderBy"));
	qOrderByDirection=request.getParameter("orderByDirection");
	qNumResults=Integer.parseInt(request.getParameter("numResults"));
	
%>

<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href=\"search.jsp\">Return To Search</a></div>");
%>
<!-- Header -->
<h3>Search Results for Candidates:</h3>
<ul>
<%

if(qFirst==null||qFirst.isEmpty()||qFirst.length()==0||qFirst.equalsIgnoreCase("")){
	//nothing was input to qFirst, so nothing in names
}else{
	String item="By the First Name ' ";
	item+=qFirst+" '.";
	out.println("<li>"+item+"</li>");
}
if(qLast==null||qLast.isEmpty()||qLast.length()==0||qLast.equalsIgnoreCase("")){
	//nothing was input to qLast, so nothing in names
}else{
	String item="By the Last Name ' ";
	item+=qLast+" '.";
	out.println("<li>"+item+"</li>");
}
if(qArea==null||qArea=="null"||qArea.isEmpty()||qArea.length()==0||qArea.equalsIgnoreCase("")){
	//no area was input, OR, "Any Area" (with a value of "null", the default option) was input.
	//Either way, it means we do not have to specify a particular area.
}else{
	String item="In the Area of ' ";
	item+= qArea+" '.";
	out.println("<li>"+item+"</li>");
}
if(qID==null||qID.isEmpty()||qID.length()==0||qID.equalsIgnoreCase("")){
	//nothing entered for qID, so no specific cid or cphonenumber
}else{
	String item="With the ID number ' ";
	item+=qID+" '.";
	out.println("<li>"+item+"</li>");
}
if(qPhone==null||qPhone.isEmpty()||qPhone.length()==0||qPhone.equalsIgnoreCase("")){
	//nothing entered for qPhone, so no specific cid or cphonenumber
}else{
	String item="With the Phone Number ' ";
	item+=qPhone+" '.";
	out.println("<li>"+item+"</li>");
}
if(qYearInt==null||qYearInt.isEmpty()||qYearInt.length()==0||qYearInt.equalsIgnoreCase("")){
	//nothing entered for graduating year
}else{
	String item="Graduating ";
	if(qYearLogic.equalsIgnoreCase("lessThan")){
		item+="before ";
	}else if(qYearLogic.equalsIgnoreCase("equal")){
		item+="in ";
	}else{
		item+="after ";
	}
	item+=qYearInt+".";
	out.println("<li>"+item+"</li>");
}
%>
</ul>



<!-- Search Object -->
<%
	//hardcoded
	int[] attrs=new int[]{1,2,3,4,6,7};
	s=new Search(qFirst, qLast, qID, qPhone, qArea, qYearInt, qYearLogic);
	String query=s.getResultSQLQuery(attrs, qOrderBy, 0, qNumResults, qOrderByDirection);
	ArrayList<CanMap> result=s.getResultsFromQuery(query,attrs, qOrderBy, 0, qNumResults, qOrderByDirection);

%>


<!-- Print Table (Copied from coDir, but modified)-->
<%
out.println("<table id=searchTable>");

//Print The Column Names, selected by the attrs[]
ArrayList<String> canMapNames=new ArrayList<String>();
ArrayList<String> columnNames=new ArrayList<String>();
for(int i: attrs){
	switch(i){
	case 1:  //cid
		canMapNames.add("cid");  columnNames.add("Candidate ID");
		break;
	case 2: //cfirstname
		canMapNames.add("cFirstName");  columnNames.add("First");
		break;
	case 3: //clastname
		canMapNames.add("cLastName");  columnNames.add("Last");
		break;
	case 4: //gender
		canMapNames.add("gender");  columnNames.add("Gender");
		break;
	case 5:	//cdateofbirth
		canMapNames.add("dob");  columnNames.add("Birthdate");
		break;
	case 6: //cyearofstudy
		canMapNames.add("cYear");  columnNames.add("Graduating Year");
		break;
	case 7: //cdegreeprogram
		canMapNames.add("degree");  columnNames.add("Area of Degree/Program");
		break;
	case 8: //cjobhistory
		canMapNames.add("cJobHistory");  columnNames.add("Job History");
		break;
	case 9: //cemail
		canMapNames.add("cEmail");  columnNames.add("Email");
		break;
	case 10://cphonenumber
		canMapNames.add("cPhoneNumber"); columnNames.add("Phone#");
		break;
	case 11://cresumelink
		canMapNames.add("cResumeLink"); columnNames.add("Resume");
		break;
	case 12://cdescription
		canMapNames.add("cDescription"); columnNames.add("Description");
		break;
	default:
		canMapNames.add("cid");  columnNames.add("whaaaaaa");
		System.err.println("going to default cid. "+i+" not recognized");
		break;
	}//switch
}

//Print Column Names
out.println("<tr>");
for(String s: columnNames){
	out.println("<td><b><u>"+s+"</u></b></td>");
}
//Profile Column
out.println("<td><b><u>Profile</u></b></td>");
out.println("</tr>");


//Print Company Directory
for(CanMap c:result){
	String row="";
	row+="<tr>";
	for(String s: canMapNames){
		Object o=c.get(s);
		//if String s is suppose to be a link
		if(s.equalsIgnoreCase("cResumeLink")){ 
			//row+="<td>"+"<a href='"+o.toString()+"'>"+o.toString()+"</a></td>";
			row+="<td>"+"<a href='"+o.toString()+"'>"+"Hyperlink"+"</a></td>";
		}else{
			row+="<td>"+o.toString()+"</td>";
		}		
	}
	//Print "Full Profile" buttons
	String id=(String)c.get("cid");
	row+="<td><form name='toProfile' method=post action='../Profile.jsp?uid="+id+"&isCompany="+"false"+"'><input type='submit' value='Full Profile'></form></td>";
		
	
	
	//finish and print row
	row+="</tr>";
	out.println(row);
}
out.println("</table>");

%>



</body>
</html>