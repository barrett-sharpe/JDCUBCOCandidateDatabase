<%@page import="objects.DataAccessObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Help - Resume Linking</title>

<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<!-- CSS reference -->
<link href='${pageContext.request.contextPath}/css/Help/resumeHelp.css' rel='stylesheet' type='text/css'>

</head>

<body>

<!-- Back Button -->
<%
out.println("<div class='returnButton'><a href='help.jsp'>Return To Help</a></div>");
%>

<!-- DAO Image Collection -->
<%
DataAccessObject dao=new DataAccessObject();
%>

<!-- Title -->
<h2> Help! How do I get my resume into my profile? </h2>

<p>Our Resume Database doesn't actually hold onto your resume file itself. What we ask you to do is to provide us a weblink (or 'sharelink') to your resume. That implies that you have your resume accessable online, (for example, if it is stored in a cloud or online location).</p>
<p>We know that some people have not done this, or are just not sure how to do this in general. Don't worry! Below are some step-by-step tutorials to explain how to do this, so your resume can be viewed by Company's that click on your profile.</p>

<h3>The 3 Tutorials Cover:</h3>
<ul>
	<li id='g'><a href='#google'>Gmail.com with Google Drive</a></li>
	<li id='d'><a href='#dropbox'>Dropbox</a></li>
	<li id='o'><a href='#onedrive'>Hotmail.com, Live.com, or Outlook with OneDrive</a></li>
