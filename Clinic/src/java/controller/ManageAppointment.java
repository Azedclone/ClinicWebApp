package controller;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Account;

public class ManageAppointment extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    private final String createAppointment(int patientID, Date bookedDate, int slotID, String sympton, String message) {
        // Check repeat slot and day
        if (appointmentDAO.isExist(patientID, bookedDate, slotID)) {
            return "duplicate";
        }
        Account doctor = appointmentDAO.doctorAvailable(bookedDate, slotID);
        if (doctor == null) {
            return "n/a";
        }
        if (appointmentDAO.createAppointment(patientID, bookedDate, slotID, doctor.getAccountID(), sympton, message)) {
            return "success";
        }
        return "error";
    }

    private String updateAppointment(int appointmentID, String sympton, String message) {
        if (appointmentDAO.updateAppointment(appointmentID, sympton, message)) {
            return "success";
        }

        return "error";
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String type = request.getParameter("type");

        switch (type) {
            case "create": {
                HttpSession session = request.getSession();
                Account currentAccount = (Account) session.getAttribute("currentAccount");
                String bookedDate = request.getParameter("bookedDate");
                String slotID = request.getParameter("slotID");
                String sympton = request.getParameter("sympton");
                String message = request.getParameter("message");
                response.getWriter().write(createAppointment(
                        currentAccount.getAccountID(),
                        Date.valueOf(bookedDate),
                        Integer.parseInt(slotID),
                        sympton,
                        message)
                );
                response.getWriter().close();
            }
            break;
            case "edit": {
                String appointmentID = request.getParameter("appointmentID");
                String sympton = request.getParameter("sympton");
                String message = request.getParameter("message");
                response.getWriter().write(updateAppointment(Integer.parseInt(appointmentID), sympton, message));
                response.getWriter().close();
            }
            break;
            default:
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
