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
    <title>Add New Note - My Daily Space</title>
    <link rel="stylesheet" href="css/notes.css">
</head>
<body>
<div class="container">
    <h2>Add New Note</h2>

    <!-- Success or Error messages -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
        <c:remove var="error" scope="session" />
    </c:if>

    <!-- Note Form -->
    <section class="form-section">
        <form action="note" method="post">
            <input type="hidden" name="action" value="add">

            <label for="title">Title:</label>
            <input type="text" name="title" id="title" required>

            <label for="content">Content:</label>
            <textarea name="content" id="content" rows="10" required></textarea>

            <div class="form-actions">
                <input type="submit" value="Save Note" class="btn-primary">
                <a href="note" class="btn-cancel">Cancel</a>
            </div>
        </form>
    </section>
</div>
</body>
</html>