</ul>
<h3>You should choose the tutorial that corresponds with your email provider.</h3>
<p>(If you do not have a Dropbox account, or an email account with any of Gmail, Hotmail, Live, or Outlook, then go ahead an follow the Dropbox tutorial [as you won't have to create another email account]).</p>


<br>
<br>
<br>

<!-- Google Drive -->
<fieldset id='g'>
<a name='google'></a>
<legend>Google Drive</legend>
<ul>
<li>Go to <a href='https://mail.google.com' target='_blank'>https://mail.google.com</a> to sign in to Gmail (or search for 'Gmail' on Google).</li>

<li>If you have a gmail account, sign in to it. If not, create an account by clicking the 'Create Account' button below the login box.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=21" /></li>

<li>Once you have signed it, or created an account, you'll want to find and click on the Google Apps button (the one with the 9 little squares, seen at the top center of the below image. Next click on 'Drive' (the blue, yellow, and green triangle icon) to procede to Google Drive.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=22" /></li>

<li>A new tab will be opened up, and that will be Google drive.</li>

<li>Now we are going to upload your resume document to Google Drive</li>

<li>Acceptable formats for resumes include Word documents (.doc, .docx, etc...), PDF documents (.pdf), and Text formats (.rtf, .txt), to name a few. You can check if your resume format is compatable when uploading it.</li>

<li>Look for the big red button that says 'New' (Or on older versions, another button with the upload symbol, usually beside the 'Create' button.</li>

<li>Choose 'File Upload' or 'Upload files...' from the drop don menu.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=23" /></li>

<li>Your file explorer will show up ('Finder' on a Mac, and 'Windows Explorer' on a PC). Navigate to where you saved your resume on your computer, and click on your resume file. In the below example, I put my resume on my Desktop. Click 'Open' to begin uploading it to Google drive.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=24" /></li>

<li>After hitting open, you will notice a small window appear on the screen in Drive. This will show you that you resume is being uploaded. This may take some time, depending on your internet connection and the size of your resume.</li>

<li>When it is completed, you will see that the title of that small window will say 'Uploads Complete". This is pictured below.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=25" /></li>

<li>Notice that, on the right side of that window, is a link labeled 'Share'. Click on that, and it will display a window on the screen. In the top right corner of the screen there is a 'Get sherable link' button. Click that to get the shareable link (which is the link Companies will click on when they want to view your resume).</li>
<li>Make sure that the drop down box has the 'can view' option selected. See below image.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=26" /></li>

<li>Press the 'copy link' button to copy that big ugly link into your clipboard.</li>

<li>Then head back to the 'Edit Your Profile' area on the Resume Database, and in the text field that says 'Resume Hyperlink', right click on it and press 'Paste'. You should see that big link that you copied appear in that field.</li>

<li>Save your changes, and you're done!</li>
</ul>
</fieldset>


<!-- Dropbox -->
<fieldset id='d'>
<a name='dropbox'></a>
<legend>Dropbox</legend>
<ul>
<li>Go to <a href='https://www.dropbox.com/login' target='_blank'>https://www.dropbox.com/login</a> to log in to your Dropbox account (or search for 'Dropbox login' on Google).</li>

<li>If you have a Dropbox account, sign in to it. If you do not have one, click on the 'Create An Account' link, and follow the steps.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=11" /></li>

<li>Now we are going to upload your resume document to Dropbox.</li>

<li>Acceptable formats for resumes include Word documents (.doc, .docx, etc...), PDF documents (.pdf), and Text formats (.rtf, .txt), to name a few. You can check if your resume format is compatable after uploading it.</li>

<li>Right click on 'File', usually found on the left side of the screen. See highlighted 'file' in image below.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=12" /></li>

<li>Select 'Upload...' from the menu that appears. Next, press the 'Choose files' button.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=13" /></li>

<li>Your file explorer will show up ('Finder' on a Mac, and 'Windows Explorer' on a PC). Navigate to where you saved your resume on your computer, and click on your resume file. In the below example, I put my resume on my Desktop. Click 'Open' to begin uploading it to Dropbox.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=24" /></li>

<li>After hitting open, you will notice a small window appear on the screen in Dropbox. This will show you that you resume is being uploaded. This may take some time, depending on your internet connection and the size of your resume.</li>

<li>You will see a small link on the right side of that window that says 'Share': click on it.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=14" /></li>

<li>If Dropbox sends you out of that window before you get a chance to hit share, you can find your item in the main window, right click on it, and press the 'Share' option in the menu that comes up.</li>

<li><img src="${pageContext.request.contextPath}/resource?rid=15" /></li>

<li>The 'Link to File' field, in the window that comes up, has a large URL address inside it. Select it all, right click and then copy that URL link (which is the link that Companies will click on when they want to view your resume).</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=16" /></li>

<li>Then head back to the 'Edit Your Profile' area on the Resume Database, and in the text field that says 'Resume Hyperlink', right click on it and press 'Paste'. You should see that big link that you copied appear in that field.</li>

<li>Save your changes, and you're done!</li>

</ul>

</fieldset>

<!-- OneDrive -->
<fieldset id='o'>
<a name="onedrive"></a>
<legend>OneDrive</legend>
<ul>
<li>Go to <a href='http://www.live.com' target='_blank'>http://www.live.com</a> to sign into your Hotmail/Live/Outlook account (or search 'outlook login' on Google).</li>

<li>If you do not have a Hotmail/Live account, click on the 'Sign up now' link below the login box and follow those instructions.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=31" /></li>

<li>In the top left corner, click on the Outlook Apps button (the square-shaped button, made up of 9 little squares). Then click on the 'OneDrive' pannel (which has the cloud symbols).</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=32" /></li>

<li>A new tab will open, which will take you to OneDrive.</li>

<li>In the toolbar at the top, click on 'Upload', as seen in the below picture.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=33" /></li>

<li>When the menu drops down, select 'Files'.</li>

<li>Your file explorer will show up ('Finder' on a Mac, and 'Windows Explorer' on a PC). Navigate to where you saved your resume on your computer, and click on your resume file. In the below example, I put my resume on my Desktop. Click 'Open' to begin uploading it to OneDrive.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=24" /></li>


<li>After clicking open, your resume file will be uploaded. This may take some time, depending on your internet connection and the size of your resume.</li>

<li>OneDrive will let you know when it is done, and you will see your resume file in the main file window. See below.</li>
<li><img src="${pageContext.request.contextPath}/resource?rid=34" /></li>

<li>Right-click on your resume, and select 'Share' from the menu that appears.</li>

<li>You will see a window show up, pictured below. Select the 'Get Link' tab on the left side. Select the 'View Only' option from the 'Choose an option' dropdown menu. Next press the 'Create Link' button.</li>

<li><img src="${pageContext.request.contextPath}/resource?rid=35" /></li>

<li>Select the link that appears, and then copy it (right-click, copy).</li>

<li>Then head back to the 'Edit Your Profile' area on the Resume Database, and in the text field that says 'Resume Hyperlink', right click on it and press 'Paste'. You should see that big link that you copied appear in that field.</li>

<li>Save your changes, and you're done!</li>
</ul>
</fieldset>
</body>

</html>