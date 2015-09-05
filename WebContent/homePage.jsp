<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JDCWest Candidate Database</title>
</head>
<body>
<h1><u>Welcome to the JDC West Candidate Database!</u></h1>

<h3> Please select one of the below options:</h3>

<a href="login.jsp">Login as Existing User</a><br>
<a href="AccountCreation/Candidate/createCandidateCredentials.jsp">Create and Login a New User</a><br>
<a href="Recovery/recoveryLogin.jsp">Reset Password</a>

<!-- !@# TEST mysql.jsp to connect to rhcloud mysql -->
<!-- %@ include file="mysql.jsp" % -->


</body>
</html>

<!-- 
JSP using MVC and JDBC
http://stackoverflow.com/questions/5003142/jsp-using-mvc-and-jdbc/5003701#5003701

Should eventually use a java.util.Properties file to connect to database instead of hardcoded user/password

PHPMyAdmin needs 2 versions of a user: host %, and host localhost. See user 'iamroot'

[DONE] Set up online repo.
 -->