<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <title>My Notes - My Daily Space</title>
    <link rel="stylesheet" href="css/notes.css">
</head>
<body>

<div class="container">
    <h2>My Notes</h2>

    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- Add Note Form -->
    <form action="note" method="post">
        <input type="hidden" name="action" value="add">

        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required>

        <label for="content">Content:</label>
        <textarea name="content" id="content" rows="5" required></textarea>

        <input type="submit" value="Add Note">
    </form>

    <hr>

    <!-- Notes List -->
    <div class="notes-list">
        <h3>Your Saved Notes</h3>

        <c:choose>
            <c:when test="${not empty notes}">
                <c:forEach var="note" items="${notes}">
                    <div class="note-card">
                        <h4>${note.title}</h4>
                        <p>${note.content}</p>
                        <small>Created on: ${note.createdAt}</small>

                        <div class="note-card-footer">
                            <form action="note" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${note.id}">
                                <input type="submit" value="Delete" class="delete-btn">
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No notes yet. Start by adding one above!</p>
            </c:otherwise>
        </c:choose>
    </div>

    <p style="margin-top: 20px;"><a href="dashboard.jsp">Back to Dashboard</a></p>
</div>
</body>
</html>
