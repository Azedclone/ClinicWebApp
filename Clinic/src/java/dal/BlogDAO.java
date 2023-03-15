package dal;

import config.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.Category;


public class BlogDAO extends DBContext{
    //Get all blog
    public List<Blog> getBlogs() {
        List<Blog> blogs = new ArrayList<>();
        try {
            String sql = "select b.*, a.accountName as authorName , c.categoryName "
                    + "from swp.blogs AS b "
                    + "join accounts AS a on b.authorID = a.accountID "
                    + "join categories as c on b.categoryID = c.categoryID;";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                blogs.add(new Blog(rs.getInt("blogID"),
                        rs.getString("title"),
                        rs.getString("thumbnails"),
                        rs.getString("content"),
                        rs.getInt("categoryID"),
                        rs.getDate("createdDate"),
                        rs.getDate("publishedDate"),
                        rs.getInt("status"),
                        rs.getInt("authorID"),
                        rs.getString("authorName"),
                        rs.getString("categoryName")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in BlogDAO.getBlogs()");
        }
        return blogs;
    }
    
    //Get all categories
    public List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String sql = "select * from swp.categories";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getInt("categoryID"), rs.getString("categoryName")));
            }
        } catch (SQLException e) {
            System.out.println("Error in BlogDAO.getCategories()");
        }
        return categories;
    }
    
    // Check duplicate title
    public boolean isExist(String title) {
        try {
            String sql = "select * from swp.blogs where title = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in BlogDAO.isExist()");
        }

        return false;
    }
    
    // Create blog
    public boolean createBlog(String title, String thumbnails, String content, int categoryID, int authorID) {
        try {
            String sql = "insert into blogs (title, thumbnails, content, categoryID, authorID, status) "
                    + "values(?, ?, ?, ?, ?, 0)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, thumbnails);
            st.setString(3, content);
            st.setInt(4, categoryID);
            st.setInt(5, authorID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in BlogDAO.createBlog()");
            return false;
        }
    }
    
    //Get single blog
    public Blog getBlog(int blogID) {
        try {
            String sql = sql = "select b.*, a.accountName as authorName , c.categoryName "
                    + "from swp.blogs AS b "
                    + "join accounts AS a on b.authorID = a.accountID "
                    + "join categories as c on b.categoryID = c.categoryID "
                    + "where b.blogID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return new Blog(rs.getInt("blogID"),
                        rs.getString("title"),
                        rs.getString("thumbnails"),
                        rs.getString("content"),
                        rs.getInt("categoryID"),
                        rs.getDate("createdDate"),
                        rs.getDate("publishedDate"),
                        rs.getInt("status"),
                        rs.getInt("authorID"),
                        rs.getString("authorName"),
                        rs.getString("categoryName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in BlogDAO.getBlog()");
        }

        return null;
    }
    
    //Update blog infomation
    public boolean updateBlog(int blogID, String title, String thumbnails, String content, int status, int categoryID, Date publishedDate) {
        try {
            String sql = "update blogs set title = ?, "
                    + "thumbnails = ?, "
                    + "content = ?, "
                    + "status = ?, "
                    + "categoryID = ?, "
                    + "publishedDate = ? "
                    + "where blogID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, thumbnails);
            st.setString(3, content);
            st.setInt(4, status);
            st.setInt(5, categoryID);
            st.setDate(6, publishedDate);
            st.setInt(7, blogID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in BlogDAO.updateBlog()");
            return false;
        }

    }
    
    //Delete blog
    public boolean deleteBlog(int blogID) {
        try {
            String sql = "delete from blogs where blogID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in BlogDAO.deleteBlog()");
            return false;
        }
    }
}
