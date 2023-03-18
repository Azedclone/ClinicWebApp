package controller;

import dal.MedicineDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Medicine;

public class ManageMedicine extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    private final String createMedicine(String medicineName, String brand, String description) {
        if (medicineDAO.isExist(medicineName)) {
            return "exist";
        }
        if (medicineDAO.createMedicine(medicineName, brand, description)) {
            return "success";
        }
        return "error";
    }

    private final String updateMedicine(int medicineID, String medicineName, String brand, String description) {
        Medicine oldMedicine = medicineDAO.getMedicine(medicineID);

        if (!oldMedicine.getMedicineName().equals(medicineName)) {
            if (medicineDAO.isExist(medicineName)) {
                return "exist";
            }
        }
        if (medicineDAO.updateMedicine(medicineID, medicineName, brand, description)) {
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
                String medicineName = request.getParameter("medicineName");
                String brand = request.getParameter("brand");
                String description = request.getParameter("description");
                response.getWriter().write(createMedicine(medicineName, brand, description));
                response.getWriter().close();
            }
            break;
            case "edit": {
                String medicineID = request.getParameter("medicineID");
                String medicineName = request.getParameter("medicineName");
                String brand = request.getParameter("brand");
                String description = request.getParameter("description");
                response.getWriter().write(updateMedicine(Integer.parseInt(medicineID), medicineName, brand, description));
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
