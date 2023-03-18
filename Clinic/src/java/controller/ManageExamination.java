package controller;

import dal.ExaminationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class ManageExamination extends HttpServlet {

    private final ExaminationDAO examinationDAO = new ExaminationDAO();

    private final String createExamination(int patientID, String[] servicesID, int doctorID) {
        String status = "error";
        for (String serviceID : servicesID) {
            if (examinationDAO.createExamination(patientID, Integer.parseInt(serviceID), doctorID)) {
                status = "success";
            } else {
                status = "error";
            }
        }
        return status;
    }

    private final String updateExamination(int examinationID, int status, String result) {
        if (examinationDAO.editExamination(examinationID, status, result)) {
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

        if (type.equals("create")) {
            HttpSession session = request.getSession();
            Account currentAccount = (Account) session.getAttribute("currentAccount");
            String patientID = request.getParameter("patientID");
            String[] services = request.getParameterValues("service");
            response.getWriter().write(createExamination(Integer.parseInt(patientID), services, currentAccount.getAccountID()));
            response.getWriter().close();
        } else if (type.equals("edit")) {
            String examinationID = request.getParameter("examinationID");
            String status = request.getParameter("status");
            String result = request.getParameter("result");
            response.getWriter().write(updateExamination(Integer.parseInt(examinationID), Integer.parseInt(status), result));
            response.getWriter().close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
