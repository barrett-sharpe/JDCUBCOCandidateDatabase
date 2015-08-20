<%@page import="objects.DataAccessObject"%>

<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up with JDCWest</title>
</head>
<body>

<h1>Join JDC West Today!</h1>
<h3>
We just need some basic information in order to create your account with us.<br>
</h3>

<!-- Variables -->
<%! DataAccessObject dao=new DataAccessObject(); %>
	
<!-- Session Object Request for Username/Password-->
	<%
	// Grab session object from request.
	session = request.getSession();
	//Collect the username (uname) entered by the user, from the session.
	String cid=String.valueOf(session.getAttribute("cid"));
	
	//Clean session of unwanted attributes
	session.removeAttribute("authenticatedUser");
	session.removeAttribute("CandidateMessage");
	//session.removeAttribute("problemList");// from addCandidate
	%>

<!-- Print Prior Error Account Message If Needed -->
<%
	if (session.getAttribute("CandidateMessage") != null){
		out.println("<h5 id='Error'>" + session.getAttribute("CandidateMessage").toString() + "</h5>");
	}

	if(session.getAttribute("problemList")!= null){
		out.println("<h5 id='Error2'>" + session.getAttribute("problemList").toString() + "</h5>");
	}
%>

<!-- Form -->
<form name="NewUserForm" action="addCandidate.jsp" method=POST>
	<table width="70%">
	<tr>
		<td> Candidate ID:</td>
		<td><%out.println(cid);%></td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td><input type='text' name='firstName' value=''></td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><input type='text' name='lastName' value=''></td>
	</tr>
	<tr>
		<td>Gender</td>
		<td>
			<select name='gender'>
				<option value='NotDeclared' selected="selected">Not Declared</option>
				<option value='Male'>Male</option>
				<option value='Female'>Female</option>
				<option value='Transgendered'>Transgender</option>
				<option value='Other'>Other</option>
			</select>
		</td>
	</tr> 
	<tr>
		<td>Date Of Birth</td>
		<!--
		<td><input type='text' name='dateOfBirth' value='YYYY-MM-DD'></td>
		-->
		<td>
			<input type="text" name='dayOfBirth' value='(D)D'>
			<input type="text" name='monthOfBirth' value='(M)M'>
			<input type="text" name='yearOfBirth' value='YYYY'>
		</td>
	</tr>
	<tr>
		<td>Year Of Study (or Graduating Year)</td>
		<td><input type="text" name='yearOfStudy' value='YYYY'></td>
	</tr>
	<tr>
		<td>Degree/Area of Expertise</td>
		<td>
			<select name="area">
					<!-- <option value="null" selected="selected"></option> -->
					<option value="Bachelors_Of_Applied_Science">Bachelors Of Applied Science</option>
					<option value="Bachelors_Of_Arts">Bachelors Of Arts</option>
					<option value="Bachelors_Of_Education">Bachelors Of Education</option>
					<option value="Bachelors_Of_Engineering">Bachelors Of Engineering</option>
					<option value="Bachelors_Of_Fine_Arts">Bachelors Of Fine Arts</option>
					<option value="Bachelors_Of_Human_Kinetics">Bachelors Of Human Kinetics</option>
					<option value="Bachelors_Of_Management_Accounting">Bachelors Of Management Accounting</option>
					<option value="Bachelors_Of_Management_Finance">Bachelors Of Management Finance</option>
					<option value="Bachelors_Of_Management_General">Bachelors Of Management General</option>
					<option value="Bachelors_Of_Management_Human_Resources">Bachelors Of Management Human Resources</option>
					<option value="Bachelors_Of_Management_Marketing">Bachelors Of Management Marketing</option>
					<option value="Bachelors_Of_Management_Other">Bachelors Of Management Other</option>
					<option value="Bachelors_Of_Management_Supply_Chain_Management">Bachelors Of Management Supply Chain Management</option>
					<option value="Bachelors_Of_Science">Bachelors Of Science</option>
					<option value="Bachelors_Of_Science_In_Nursing">Bachelors Of Science In Nursing</option>
					<option value="Doctor_Of_Philosophy">Doctor Of Philosophy</option>
					<option value="Masters_Of_Applied_Science">Masters Of Applied Science</option>
					<option value="Masters_Of_Arts">Masters Of Arts</option>
					<option value="Masters_Of_Arts_In_Education">Masters Of Arts In Education</option>
					<option value="Masters_Of_Arts_In_English">Masters Of Arts In English</option>
					<option value="Masters_Of_Education">Masters Of Education</option>
					<option value="Masters_Of_Engineering">Masters Of Engineering</option>
					<option value="Masters_Of_Fine_Arts">Masters Of Fine Arts</option>
					<option value="Masters_Of_Management">Masters Of Management</option>
					<option value="Masters_Of_Science">Masters Of Science</option>
					<option value="Masters_Of_Science_In_Nursing">Masters Of Science In Nursing</option>
					<option value="Masters_Of_Social_Work">Masters Of Social Work</option>
					<option value="None_Of_Above" selected="selected">None Of Above</option>
				</select>
		</td>
	</tr>
	<tr>
		<td><font color='red'>Job History</font></td>
		<td><input type="text" name='jobHistory' value=''></td>
	</tr>
	<tr>
		<td><font color='red'>Email Address</font></td>
		<td><input type="text" name='emailAddress' value=''></td>
	</tr>
	<tr>
		<td>Phone Number:</td>
		<td><input type="text" name='phoneNumber' value=''></td>
	</tr>
	<tr>
		<td><font color='red'>Resume HyperLink:</font></td>
		<td><input type="text" name='resumeHyperlink' value=''></td>
	</tr>
	<tr>
		<td><font color='red'>Brief Biography:</font></td>
		<td><input type="text" name='briefBiography' value=''></td>
	</tr>
		
	</table>
		
	<br>
	<input type="submit" name="submit" value="Create User">
</form>

</body>
</html>
