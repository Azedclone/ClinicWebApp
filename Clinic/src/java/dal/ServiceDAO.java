package dal;

import config.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

public class ServiceDAO extends DBContext {

    // Get all services
    public List<Service> getServices() {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "select * from swp.services";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                services.add(new Service(
                        rs.getInt("serviceID"),
                        rs.getString("serviceName"),
                        rs.getDouble("price"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in ServiceDAO.getServices()");
        }

        return services;
    }

    public boolean isExist(String serviceName) {
        try {
            String sql = "select * from swp.services where serviceName = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in ServiceDAO.isExist()");
            return false;
        }
    }

    //Create service
    public boolean createService(String serviceName, double price) {
        try {
            String sql = "insert into services (serviceName, price, status) values(?, ?, 0)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, serviceName);
            st.setDouble(2, price);
            st.execute();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in ServiceDAO.createService()");
            return false;
        }
    }

    //Get single service
    public Service getService(int serviceID) {
        try {
            String sql = "select * from swp.services where serviceID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, serviceID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Service(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getInt(4)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in ServiceDAO.getService()");
        }

        return null;
    }

    //Update service
    public boolean updateService(int serviceID, String serviceName, double price, int status) {
        try {
            String sql = "update services set serviceName = ?, price = ?, status = ? where serviceID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, serviceName);
            st.setDouble(2, price);
            st.setInt(3, status);
            st.setInt(4, serviceID);
            st.execute();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in ServiceDAO.updateService()");
            return false;
        }
    }
}
