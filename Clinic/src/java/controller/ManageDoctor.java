package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import org.apache.commons.codec.digest.DigestUtils;

public class ManageDoctor extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    private final String createDoctor(String username, String password) {
        // Check duplicate
        if (accountDAO.isExist(username)) {
            return "exist";
        } else {
            if (accountDAO.register(username, password, 1)) {
                return "success";
            }
            return "error";
        }
    }

    private final String editDoctor(String username, String accountName, String email, String phone, int gender, String address, Date dob) {
        if (accountDAO.updateAccount(username, accountName, email, phone, gender, address, dob)) {
            return "success";
        } else {
            return "error";
        }
    }

    private final String deleteDoctor(String username) {
        if (accountDAO.deleteAccount(username)) {
            return "success";
        } else {
            return "error";
        }
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
                String username = request.getParameter("username");
                String password = DigestUtils.md5Hex(request.getParameter("password")).toUpperCase();
                response.getWriter().write(createDoctor(username, password));
                response.getWriter().close();
            }
            break;
            case "edit": {
                String username = request.getParameter("username");
                String accountName = request.getParameter("accountName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                Date dob = Date.valueOf(request.getParameter("dob"));
                response.getWriter().write(editDoctor(username, accountName, email, phone, Integer.parseInt(gender), address, dob));
                response.getWriter().close();
            }
            break;
            case "delete": {
                String username = request.getParameter("username");
                response.getWriter().write(deleteDoctor(username));
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
