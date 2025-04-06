<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>
<link rel="stylesheet" href="css/register.css">
</head>
<body>

<div class="container">
	<h2 style="text-align:center;">Register Here</h2>
	 <form action="register" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Register">
        </form>      
        
        <p style="text-align:center;">
			 <a href="index.jsp">Back</a>
		</p>
</div>

</body>
</html>