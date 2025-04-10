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
<title>My Daily Space - Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/dashboard.css">
</head>
<body>
	 <div id="dashboard-container">
        <header id="dashboard-header">
            <h2>Welcome, <%= email %>!</h2>
            <p id="last-login">Last login: <!-- You can add last login time dynamically later --></p>
        </header>

        <nav id="dashboard-nav">
            <a href="dashboard.jsp" id="nav-home">Home</a>
            <a href="change_password.jsp" id="nav-change-password">Change Password</a>
            <a href="update_profile.jsp" id="nav-update-profile">Update Profile</a>
            <a href="logout" id="nav-logout">Logout</a>
        </nav>

        <section id="dashboard-features">
            <div class="feature-box" id="notes-section">
                <a href="notes.jsp">📝 My Notes</a>
            </div>
            <div class="feature-box" id="reminders-section">
                <a href="reminders.jsp">⏰ Reminders</a>
            </div>
            <div class="feature-box" id="bookmarks-section">
                <a href="bookmarks.jsp">🔖 Bookmarks</a>
            </div>
            <div class="feature-box" id="goals-section">
                <a href="goals.jsp">🎯 Goal Tracker</a>
            </div>
            <div class="feature-box" id="upload-section">
                <a href="upload_file.jsp">📁 Upload Files</a>
            </div>
            <div class="feature-box" id="mood-section">
                <a href="mood_tracker.jsp">😊 Mood Tracker</a>
            </div>
            <div class="feature-box" id="feedback-section">
                <a href="feedback.jsp">💬 Feedback / Support</a>
            </div>
        </section>
    </div>
</body>
</html>