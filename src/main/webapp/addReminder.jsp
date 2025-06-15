<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Reminder - My Daily Space</title>
    <link rel="stylesheet" href="css/reminders.css">
</head>
<body>
<div class="container">
    <h2>Add New Reminder</h2>

    <!-- Message display -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- Reminder Form -->
    <section class="form-section">
        <form action="reminder" method="post">
            <input type="hidden" name="action" value="add">

            <label for="title">Title:</label><br>
            <input type="text" name="title" id="title" required><br><br>

            <label for="description">Description:</label><br>
            <textarea name="description" id="description" rows="4" required></textarea><br><br>

            <label for="reminder_time">Reminder Time:</label><br>
            <input type="datetime-local" name="reminder_time" id="reminder_time" required><br><br>

            <div class="form-actions">
                <input type="submit" value="Save Reminder" class="btn-primary">
                <a href="reminder" class="btn-cancel">Cancel</a>
            </div>
        </form>
    </section>
</div>
</body>
</html>