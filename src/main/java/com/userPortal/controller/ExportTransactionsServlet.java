package com.userPortal.controller;

import com.userPortal.dao.TransactionDAO;
import com.userPortal.model.Transaction;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ExportTransactionsServlet")
public class ExportTransactionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get user email from session
        String userEmail = (String) request.getSession().getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get transactions from database
        TransactionDAO transactionDAO = new TransactionDAO();
        List<Transaction> transactions;
        try {
            // Get all transactions (or apply filters if needed)
            transactions = transactionDAO.getTransactions(userEmail, null, null, null, null, null);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving transactions", e);
        }

        // Create Excel workbook
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Transactions");

            // Create header style
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // Create date style
            CellStyle dateStyle = workbook.createCellStyle();
            CreationHelper createHelper = workbook.getCreationHelper();
            dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-mm-dd"));

            // Create currency style
            CellStyle rupeeStyle = workbook.createCellStyle();
            rupeeStyle.setDataFormat((short)8); // Built-in currency format
            // OR create custom format:
            rupeeStyle.setDataFormat(workbook.createDataFormat().getFormat("₹#,##0.00"));


            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] headers = { "Title", "Amount", "Type", "Category", "Date", "Notes"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Fill data rows
            int rowNum = 1;
            for (Transaction transaction : transactions) {
                Row row = sheet.createRow(rowNum++);

               
                // Title
                row.createCell(0).setCellValue(transaction.getTitle());

                // Amount (with currency formatting)
                Cell amountCell = row.createCell(1);
                amountCell.setCellValue(transaction.getAmount().doubleValue());
                amountCell.setCellStyle(rupeeStyle);

                // Type
                row.createCell(2).setCellValue(transaction.getType());

                // Category
                row.createCell(3).setCellValue(transaction.getCategory());

                // Date (with date formatting)
                Cell dateCell = row.createCell(4);
                dateCell.setCellValue(transaction.getDate());
                dateCell.setCellStyle(dateStyle);

                // Notes
                row.createCell(5).setCellValue(transaction.getNotes() != null ? transaction.getNotes() : "");
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Set response headers
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=transactions.xlsx");

            // Write workbook to response
            workbook.write(response.getOutputStream());
        }
    }
}