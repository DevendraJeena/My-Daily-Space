<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>My To-Do List</title>
    <link rel="stylesheet" href="css/todo.css">
</head>
<body>
<div class="container">
    <h2>My To-Do List</h2>

    <c:if test="${not empty sessionScope.message}">
        <div class="alert success">${sessionScope.message}</div>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert error">${sessionScope.error}</div>
    </c:if>

    <!-- Remove the message from session -->
    <c:remove var="message" scope="session"/>
    <c:remove var="error" scope="session"/>

    <form action="todo" method="post" class="todo-form">
        <input type="hidden" name="action" value="add">
        <input type="text" name="task" placeholder="Enter task..." required>
        <select name="status">
            <option value="Pending">Pending</option>
            <option value="In Progress">In Progress</option>
            <option value="Completed">Completed</option>
        </select>
        
        <button type="submit">Add Task</button>
        <button onclick="window.location.href='dashboard.jsp'" class="btn btn-outline-secondary me-2">Home
	    </button>
    </form>

    <table class="todo-table">
        <thead>
        <tr>
            <th>#</th>
            <th>Task</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty todos}">
                <c:forEach var="t" items="${todos}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${t.task}</td>
                        <td>${t.status}</td>
                        <td>${t.createdAt}</td>
                        <td>
                            <form action="todo" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${t.id}">
                                <select name="status">
                                    <option value="Pending" ${t.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="In Progress" ${t.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                    <option value="Completed" ${t.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                </select>
                                <button type="submit">Update</button>
                            </form>

                            <form action="todo" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${t.id}">
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="5">No tasks found.</td></tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
</body>
</html>
