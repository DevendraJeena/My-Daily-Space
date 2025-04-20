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
    <title>Reminders - My Daily Space</title>
    <link rel="stylesheet" href="css/reminders.css">
</head>
<body>
<div class="container">
    <h2>My Reminders</h2>

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

            <input type="submit" value="Add Reminder">
        </form>
    </section>

    <hr>

    <!-- Display Reminders -->
    <section class="reminders-section">
        <h3>Your Upcoming Reminders</h3>

        <c:choose>
            <c:when test="${not empty reminders}">
                <c:forEach var="rem" items="${reminders}">
                    <div class="reminder-card">
                        <h4>${rem.title}</h4>
                        <p>${rem.description}</p>
                        <small>
                            Reminder Time: ${rem.formattedReminderTime}
                        </small><br>
                        <small>
                            Created At: ${rem.formattedCreatedAt}
                        </small>

                        <form action="reminder" method="post" style="margin-top: 10px;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${rem.id}">
                            <button type="submit" class="delete-btn">Delete</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No reminders yet. Add one above!</p>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- Navigation -->
    <p style="margin-top: 20px;">
        <a href="dashboard.jsp">Back to Dashboard</a>
    </p>
</div>
</body>
</html>
