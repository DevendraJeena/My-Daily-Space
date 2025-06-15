<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Daily Space - Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/dashboard.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <header class="dashboard-header">
        <div class="welcome-box">
            <h2>Welcome, <%= email %>!</h2>
            <p id="last-login" class="text-muted">Last login: </p>
        </div>
        <nav class="header-nav">
            <a href="change_password.jsp" class="btn btn-outline-light">Change Password</a>
            <a href="update_profile.jsp" class="btn btn-outline-light">Update Profile</a>
            <a href="logout" class="btn btn-danger">Logout</a>
        </nav>
    </header>

    <div class="dashboard-container">
        <section id="dashboard-features" class="dashboard-grid">
  
            <div class="feature-card">
              <a href="note" class="card-body">
                <h3>📝 My Notes</h3>
                <p>Create and manage your personal notes</p>
              </a>
            </div>

            <div class="feature-card">
              <a href="reminder" class="card-body">
                <h3>⏰ Reminders</h3>
                <p>Set important reminders</p>
              </a>
            </div>

            <div class="feature-card">
              <a href="transactions" class="card-body">
                <h3>💰 Expense Manager</h3>
                <p>Track your spending</p>
              </a>
            </div>

            <div class="feature-card">
              <a href="goals?action=list" class="card-body">
                <h3>🎯 Goal Tracker</h3>
                <p>Manage your goals</p>
              </a>
            </div>

            <div class="feature-card">
              <a href="file-upload.jsp" class="card-body">
                <h3>📁 File Upload</h3>
                <p>Store your files safely</p>
              </a>
            </div>

            <div class="feature-card">
              <a href="todo" class="card-body">
                <h3>✅ To-Do List</h3>
                <p>Manage daily tasks</p>
              </a>
            </div>

        </section>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('last-login').textContent = 
          'Last login: ' + new Date().toLocaleString();
    </script>
    
	
</body>
</html>
