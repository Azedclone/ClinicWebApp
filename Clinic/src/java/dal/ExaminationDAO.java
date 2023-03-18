package dal;

import config.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Examination;

public class ExaminationDAO extends DBContext {

    // Create examination
    public boolean createExamination(int patientID, int serviceID, int doctorID) {
        try {
            String sql = "insert into swp.examinations (patientID, serviceID, doctorID, status) values (?, ?, ?, 0)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            st.setInt(2, serviceID);
            st.setInt(3, doctorID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in ExaminationDAO.createExamination()");
            return false;
        }
    }

    public List<Examination> getExaminationsForDoc(int doctorID) {
        List<Examination> examinations = new ArrayList<>();

        try {
            String sql = "select e.*, a1.accountName as patientName, a2.accountName as doctorName, s.serviceName "
                    + "from examinations as e "
                    + "join accounts as a1 on e.patientID = a1.accountID "
                    + "join accounts as a2 on e.doctorID = a2.accountID "
                    + "join services as s on e.serviceID = s.serviceID "
                    + "where e.doctorID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, doctorID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                examinations.add(new Examination(
                        rs.getInt("examinationID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getInt("serviceID"),
                        rs.getString("serviceName"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getDate("createdDate"),
                        rs.getInt("status"),
                        rs.getString("result")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in ExaminationDAO.getExaminationsForDoc()");
        }

        return examinations;
    }

    public List<Examination> getExaminationsForPat(int patientID) {
        List<Examination> examinations = new ArrayList<>();

        try {
            String sql = "select e.*, a1.accountName as patientName, a2.accountName as doctorName, s.serviceName "
                    + "from examinations as e "
                    + "join accounts as a1 on e.patientID = a1.accountID "
                    + "join accounts as a2 on e.doctorID = a2.accountID "
                    + "join services as s on e.serviceID = s.serviceID "
                    + "where e.patientID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                examinations.add(new Examination(
                        rs.getInt("examinationID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getInt("serviceID"),
                        rs.getString("serviceName"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getDate("createdDate"),
                        rs.getInt("status"),
                        rs.getString("result")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in ExaminationDAO.getExaminationsForPat()");
        }

        return examinations;
    }

    // Edit examination
    public boolean editExamination(int examinationID, int status, String result) {
        try {
            String sql = "update swp.examinations set status = ?, result = ? where examinationID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, status);
            st.setString(2, result);
            st.setInt(3, examinationID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in ExaminationDAO.editExamination()");
            return false;
        }
    }

    // Get single examination
    public Examination getExamination(int examinationID) {
        try {
            String sql = "select e.*, a1.accountName as patientName, a2.accountName as doctorName, s.serviceName "
                    + "from examinations as e "
                    + "join accounts as a1 on e.patientID = a1.accountID "
                    + "join accounts as a2 on e.doctorID = a2.accountID "
                    + "join services as s on e.serviceID = s.serviceID "
                    + "where e.examinationID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, examinationID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Examination(
                        rs.getInt("examinationID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getInt("serviceID"),
                        rs.getString("serviceName"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getDate("createdDate"),
                        rs.getInt("status"),
                        rs.getString("result")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in ExaminationDAO.getExamination()");
        }

        return null;
    }
}
