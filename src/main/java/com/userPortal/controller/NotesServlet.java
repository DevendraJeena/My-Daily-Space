package com.userPortal.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.userPortal.dao.NotesDAO;
import com.userPortal.model.Notes;

@WebServlet("/note")
public class NotesServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        NotesDAO dao = new NotesDAO();

        try {
            if ("add".equalsIgnoreCase(action)) {
                String title = request.getParameter("title");
                String content = request.getParameter("content");

                Notes note = new Notes();
                note.setUserEmail(userEmail);
                note.setTitle(title);
                note.setContent(content);
                note.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                boolean success = dao.addNote(note);
                if (success) {
                    session.setAttribute("message", "Note added successfully!");
                } else {
                    session.setAttribute("error", "Failed to add note.");
                }
                
                // Refresh notes list
                List<Notes> updatedNotes = dao.getNotesByUser(userEmail);
                session.setAttribute("notes", updatedNotes);
                
                response.sendRedirect("notes.jsp");
                return;

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = dao.deleteNote(id);
                if (deleted) {
                    session.setAttribute("message", "Note deleted successfully.");
                } else {
                    session.setAttribute("error", "Failed to delete note.");
                }
                
                // Refresh notes list
                List<Notes> updatedNotes = dao.getNotesByUser(userEmail);
                session.setAttribute("notes", updatedNotes);
                
                response.sendRedirect("notes.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect("notes.jsp");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Check if it's a request for the add form
        String action = request.getParameter("action");
        if ("new".equals(action)) {
            request.getRequestDispatcher("addNote.jsp").forward(request, response);
            return;
        }

        // Default behavior - show notes list
        NotesDAO dao = new NotesDAO();
        List<Notes> notes = dao.getNotesByUser(userEmail);

        // Pass session messages to request and remove from session
        String msg = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");

        if (msg != null) {
            request.setAttribute("message", msg);
            session.removeAttribute("message");
        }

        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        request.setAttribute("notes", notes);
        request.getRequestDispatcher("notes.jsp").forward(request, response);
    }
}