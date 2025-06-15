
package com.userPortal.controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.userPortal.dao.NotesDAO;
import com.userPortal.model.Notes ;
import com.userPortal.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/ExportNotesPDFServlet")
public class ExportNotesPDFServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        NotesDAO notesDao = new NotesDAO();
        List<Notes> notesToExport;
        String filename;

        // Check for different export modes
        String noteId = request.getParameter("noteId");
        String[] selectedNotes = request.getParameterValues("selectedNotes");
        
        if (noteId != null) {
            // Single note export
            Notes singleNote = notesDao.getNoteById(Integer.parseInt(noteId), userEmail);
            notesToExport = (singleNote != null) ? List.of(singleNote) : Collections.emptyList();
            filename = "Note_" + noteId + ".pdf";
        } 
        else if (selectedNotes != null && selectedNotes.length > 0) {
            // Multiple selected notes export
            notesToExport = new ArrayList<>();
            for (String id : selectedNotes) {
                Notes note = notesDao.getNoteById(Integer.parseInt(id), userEmail);
                if (note != null) notesToExport.add(note);
            }
            filename = "Selected_Notes_" + System.currentTimeMillis() + ".pdf";
        }
        else {
            // All notes export (default)
            notesToExport = notesDao.getNotesByUser(userEmail);
            filename = "All_My_Notes.pdf";
        }
        
        
        try {
            Document document = new Document();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            document.open();
            
            // PDF styling
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLUE);
            Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.DARK_GRAY);
            Font contentFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            
            // Add title based on export type
            String titleText = notesToExport.size() == 1 ? "Your Note" : 
                             "Your Notes (" + notesToExport.size() + ")";
            document.add(new Paragraph(titleText, titleFont));
            document.add(Chunk.NEWLINE);

            if (notesToExport.isEmpty()) {
                document.add(new Paragraph("No notes found to export"));
            } else {
                for (Notes note : notesToExport) {
                    // Add note title with border
                    Paragraph noteTitle = new Paragraph(note.getTitle(), subTitleFont);
                    noteTitle.setSpacingAfter(5f);
                    document.add(noteTitle);
                    
                    // Add content
                    document.add(new Paragraph(note.getContent(), contentFont));
                    
                    // Add separator between notes
                    if (notesToExport.size() > 1) {
                        document.add(Chunk.NEWLINE);
                        document.add(new Paragraph("-----------------------------"));
                        document.add(Chunk.NEWLINE);
                    }
                }
            }
            
            document.close();
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
            
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            
        } catch (DocumentException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("notes.jsp?error=pdf_failed");
        }
    }
}