package dal;

import config.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Medicine;


public class MedicineDAO extends DBContext{
    
    // Get all medicine
    public List<Medicine> getMedicines() {
        List<Medicine> medicines = new ArrayList<>();
        try {
            String sql = "select * from swp.medicines";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                medicines.add(new Medicine(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in MedicineDAO.getMedicines()");
        }

        return medicines;
    }
    
    // Check exist
    public boolean isExist(String medicineName) {
        try {
            String sql = "select * from swp.medicines where medicineName = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, medicineName);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in MedicineDAO.isExist()");
            return false;
        }
    }
    
    //Create medicine
    public boolean createMedicine(String name, String brand, String description) {
        try {
            String sql = "insert into swp.medicines (medicineName, brand, description) values(?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, brand);
            st.setString(3, description);
            st.execute();

            return true;
        } catch (SQLException e) {
            System.out.println("Error in MedicineDAO.createMedicine()");
            return false;
        }
    }
    
    //Update medicine
    public boolean updateMedicine(int medicineID, String medicineName, String brand, String description) {
        try {
            String sql = "update medicines set medicineName = ?, brand = ?, description = ? where medicineID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, medicineName);
            st.setString(2, brand);
            st.setString(3, description);
            st.setInt(4, medicineID);
            st.execute();

            return true;
        } catch (SQLException e) {
            System.out.println("Error in MedicineDAO.updateMedicine()");
            return false;
        }
    }

    //Get single service
    public Medicine getMedicine(int medicineID) {
        try {
            String sql = "select * from swp.medicines where medicineID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, medicineID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Medicine(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in MedicineDAO.getMedicine()");
        }

        return null;
    }
}
