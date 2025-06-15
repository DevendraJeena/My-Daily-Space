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
    <title>My Notes - My Daily Space</title>
    <link rel="stylesheet" href="css/notes.css">
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
</head>
<body>
<div class="container">
    <h2>My Notes</h2>

    <!-- Success or Error messages -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
        <c:remove var="error" scope="session" />
    </c:if>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="note?action=new" class="add-note-btn">
            <i class="fas fa-plus"></i> Add New Note
        </a>
        
        <div class="export-options">
            <!-- Export All Button -->
            <a href="ExportNotesPDFServlet" class="export-btn export-all">
                <i class="fas fa-file-pdf"></i> Export All
            </a>
            
            <!-- Export Selected Form -->
            <form id="exportForm" action="ExportNotesPDFServlet" method="get" style="display: inline;">
                <button type="submit" class="export-btn export-selected">
                    <i class="fas fa-file-archive"></i> Export Selected
                </button>
            </form>
        </div>
    </div>

    <!-- Notes List -->
    <section class="notes-section">
        <c:choose>
            <c:when test="${not empty notes and not empty notes[0]}">
                <!-- Select All Checkbox -->
                <div class="select-all-container">
                    <input type="checkbox" id="selectAll" class="select-all-checkbox">
                    <label for="selectAll">Select/Deselect All</label>
                </div>
                
                <div class="notes-grid">
                    <c:forEach var="note" items="${notes}">
                        <div class="note-card">
                            <!-- Checkbox for selection -->
                            <input type="checkbox" form="exportForm" name="selectedNotes" 
                                   value="${note.id}" class="note-checkbox">
                            
                            <h4>${note.title}</h4>
                            <p>${fn:substring(note.content, 0, 100)}${fn:length(note.content) > 100 ? '...' : ''}</p>
                            <small>Created on: ${note.createdAt}</small>

                            <div class="note-actions">
                                <!-- Single Note Export -->
                                <a href="ExportNotesPDFServlet?noteId=${note.id}" 
                                   class="export-btn note-export">
                                    <i class="fas fa-file-export"></i> Export
                                </a>
                                
                                <!-- Delete Form -->
                                <form action="note" method="post">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${note.id}">
                                    <button type="submit" class="delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <p>No notes yet. <a href="note?action=new">Add your first note</a></p>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- Back to Dashboard -->
    <a href="dashboard.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
    // Select/Deselect All functionality
    document.getElementById('selectAll').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.note-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });
    
    // Update Select All checkbox when individual checkboxes change
    const noteCheckboxes = document.querySelectorAll('.note-checkbox');
    noteCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const selectAll = document.getElementById('selectAll');
            const allChecked = Array.from(noteCheckboxes).every(cb => cb.checked);
            selectAll.checked = allChecked;
            selectAll.indeterminate = !allChecked && Array.from(noteCheckboxes).some(cb => cb.checked);
        });
    });
</script>


</body>
</html>