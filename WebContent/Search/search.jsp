<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
</head>
<body>
	<!-- <h3>Search For A Candidate</h3>-->

<!-- Search Form  //!@# check if 'get' or 'post' needed-->
<form name="searchForm" method=get action="searchResult.jsp">
<fieldset>
<legend>Candidate Search</legend>
<table width="80%">
<!-- ROW 1: QUERYSTRING -->
	<tr>
			<td>Name:</td>
			<td><input type="text" name="queryString" size=40></td>
	</tr>
<!-- ROW 2: QUERYNUM -->
	<tr>
			<td>ID or Phone Number</td>
			<td><input type="text" name="queryNum" size=40></td>
	</tr>
<!-- ROW 3: Area -->
	<tr>
		<td>Area/Degree:</td>
		<td>
			<!-- <div align="center"> -->
			
			
				
				<select name="area">
					<optgroup label="All or None">
						<option value="null" selected="selected">Any Area/Degree</option>
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

<!-- ROW 6: RESULTS -->
	<tr>
		<td>
		</td>
		
		<td>
			<div align="right">
			<!-- ORDER BY -->
			Order Results By 
			<select name="orderBy">
				<option value="cid">ID Number</option>
				<option value="cfirstname">First Name</option>
				<option value="clastname" selected>Last Name</option>
			</select>
			<br>
			<input type="radio" name="orderByDirection" value="asc" checked>Ascending
			<input type="radio" name="orderByDirection" value="dec">Descending
			<br>
			<!-- LIMIT Number -->
			Limit Results To 
				<select name="numResults">
					<option value=1>1</option>
					<option value=5>5</option>
					<option value=10 selected>10</option>
					<option value=25>25</option>
					<option value=50>50</option>
					<option value=100>100</option>
				</select>			
			</div>
		</td>
	</tr>	
	
<!-- ROW 7: SUMBIT -->
	<tr>
		<td></td>
		<td><div align="right"><input type="submit" name="search" value="Search"></div></td>
	</tr>
</table>



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
<!-- 
Date Range Query (a later feature, time permitting)
	<tr>
		<td><div align="center"><input type="datetime-local" name="begining"></div></td>
		<td><div align="center"><input type="datetime-local" name="end"></div></td>
	</tr>
-->

</fieldset>
</form>


</body>
</html>


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