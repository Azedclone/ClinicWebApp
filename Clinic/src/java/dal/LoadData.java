package dal;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;

public class LoadData extends HttpServlet {

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
        String type = request.getParameter("type");

        if (type != null) {
            switch (type) {
                case "accounts": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> accounts = accountDAO.getAccounts();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(accounts));
                    response.getWriter().close();
                }
                break;
                case "doctors": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> doctors = accountDAO.getDoctors();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(doctors));
                    response.getWriter().close();
                }
                break;
                case "patients": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> patients = accountDAO.getPatients();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(patients));
                    response.getWriter().close();
                }
                break;
                case "categories": {
                    BlogDAO blogDAO = new BlogDAO();
                    List<Category> categories = blogDAO.getCategories();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(categories));
                    response.getWriter().close();
                }
                break;
                case "blogs": {
                    BlogDAO blogDAO = new BlogDAO();
                    List<Blog> blogs = blogDAO.getBlogs();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(blogs));
                    response.getWriter().close();
                }
                break;
                case "services": {
                    ServiceDAO serviceDAO = new ServiceDAO();
                    List<Service> services = serviceDAO.getServices();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(services));
                    response.getWriter().close();
                }
                break;
                default:
                    break;
            }
        }

        String username = request.getParameter("username");
        if (username != null) {
            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.getAccount(username);
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String accountJson = gsonBuilder.create().toJson(account);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(accountJson);
            response.getWriter().close();
        }

        String blogID = request.getParameter("blogID");
        if (blogID != null) {
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlog(Integer.parseInt(blogID));
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String blogJson = gsonBuilder.create().toJson(blog);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(blogJson);
            response.getWriter().close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
