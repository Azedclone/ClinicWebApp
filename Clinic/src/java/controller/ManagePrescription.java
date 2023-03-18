package controller;

import dal.PrescriptionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class ManagePrescription extends HttpServlet {

    private final PrescriptionDAO prescriptionDAO = new PrescriptionDAO();

    private final String createPrescription(int patientID, String[] medicines, String instruction, int doctorID) {
        String status = "error";
        for (String medicine : medicines) {
            if (prescriptionDAO.createPrescription(patientID, Integer.parseInt(medicine), instruction, doctorID)) {
                status = "success";
            } else {
                status = "error";
            }
        }

        return status;
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
                String patientID = request.getParameter("patientID");
                String[] medicines = request.getParameterValues("medicine");
                String instruction = request.getParameter("instruction");
                response.getWriter().write(createPrescription(Integer.parseInt(patientID), medicines, instruction, currentAccount.getAccountID()));
                response.getWriter().close();
            }
            break;
            case "edit": {
                String prescriptionID = request.getParameter("prescriptionID");
                String instruction = request.getParameter("instruction");
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
