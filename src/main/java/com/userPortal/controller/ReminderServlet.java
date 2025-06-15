package com.userPortal.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.userPortal.dao.ReminderDAO;
import com.userPortal.model.Reminder;

@WebServlet("/reminder")
public class ReminderServlet extends HttpServlet {

    private ReminderDAO dao;
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private final DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("MMM dd, hh:mm a");

    @Override
    public void init() throws ServletException {
        dao = new ReminderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String timeString = request.getParameter("reminder_time");

                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                LocalDateTime reminderTime = LocalDateTime.parse(timeString, inputFormatter);

                Reminder reminder = new Reminder(userEmail, title, description, reminderTime);
                reminder.setCreatedAt(LocalDateTime.now());

                boolean success = dao.addReminder(reminder);
                if (success) {
                    session.setAttribute("message", "Reminder added successfully!");
                } else {
                    session.setAttribute("error", "Failed to add reminder.");
                }
                
                response.sendRedirect("reminder");
                return;
                
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = dao.deleteReminder(id);
                if (deleted) {
                    session.setAttribute("message", "Reminder deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete reminder.");
                }
                
                response.sendRedirect("reminder");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect("reminders.jsp");
            return;
        }
    }

    @Override
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
            request.getRequestDispatcher("addReminder.jsp").forward(request, response);
            return;
        }

        // Get and sort reminders by proximity to current time
        List<Reminder> reminders = dao.getUpcomingReminders(userEmail);
        
        // Format dates for display and calculate time remaining
        LocalDateTime now = LocalDateTime.now();
        for (Reminder reminder : reminders) {
            try {
                // Null-safe formatting
                if (reminder.getReminderTime() != null) {
                    reminder.setFormattedReminderTime(
                        reminder.getReminderTime().format(displayFormatter)
                    );
                    
                    // Calculate time remaining and set status
                    long minutesRemaining = Duration.between(now, reminder.getReminderTime()).toMinutes();
                    
                    if (minutesRemaining <= 0) {
                        // PAST reminder
                        reminder.setTimeRemaining("Past due!");
                        reminder.setTimeStatus("past");
                    } else if (minutesRemaining <= 30) {
                        // URGENT (0-30 mins)
                        reminder.setTimeRemaining("Due soon! (" + minutesRemaining + "m)");
                        reminder.setTimeStatus("urgent");
                    } else if (minutesRemaining <= 1440) {
                        // UPCOMING (within 24 hours)
                        long hours = minutesRemaining / 60;
                        long minutes = minutesRemaining % 60;
                        reminder.setTimeRemaining("Due in " + hours + "h" + (minutes > 0 ? " " + minutes + "m" : ""));
                        reminder.setTimeStatus("soon");
                    } else {
                        // FUTURE (more than 24 hours)
                        long days = minutesRemaining / 1440;
                        reminder.setTimeRemaining(days + " day" + (days > 1 ? "s" : "") + " remaining");
                        reminder.setTimeStatus("future");
                    }
                } else {
                    reminder.setFormattedReminderTime("No time set");
                    reminder.setTimeRemaining("No time set");
                    reminder.setTimeStatus("past");
                }
                
                if (reminder.getCreatedAt() != null) {
                    reminder.setFormattedCreatedAt(
                        reminder.getCreatedAt().format(formatter)
                    );
                } else {
                    reminder.setFormattedCreatedAt("Unknown creation time");
                }
                
            } catch (Exception e) {
                System.err.println("Error processing reminder ID " + reminder.getId() + ": " + e.getMessage());
                reminder.setFormattedReminderTime("Error");
                reminder.setTimeRemaining("Error");
                reminder.setTimeStatus("past");
            }
        }

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

        request.setAttribute("reminders", reminders);
        request.getRequestDispatcher("reminders.jsp").forward(request, response);
    }
}