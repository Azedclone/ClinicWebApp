package controller;

import dal.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

public class ManageService extends HttpServlet {

    private final ServiceDAO serviceDAO = new ServiceDAO();

    private final String createService(String serviceName, double price) {
        if (serviceDAO.isExist(serviceName)) {
            return "exist";
        }
        if (serviceDAO.createService(serviceName, price)) {
            return "success";
        }
        return "error";
    }

    private final String updateService(int serviceID, String serviceName, double price, int status) {
        Service oldService = serviceDAO.getService(serviceID);

        if (!oldService.getServiceName().equals(serviceName)) {
            if (serviceDAO.isExist(serviceName)) {
                return "exist";
            }

            if (serviceDAO.updateService(serviceID, serviceName, price, status)) {
                return "success";
            }
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
                String serviceName = request.getParameter("serviceName");
                String price = request.getParameter("price");
                response.getWriter().write(createService(serviceName, Double.parseDouble(price)));
                response.getWriter().close();
            }
            break;
            case "edit": {
                String serviceID = request.getParameter("serviceID");
                String serviceName = request.getParameter("serviceName");
                String price = request.getParameter("price");
                String status = request.getParameter("status");
                response.getWriter().write(updateService(Integer.parseInt(serviceID), serviceName, Double.parseDouble(price), Integer.parseInt(status)));
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
