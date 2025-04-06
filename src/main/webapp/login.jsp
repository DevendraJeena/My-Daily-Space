<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet" href="css/register.css">
</head>
<body>

	<div class="container" >
	
		<h2 style="text-align:center;">Login</h2>
			
		<form action="login" method="post">
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" name="password" placeholder="Password" required>
			
			<input type="submit" value="login" >
		</form>
	
		<%
			String error = request.getParameter("error");
			if("true".equals(error)){		
		%>
			<p style = "color:red; text-align:center;">Invalid email or password</p>
					
		<% 
			}
		%>
		
		<p style="text-align:center;">
			Don't have an account? <a href="register.jsp">Register</a>
		</p>
	
	
	</div>

</body>
</html>