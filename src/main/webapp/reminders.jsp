<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
<body>
<div class="container">
    <h2>My Reminders</h2>

    <!-- Message display -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
        <c:remove var="error" scope="session"/>
    </c:if>

    <!-- Add Reminder Button -->
    <a href="reminder?action=new" class="add-reminder-btn">
        <i class="fas fa-plus"></i> Add New Reminder
    </a>

    <!-- Display Reminders -->
    <section class="reminders-section">
        <c:choose>
            <c:when test="${not empty reminders and not empty reminders[0]}">
                <div class="reminders-grid">
                    <c:forEach var="rem" items="${reminders}">
                        <div class="reminder-card ${rem.timeStatus}">
                            <h4>${rem.title}</h4>
                            <p>${rem.description}</p>
                            <div class="reminder-time">
                                <i class="fas fa-clock"></i>
                                <span>${rem.formattedReminderTime}</span>
                                <span class="time-badge ${rem.timeStatus}">
                                    ${rem.timeRemaining}
                                </span>
                            </div>
                            <small class="created-at">
                                <i class="fas fa-calendar-plus"></i> ${rem.formattedCreatedAt}
                            </small>

                            <form action="reminder" method="post" class="reminder-actions">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${rem.id}">
                                <button type="submit" class="delete-btn">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <p>No reminders yet. <a href="reminder?action=new">Add your first reminder</a></p>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- Navigation -->
    <p class="back-link">
        <a href="dashboard.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </p>
</div>

<script>
    // Auto-refresh page every 5 minutes to update reminder statuses
    setTimeout(function() {
        window.location.reload();
    }, 300000); // 5 minutes
</script>
</body>
</html>