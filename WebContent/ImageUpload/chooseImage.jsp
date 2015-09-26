<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/ImageUpload/chooseImage.css' rel='stylesheet' type='text/css'>

<title>Upload Profile Image</title>

</head>
<body>

<!-- Authorized Page.-->
<%@ include file="../auth.jsp"%>


<!-- Session -->
<%
	// Grab session object from request.
	session = request.getSession();
	//Get Session info
	String user = (String) session.getAttribute("authenticatedUser");
	String id = (String) session.getAttribute("uid");
	boolean isCompany = Boolean.parseBoolean(String.valueOf(session.getAttribute("isCompany")));
	
	//Set Session Info
	session.setAttribute("isCompany", isCompany); //isCompany
	session.setAttribute("uid", id);				//uid (either cid or coid)
	session.setAttribute("authenticatedUser", user);
%>

<h2>Upload A Profile Image:</h2>

<p>Please click the "Browse" button to select an image, and then click "Upload" at the bottom.</p>

<p>Please Note:</p>
<ul>
	<li id='red'>The image should be no larger than 16MB.</li>
	<li id='red'>The image is recommended to be in a '.jpg' or '.jpeg' file format.</li>
</ul>

<form id="imageForm" method="POST" enctype="multipart/form-data" action="uploadImage.jsp">
	<input type="file" name="picture" value="Browse"><br/>
	<br/>
	<input type="button" class='myButton' value="Upload">
</form> 



</body>
</html>