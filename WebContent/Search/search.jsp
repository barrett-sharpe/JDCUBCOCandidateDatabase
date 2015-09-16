<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Candidate Search</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Search/search.css' rel='stylesheet' type='text/css'>


</head>
<body>

<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href=\"../protectedPage.jsp\">Return To Page</a></div>");
%>

<!-- Title -->
<h2>Search For A Candidate</h2>

<!-- Search Form  //!@# check if 'get' or 'post' needed-->
<form name="searchForm" method=get action="searchResult.jsp">

<!-- FIELDSET 1: Candidate Info -->
<br>
<fieldset>
<legend>Candidate Search</legend>
<table width="80%">
<!-- ROW 1: First&Last -->
	<tr>
			<td>First Name:</td>
			<td><input type="text" name="queryFirst" size=40></td>
	</tr>
	<tr>
			<td>Last Name:</td>
			<td><input type="text" name="queryLast" size=40></td>
	</tr>
<!-- ROW 2: Numbers -->
	<tr>
			<td>ID Number:</td>
			<td><input type="text" name="queryID" size=40></td>
	</tr>
	<tr>
			<td>Phone Number:</td>
			<td><input type="text" name="queryPhone" size=40></td>
	</tr>
<!-- ROW 3: Area -->
	<tr>
		<td>Area/Degree:</td>
		<td>
			<!-- <div align="center"> -->
			
			
				
				<select name="area">
					<optgroup label="All or None">
						<!-- Any/All option value is empty ("") and not "null". This to not have search pick this attribute. But it might be filtered out with nill detection -->
						<option value="" selected="selected">Any Area/Degree</option>
						<option value="None_Of_Above">None Of Above</option>
					</optgroup>
					<optgroup label="Management">
						<option value="Bachelors_Of_Management_Accounting">Bachelors Of Management Accounting</option>
						<option value="Bachelors_Of_Management_Finance">Bachelors Of Management Finance</option>
						<option value="Bachelors_Of_Management_General">Bachelors Of Management General</option>
						<option value="Bachelors_Of_Management_Human_Resources">Bachelors Of Management Human Resources</option>
						<option value="Bachelors_Of_Management_Marketing">Bachelors Of Management Marketing</option>
						<option value="Bachelors_Of_Management_Other">Bachelors Of Management Other</option>
						<option value="Bachelors_Of_Management_Supply_Chain_Management">Bachelors Of Management Supply Chain Management</option>
					</optgroup>
					<optgroup label="Non-Management">
						<option value="Bachelors_Of_Applied_Science">Bachelors Of Applied Science</option>
						<option value="Bachelors_Of_Arts">Bachelors Of Arts</option>
						<option value="Bachelors_Of_Education">Bachelors Of Education</option>
						<option value="Bachelors_Of_Engineering">Bachelors Of Engineering</option>
						<option value="Bachelors_Of_Fine_Arts">Bachelors Of Fine Arts</option>
						<option value="Bachelors_Of_Human_Kinetics">Bachelors Of Human Kinetics</option>
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
					</optgroup>
				</select>
	
				
				
				
			<!-- </div> -->
		</td>
	</tr>
<!-- ROW 4 AND 5: YEARLOGIC AND YEARINT -->
	<tr>
		<td>Graduating Year:</td>
	</tr>
	<tr>
		<!-- Radio buttons: less/equal/greater -->
		<td>
			<div align="center">
				<input type="radio" name="yearLogic" value="lessThan">Less Than
				<input type="radio" name="yearLogic" value="equal" checked>Equal
				<input type="radio" name="yearLogic" value="greaterThan">Greater Than
			</div>
		</td>
		<!-- field -->
		<td>
			<input type="text" name="yearInt" size=20>
		</td>
	</tr>

</table>
</fieldset>

<!-- FIELDSET 2: RESULT OPTIONS -->
<br>
<fieldset>
<legend>Result Options</legend>
	<table width="80%">
	
	
	<!-- ROW 1: RESULTS -->
	<tr>
		<td>
			<div align="left">
			<!-- ORDER BY -->
			Sort the results by 
			<select name="orderBy">
				<!-- Note: using the index number of the attribute. ex. cid=1, cfirstname=2, etc -->
				<option value="1">ID Number</option> 
				<option value="2">First Name</option>
				<option value="3" selected>Last Name</option>
				<option value="6">Graduating Year</option>
			</select>
			, in 
			<!-- DIRECTION -->
			<input type="radio" name="orderByDirection" value="asc" checked>Ascending
			<input type="radio" name="orderByDirection" value="desc">Descending
			 order, 
			
			<!-- NUMRESULTS -->
			limiting the page to 
				<select name="numResults">
					<option value=1>1</option>
					<option value=5>5</option>
					<option value=10>10</option>
					<option value=25 selected>25</option>
					<option value=50>50</option>
					<option value=100>100</option>
					<option value=9000000>All</option>
				</select>
				results.			
			</div>
		</td>
	</tr>	
	
	</table>
</fieldset>
<br>
<div align="center"><input class='myButton' type="submit" name="search" value="Search"></div>
</form>


</body>
</html>






<!-- 
//!@# By Daniel's Request, No Ability To Filter By Gender 
	<tr>
		<td>
			<div align="center">
				Male<input type="checkbox" name="isMale">
				Female<input type="checkbox" name="isFemale">
				Transgendered<input type="checkbox" name="isTrans">
				Other<input type="checkbox" name="isOther">
			</div>
		</td>
	</tr>
-->


<!-- Option List V1
				<select name="area">
					<option value="null" selected="selected">Any Area/Degree</option>
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
					<option value="None_Of_Above">None Of Above</option>
				</select>
				-->


<!--  Some Notes on CachedRowSetImpl class

import java.sql.rowset
//Default constructor
CachedRowSetImpl crs = new CachedRowSetImpl();
crs.populate(resultSet);

//getting
crs.getString(1)
crs.getstring("Name");
crs.getInt...

//adding
crs.moveToInsertRow()
...see updating here
crs.insertRow(); //to finalize

//updating
crs.updateInt(4, 15000)
crs.updateInt("ID",342544)
crs.updateRow(); //to finalize
 -->