package dal;

import config.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Appointment;

public class AppointmentDAO extends DBContext {

    // Create Appointment
    public boolean createAppointment(int patientID, Date bookedDate, int slotID, int doctorID, String sympton, String message) {
        try {
            String sql = "insert into swp.appointments (patientID, bookedDate, slotID, doctorID, sympton, message) "
                    + "values(?, ?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            st.setDate(2, bookedDate);
            st.setInt(3, slotID);
            st.setInt(4, doctorID);
            st.setString(5, sympton);
            st.setString(6, message);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in AppointmentDAO.createAppointment()");
            return false;
        }
    }

    // Get all appointments for patient
    public List<Appointment> getAppointmentsForPat(int patientID) {
        List<Appointment> appointments = new ArrayList<>();

        try {
            String sql = "select app.*, a1.accountName as patientName, a2.accountName as doctorName "
                    + "from appointments as app "
                    + "join accounts as a1 on app.patientID = a1.accountID "
                    + "join accounts as a2 on app.doctorID = a2.accountID "
                    + "where app.patientID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                appointments.add(new Appointment(
                        rs.getInt("appointmentID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getDate("bookedDate"),
                        rs.getInt("slotID"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getString("sympton"),
                        rs.getString("message")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AppointmentDAO.getAppointmentsForPat()");
        }

        return appointments;
    }

    // Get all appointments for doctor
    public List<Appointment> getAppointmentsForDoc(int doctorID) {
        List<Appointment> appointments = new ArrayList<>();

        try {
            String sql = "select app.*, a1.accountName as patientName, a2.accountName as doctorName "
                    + "from appointments as app "
                    + "join accounts as a1 on app.patientID = a1.accountID "
                    + "join accounts as a2 on app.doctorID = a2.accountID "
                    + "where app.doctorID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, doctorID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                appointments.add(new Appointment(
                        rs.getInt("appointmentID"),
                        rs.getInt("patientID"),
                        rs.getString("patientName"),
                        rs.getDate("bookedDate"),
                        rs.getInt("slotID"),
                        rs.getInt("doctorID"),
                        rs.getString("doctorName"),
                        rs.getString("sympton"),
                        rs.getString("message")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in AppointmentDAO.getAppointmentsForPat()");
        }

        return appointments;
    }

    // Get specificed appointment
    public Appointment getAppointment(int appointmentID) {
        try {
            String sql = "select * from appointments where appointmentID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, appointmentID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return new Appointment(
                        rs.getInt("appointmentID"),
                        rs.getInt("patientID"),
                        rs.getDate("bookedDate"),
                        rs.getInt("slotID"),
                        rs.getInt("doctorID"),
                        rs.getString("sympton"),
                        rs.getString("message")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in AppointmentDAO.getAppointment()");
        }

        return null;
    }

    // Update Appointment
    public boolean updateAppointment(int appointmentID, String sympton, String message) {
        try {
            String sql = "update appointments set sympton = ?, message = ? where appointmentID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, sympton);
            st.setString(2, message);
            st.setInt(3, appointmentID);
            st.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in AppointmentDAO.updateAppointment()");
            return false;
        }
    }

    // Auto assign doctor available 
    public Account doctorAvailable(Date bookedDate, int slotID) {
        try {
            String sql = "select * "
                    + "from swp.accounts "
                    + "left join swp.appointments "
                    + "on accounts.accountID = appointments.doctorID and appointments.bookedDate = ? and appointments.slotID = ? "
                    + "where accounts.accountRole = 1 and appointments.appointmentID is null "
                    + "order by rand() "
                    + "limit 1";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDate(1, bookedDate);
            st.setInt(2, slotID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                return new Account(
                        rs.getInt("accountID"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("accountName"),
                        rs.getString("phone"),
                        rs.getInt("gender"),
                        rs.getString("address"),
                        rs.getDate("dob"),
                        rs.getInt("accountRole"),
                        rs.getInt("accountStatus")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in AppointmentDAO.doctorAvailable()");
        }

        return null;
    }

    public boolean isExist(int patientID, Date bookedDate, int slotID) {
        try {
            String sql = "select * from swp.appointments where patientID = ? and bookedDate = ? and slotID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, patientID);
            st.setDate(2, bookedDate);
            st.setInt(3, slotID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AppointmentDAO.isExist()");
        }
        return false;
    }
}
