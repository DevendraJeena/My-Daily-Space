<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	String email = (String) session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
		return ;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/dashboard.css">
</head>
<body>
	<h1>Welcome, <%= email %>!</h1>
    <p>You have successfully logged in.</p>

    <a href="logout">Logout</a>
     <a href="change_password.jsp">Change Password</a> 
     <a href="update_profile.jsp">Update Profile</a>  
	
</body>
</html>