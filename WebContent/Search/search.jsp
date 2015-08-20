<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
</head>
<body>
	<h3>Search For A Candidate</h3>

<!-- Search Box -->
<form name="searchForm" method=post action="searchResult.jsp">
<table width="80%">
	<tr>
		<td><div align="center">Search:<br><input type="text" name="queryString" size=8></div></td>
	</tr>
	
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
	<tr>
		<td>
			<div align="center">
				<select name="area">
					<option value="null" selected="selected"></option>
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
			</div>
		</td>
	</tr>
<!-- 
Date Range Query (a later feature, time permitting)
	<tr>
		<td><div align="center"><input type="datetime-local" name="begining"></div></td>
		<td><div align="center"><input type="datetime-local" name="end"></div></td>
	</tr>
-->
	<tr>
		<td><div align="center"><input type="submit" name="search" value="Search!"></div></td>
	</tr>
</table>

</form>


</body>
</html>


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