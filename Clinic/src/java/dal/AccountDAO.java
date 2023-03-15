package dal;

import config.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import org.apache.commons.codec.digest.DigestUtils;

public class AccountDAO extends DBContext {

    // Get all accounts
    public final List<Account> getAccounts() {
        List<Account> accounts = new ArrayList<>();

        try {
            String sql = "select * from swp.accounts where accountStatus = 1 and (accountRole = 1 or accountRole = 2)";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                accounts.add(new Account(
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
                        rs.getInt("accountStatus")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getAccounts()");
        }

        return accounts;
    }

    // Get all accounts
    public final List<Account> getDoctors() {
        List<Account> accounts = new ArrayList<>();

        try {
            String sql = "select * from swp.accounts where accountStatus = 1 and accountRole = 1";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                accounts.add(new Account(
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
                        rs.getInt("accountStatus")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getDoctors()");
        }

        return accounts;
    }
    
    // Get all patients
    public final List<Account> getPatients() {
        List<Account> accounts = new ArrayList<>();

        try {
            String sql = "select * from swp.accounts where accountStatus = 1 and accountRole = 2";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                accounts.add(new Account(
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
                        rs.getInt("accountStatus")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getDoctors()");
        }

        return accounts;
    }

    // Get account by username and password
    public final Account getAccount(String username, String password) {
        try {
            String sql = "select * from swp.accounts where username = ? and password = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

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
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getAccount()");
        }

        // If username or password not match with database
        return null;
    }

    // Get account by username
    public final Account getAccount(String username) {
        try {
            String sql = "select * from swp.accounts where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);

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
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getAccount()");
        }

        // If username or password not match with database
        return null;
    }

    // Get email of account
    public final String getAccountEmail(String username) {
        try {
            String sql = "select email from swp.accounts where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.getAccountEmail()");
            return "";
        }

        return "";
    }

    // Change password of account
    public final void changePassword(String username, String newPassword) {
        newPassword = DigestUtils.md5Hex(newPassword).toUpperCase();

        try {
            String sql = "update swp.accounts set password = ? where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, username);
            st.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.changePassword()");
        }
    }

    // Check account existed in database or not
    public final boolean isExist(String username) {
        try {
            String sql = "select * from swp.accounts where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.isExist()");
        }

        return false;
    }

    // Insert new account to database
    public final boolean register(String username, String password, int accountRole) {
        try {
            String sql = "insert into swp.accounts(username, password, accountRole, accountStatus) values(?, ?, ?, 1)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, accountRole);
            st.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.register()");
            return false;
        }
    }

    // Update account infomation
    public final boolean updateAccount(String username, String accountName, String email, String phone, int gender, String address, Date dob) {
        try {
            String sql = "update swp.accounts set "
                    + "accountName = ?, "
                    + "email = ?, "
                    + "phone = ?, "
                    + "gender = ?, "
                    + "address = ?, "
                    + "dob = ? "
                    + "where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, accountName);
            st.setString(2, email);
            st.setString(3, phone);
            st.setInt(4, gender);
            st.setString(5, address);
            st.setDate(6, dob);
            st.setString(7, username);
            st.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.updateAccount()");
            return false;
        }
    }
    
    // Delete account
    public final boolean deleteAccount(String username) {
        try {
            String sql = "update swp.accounts set accountStatus = 0 where username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error in AccountDAO.deleteAccount()");
            return false;
        }
    }
    
    
}
