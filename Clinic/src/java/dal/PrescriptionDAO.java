package dal;

import config.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Prescription;

public class PrescriptionDAO extends DBContext {

    public List<Prescription> getPrescriptionsForDoc(int doctorID) {
        List<Prescription> prescriptions = new ArrayList<>();

        try {
            String sql = "select p.*, a1.accountName as patientName, a2.accountName as doctorName, m.medicineName "
                    + "from prescriptions as p "
                    + "join accounts as a1 on p.patientID = a1.accountID "
                    + "join accounts as a2 on p.doctorID = a2.accountID "
                    + "join medicines as m on p.medicineID = m.medicineID "
                    + "where p.doctorID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, doctorID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                prescriptions.add(new Prescription(
                        rs.getInt("prescriptionID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getInt("medicineID"),
                        rs.getString("medicineName"),
                        rs.getString("instruction"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getDate("createdDate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in PrescriptionDAO.getPrescriptionsForDoc()");
        }

        return prescriptions;
    }

    public List<Prescription> getPrescriptionsForPat(int patientID) {
        List<Prescription> prescriptions = new ArrayList<>();

        try {
            String sql = "select p.*, a1.name as patientName, a2.name as doctorName, m.name as medicineName "
                    + "from prescriptions as p "
                    + "join accounts as a1 on p.patientID = a1.accountID "
                    + "join accounts as a2 on p.doctorID = a2.accountID "
                    + "join medicines as m on p.medicineID = m.medicineID "
                    + "where p.patientID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                prescriptions.add(new Prescription(
                        rs.getInt("prescriptionID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getInt("medicineID"),
                        rs.getString("medicineName"),
                        rs.getString("instruction"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getDate("createdDate")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in PrescriptionDAO.getPrescriptionsForPat()");
        }

        return prescriptions;
    }

    public boolean createPrescription(int patientID, int medicineID, String instruction, int doctorID) {
        try {
            String sql = "insert into prescriptions (patientID, medicineID, instruction, doctorID) values(?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            st.setInt(2, medicineID);
            st.setString(3, instruction);
            st.setInt(4, doctorID);
            st.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in PrescriptionDAO.createPrescription()");
            return false;
        }
    }

    public Prescription getPrescription(int prescriptionID) {
        try {
            String sql = "select * from prescriptions where prescriptionID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, prescriptionID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return new Prescription(
                        rs.getInt("prescriptionID"),
                        rs.getInt("patientID"),
                        rs.getInt("medicineID"),
                        rs.getString("instruction"),
                        rs.getInt("doctorID"),
                        rs.getDate("createdDate")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in PrescriptionDAO.getPrescription()");
        }

        return null;
    }
}
