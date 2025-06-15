package com.userPortal.dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.userPortal.model.Reminder;
import com.userPortal.util.DBUtil;

public class ReminderDAO {

    private Connection conn;

    public ReminderDAO() {
        conn = DBUtil.getConnection();
    }

    // Add new reminder
    public boolean addReminder(Reminder reminder) {
        String sql = "INSERT INTO reminders (user_email, title, description, reminder_time) " +
                    "VALUES (?, ?, ?, ?)"; // created_at is auto-populated
        
        try (
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, reminder.getUserEmail());
            stmt.setString(2, reminder.getTitle());
            stmt.setString(3, reminder.getDescription());
            stmt.setTimestamp(4, Timestamp.valueOf(reminder.getReminderTime()));
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error adding reminder", e);
        }
    }
    
    // Get all reminders for a specific user
    public List<Reminder> getReminderByUser(String userEmail) {
        List<Reminder> list = new ArrayList<>();
        String query = "SELECT * FROM reminders WHERE user_email = ? ORDER BY reminder_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userEmail);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reminder reminder = new Reminder();
                    reminder.setId(rs.getInt("id"));
                    reminder.setUserEmail(rs.getString("user_email"));
                    reminder.setTitle(rs.getString("title"));
                    reminder.setDescription(rs.getString("description"));
                    reminder.setReminderTime(rs.getTimestamp("reminder_time").toLocalDateTime());
                    reminder.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

                    list.add(reminder);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Delete reminder by ID
    public boolean deleteReminder(int id) {
        String query = "DELETE FROM reminders WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    
    public List<Reminder> getUpcomingReminders(String userEmail) {
        String sql = "SELECT * FROM reminders " +
                    "WHERE user_email = ? " +
                    "ORDER BY ABS(TIMESTAMPDIFF(MINUTE, reminder_time, NOW())) ASC, " +
                    "reminder_time ASC " +
                    "LIMIT 50";     
        try (
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            
            List<Reminder> reminders = new ArrayList<>();
            while (rs.next()) {
                Reminder reminder = new Reminder();
                reminder.setId(rs.getInt("id"));
                reminder.setUserEmail(rs.getString("user_email")); // Changed to match DB
                reminder.setTitle(rs.getString("title"));
                reminder.setDescription(rs.getString("description"));
                
                // Convert DATETIME to LocalDateTime
                reminder.setReminderTime(
                    rs.getTimestamp("reminder_time").toLocalDateTime()
                );
                
                // Handle possibly null created_at
                Timestamp createdAt = rs.getTimestamp("created_at");
                reminder.setCreatedAt(createdAt != null ? createdAt.toLocalDateTime() : LocalDateTime.now());
                
                reminders.add(reminder);
            }
            return reminders;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching reminders", e);
        }
    }
  
}
