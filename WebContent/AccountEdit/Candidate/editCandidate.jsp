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
</head>
<body>

<h3>
Please edit your profile information below, and hit save at the bottom of the page.<br>
</h3>

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
		out.println("<p id='loginError'>" + session.getAttribute("UpdateMessage").toString() + "</p>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 id='Error2'>" + session.getAttribute("problemList").toString() + "</h5>");
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
		<td>First Name:</td>
		<td><input type='text' name='firstName' value='<%=can.get("cFirstName").toString()%>'></td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><input type='text' name='lastName' value='<%=can.get("cLastName").toString()%>'></td>
	</tr>
	<tr>
		<td>Gender</td>
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
		<!-- Date Of Birth -->	
	
		<%
		//Change the date
		Timestamp ts=Timestamp.valueOf(can.get("dob").toString());
		String dob=Candidate.formStringDate(ts);
		//TESTPRINT
		System.out.println("AccountEdit;\nTimestamp(from CanMap): "+ts.toString()+"\nString dob (in field): "+dob);
		%>
		<td>Date Of Birth</td>
		<td><input type='text' name='dateOfBirth' value='<%out.println(dob);%>'></td>
	</tr>
	<tr>
		<td>Expected Graduating Year)</td>
		<td><input type="text" name='yearOfStudy' value='<%=can.get("cYear").toString()%>'></td>
	</tr>
	<tr>
		<td>Area of Degree/Program</td>
		<td>
			<select name="area">
				<!-- JSP to select default value -->
				<%	//Get can gender string value
				String degree=can.get("degree").toString();
				String output2="";
				for(int i=0;i<29;i++){
					output2="";
					String VAL="";
					output2+="<option value='";
					switch(i){
					case 0:
						VAL = "null";
						output2+=VAL+"'";
						if(degree.equalsIgnoreCase(VAL)){
							output2+=" selected='selected'"; 
						}
						output2+=">"+VAL;
						break;
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
		<td><font color='red'>Job History</font></td>
		<td><input type="text" name='jobHistory' value='<%=can.get("cJobHistory").toString()%>'></td>
	</tr>
	<tr>
		<td><font color='red'>Email Address</font></td>
		<td><input type="text" name='emailAddress' value='<%=can.get("cEmail").toString()%>'></td>
	</tr>
	<tr>
		<td>Phone Number:</td>
		<td><input type="text" name='phoneNumber' value='<%=can.get("cPhoneNumber").toString()%>'></td>
	</tr>
	<tr>
		<td><font color='red'>Resume HyperLink:</font></td>
		<td><input type="text" name='resumeHyperlink' value='<%=can.get("cResumeLink").toString()%>'></td>
	</tr>
	<tr>
		<td><font color='red'>Brief Biography:</font></td>
		<td><input type="text" name='briefBiography' value='<%=can.get("cDescription").toString()%>'></td>
	</tr>
		
	</table>	
	<br>
	<input type="submit" name="submit" value="Save Changes">
</form>

</body>
</html>
