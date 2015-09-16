<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Login Page</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/login.css' rel='stylesheet' type='text/css'>

</head>

<body>
<h2>Please Enter Your Login</h2>

<!-- Print Prior Error Login Message If Needed -->
<%
	// Print prior Error Login message, if needed
	if (session.getAttribute("loginMessage") != null)
	out.println("<h5 class='error'>" + session.getAttribute("loginMessage").toString() + "</h5>");
%>

<!--  Form (note that ACTION $pageContext works)-->
<form name="MyForm" method=post action="${pageContext.servletContext.contextPath}/validateLogin.jsp"> 
	
	<table width="80%">
		<tr>
			<td>
				<div class='fieldName'>
				Username:
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='textInput'>
					<input type="text" name="username" value="">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='fieldName'>
				Password:
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='textInput'>
					<input type="password" name="password" value="">
				</div>
			</td>
		</tr>
	</table>
	
	<!-- Submit -->
	<br>
	<input class='myButton' type="submit" name="Submit" value="Log In">

</form>

</body>
</html>

<!-- Old Table

<table width="40%">
		<tr>
			<td>
				<div class='fieldName'>
				Username:
				</div>
			</td>
			<td>
				<div class='textInput'>
					<input type="text" name="username" value="">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='fieldName'>
				Password:
				</div>
			</td>
			<td>
				<div class='textInput'>
					<input type="password" name="password" value="">
				</div>
			</td>
		</tr>
	</table>

 -->