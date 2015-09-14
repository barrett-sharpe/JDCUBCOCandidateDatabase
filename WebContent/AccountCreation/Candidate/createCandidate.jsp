<%@page import="objects.DataAccessObject"%>

<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Your Profile</title>
<style>
body{
	font-family: Roboto;
	background-color: #F9F9F9; /* off white*/
}

#Error{

}
#Error2{

}
/*button*/
.myButton {
	-moz-box-shadow:inset 0px 1px 0px 0px #54a3f7;
	-webkit-box-shadow:inset 0px 1px 0px 0px #54a3f7;
	box-shadow:inset 0px 1px 0px 0px #54a3f7;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #629dd1), color-stop(1, #0061a7));
	background:-moz-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-webkit-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-o-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:-ms-linear-gradient(top, #629dd1 5%, #0061a7 100%);
	background:linear-gradient(to bottom, #629dd1 5%, #0061a7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#629dd1', endColorstr='#0061a7',GradientType=0);
	background-color:#629dd1;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #124d77;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #154682;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0061a7), color-stop(1, #629dd1));
	background:-moz-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-webkit-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-o-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:-ms-linear-gradient(top, #0061a7 5%, #629dd1 100%);
	background:linear-gradient(to bottom, #0061a7 5%, #629dd1 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0061a7', endColorstr='#629dd1',GradientType=0);
	background-color:#0061a7;
}
.myButton:active {
	position:relative;
	top:1px;
}

</style>
</head>
<body>

<h2>Create Your Profile!</h2>
<h3>
We just need some basic information in order to create your account with us.<br>
</h3>
<p>(<span style = "color:red">*</span> - required)</p>

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
		<td> Candidate ID:<span style = "color:red">*</span></td>
		<td><%out.println(cid);%></td>
	</tr>
	<tr>
		<td>First Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='firstName' value=''></td>
	</tr>
	<tr>
		<td>Last Name:<span style = "color:red">*</span></td>
		<td><input type='text' name='lastName' value=''></td>
	</tr>
	<tr>
		<td>Gender<span style = "color:red">*</span></td>
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
		<td>Date Of Birth<span style = "color:red">*</span> (yyyy-mm-dd)</td>
		
		<td>
			<input type="text" name='yearOfBirth' size="12" value='yyyy'>
			<input type="text" name='monthOfBirth' size="8" value='mm'>
			<input type="text" name='dayOfBirth' size="8" value='dd'>	
		</td>
	</tr>
	<tr>
		<td>Expected Graduating Year<span style = "color:red">*</span></td>
		<td><input type="text" name='yearOfStudy' value='yyyy'></td>
	</tr>
	<tr>
		<td>Area of Degree/Program<span style = "color:red">*</span></td>
		<td>
			<select name="area">
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
		<td>Phone Number:<span style = "color:red">*</span></td>
		<td><input type="text" name='phoneNumber' value=''></td>
	</tr>
	<tr>
		<td>Email Address</td>
		<td><input type="text" name='emailAddress' value=''></td>
	</tr>
	<tr>
		<td>Resume HyperLink:</td>
		<td><input type="text" name='resumeHyperlink' size="80" value=''></td>
	</tr>
	<tr>
		<td>Job History</td>
		<td><textarea rows="5" cols="80" name='jobHistory'></textarea></td>
	</tr>
	<tr>
		<td>Brief Biography:</td> 
		<td>
		<textarea rows="5" cols="80" name="briefBiography"></textarea>
		</td>
	</tr>
		
	</table>
		
	<br>
	<input class='myButton' type="submit" name="submit" value="Create User">
</form>

</body>
</html>
