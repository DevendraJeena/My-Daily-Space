package com.userPortal.model;

import java.time.LocalDateTime;

public class Reminder {

    private int id;
    private String userEmail;
    private String title;
    private String description;
    private LocalDateTime reminderTime;
    private LocalDateTime createdAt;
    private String formattedReminderTime;  // New field for formatted reminder time
    private String formattedCreatedAt;     // New field for formatted created time

    // Default constructor
    public Reminder() {}

    // Constructor for retrieving reminders from DB
    public Reminder(int id, String userEmail, String title, String description, LocalDateTime reminderTime, LocalDateTime createdAt) {
        this.id = id;
        this.userEmail = userEmail;
        this.title = title;
        this.description = description;
        this.reminderTime = reminderTime;
        this.createdAt = createdAt;
    }

    // Constructor for creating a new reminder (without ID & createdAt)
    public Reminder(String userEmail, String title, String description, LocalDateTime reminderTime) {
        this.userEmail = userEmail;
        this.title = title;
        this.description = description;
        this.reminderTime = reminderTime;
    }

    // Getters and Setters for original fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getReminderTime() {
        return reminderTime;
    }

    public void setReminderTime(LocalDateTime reminderTime) {
        this.reminderTime = reminderTime;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Getters and Setters for formatted date fields
    public String getFormattedReminderTime() {
        return formattedReminderTime;
    }

    public void setFormattedReminderTime(String formattedReminderTime) {
        this.formattedReminderTime = formattedReminderTime;
    }

    public String getFormattedCreatedAt() {
        return formattedCreatedAt;
    }

    public void setFormattedCreatedAt(String formattedCreatedAt) {
        this.formattedCreatedAt = formattedCreatedAt;
    }
}
