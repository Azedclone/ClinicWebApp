package model;

import java.sql.Date;

public class Account {

    private int accountID;
    private String username;
    private String password;
    private String email;
    private String avatar;
    private String accountName;
    private String phone;
    private int gender;
    private String address;
    private Date dob;
    private int accountRole;
    private int accountStatus;

    public Account() {
    }

    public Account(int accountID, String username, String password, String email, String avatar, String accountName, String phone, int gender, String address, Date dob, int accountRole, int accountStatus) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.accountName = accountName;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.dob = dob;
        this.accountRole = accountRole;
        this.accountStatus = accountStatus;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public int getAccountRole() {
        return accountRole;
    }

    public void setAccountRole(int accountRole) {
        this.accountRole = accountRole;
    }

    public int getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(int accountStatus) {
        this.accountStatus = accountStatus;
    }

}
