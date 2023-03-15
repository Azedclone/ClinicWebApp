package controller;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.util.Enumeration;
import java.util.HashMap;
import model.Account;
import model.Blog;

@MultipartConfig
public class ManageBlog extends HttpServlet {

    private final BlogDAO blogDAO = new BlogDAO();

    private String createBlog(HashMap<String, String> data) {
        try {
            if (blogDAO.isExist(data.get("title"))) {
                return "exist";
            }
            if (blogDAO.createBlog(data.get("title"),
                    data.get("thumbnails").isEmpty() ? "default_thumbnails.jpg" : data.get("thumbnails"),
                    data.get("content"),
                    Integer.parseInt(data.get("categoryID")),
                    Integer.parseInt(data.get("authorID"))
            )) {
                return "success";
            }
            return "error";
        } catch (NumberFormatException e) {
            System.out.println("Error in ManageBlog.createBlog()");
            return "error";
        }
    }

    private String editBlog(HashMap<String, String> data) {
        Date publishedDate = null;
        if (Integer.parseInt(data.get("status")) == 1) {
            long millis = System.currentTimeMillis();
            publishedDate = new Date(millis);
        }

        try {
            Blog oldBlog = blogDAO.getBlog(Integer.parseInt(data.get("blogID")));
            if (!oldBlog.getTitle().equals(data.get("title"))) {
                if (blogDAO.isExist(data.get("title"))) {
                    return "exist";
                }
            }

            if (blogDAO.updateBlog(
                    Integer.parseInt(data.get("blogID")),
                    data.get("title"),
                    data.get("thumbnails").isEmpty() ? "default_thumbnails.jpg" : data.get("thumbnails"),
                    data.get("content"),
                    Integer.parseInt(data.get("status")),
                    Integer.parseInt(data.get("categoryID")),
                    publishedDate
            )) {
                return "success";
            }

            return "error";
        } catch (NumberFormatException e) {
            System.out.println("Error in ManageBlog.updateBlog()");
            return "error";
        }
    }

    private String deleteBlog(int blogID) {
        if (blogDAO.deleteBlog(blogID)) {
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
                Part part = request.getPart("thumbnails");
                String fileName = part.getSubmittedFileName();
                String path = getServletContext().getRealPath("/" + "assets/img/blogs" + File.separator + fileName);
                if (!fileName.equals("default_thumbnails.jpg")) {
                    dal.HandleImage.saveImage(part.getInputStream(), path);
                }
                Enumeration enumeration = request.getParameterNames();
                HashMap<String, String> data = new HashMap<>();
                data.put("thumbnails", fileName);
                data.put("authorID", Integer.toString(currentAccount.getAccountID()));

                while (enumeration.hasMoreElements()) {
                    String parameterName = (String) enumeration.nextElement();
                    data.put(parameterName, request.getParameter(parameterName));
                }
                response.getWriter().write(createBlog(data));
                response.getWriter().close();
            }
            break;
            case "edit": {
                String blogID = request.getParameter("blogID");
                Part part = request.getPart("thumbnails");
                String fileName = part.getSubmittedFileName();
                Blog blog = (Blog) blogDAO.getBlog(Integer.parseInt(blogID));
                String pathOld = getServletContext().getRealPath("/" + "assets/img/blogs" + File.separator + blog.getThumbnails());
                String pathNew = getServletContext().getRealPath("/" + "assets/img/blogs" + File.separator + fileName);

                //Handle picture
                if (!blog.getThumbnails().equals("default_thumbnails.jpg")) {
                    dal.HandleImage.deleteImage(pathOld);
                }
                if (dal.HandleImage.saveImage(part.getInputStream(), pathNew)) {
                    System.out.println("save image ok");
                }

                Enumeration enumeration = request.getParameterNames();
                HashMap<String, String> data = new HashMap<>();
                data.put("thumbnails", fileName);

                while (enumeration.hasMoreElements()) {
                    String parameterName = (String) enumeration.nextElement();
                    data.put(parameterName, request.getParameter(parameterName));
                }
                response.getWriter().write(editBlog(data));
                response.getWriter().close();
            }
            break;
            case "delete": {
                String blogID = request.getParameter("blogID");
                response.getWriter().write(deleteBlog(Integer.parseInt(blogID)));
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
