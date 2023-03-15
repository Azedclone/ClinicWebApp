package controller;

import config.MailConfig;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class Authentication extends HttpServlet {

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
        response.setContentType("text/plain;charset-UTF8");
        String type = request.getParameter("type");

        switch (type) {
            case "login": {
                String username = request.getParameter("username");
                String password = DigestUtils.md5Hex(request.getParameter("password")).toUpperCase();
                HttpSession session = request.getSession();
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.getAccount(username, password);
                if (account == null) {
                    response.getWriter().write("wrong");
                } else {
                    session.setAttribute("currentAccount", account);
                    response.getWriter().write("success");
                }
                response.getWriter().close();
            }
            break;
            case "logout": {
                HttpSession session = request.getSession();
                session.removeAttribute("currentAccount");
                response.getWriter().close();
            }
            break;
            case "register": {
                String username = request.getParameter("username");
                String password = DigestUtils.md5Hex(request.getParameter("password")).toUpperCase();
                HttpSession session = request.getSession();
                AccountDAO accountDAO = new AccountDAO();

                if (accountDAO.isExist(username)) {
                    response.getWriter().write("exist");
                } else {
                    accountDAO.register(username, password, 2);
                    response.getWriter().write("success");
                }
                response.getWriter().close();
            }
            break;
            case "forgot": {
                String username = request.getParameter("username");
                String emailRecover = request.getParameter("email");

                AccountDAO accountDAO = new AccountDAO();
                if (!accountDAO.isExist(username)) {
                    response.getWriter().write("!exist");
                } else {
                    if (accountDAO.getAccountEmail(username) == null || !accountDAO.getAccountEmail(username).equals(emailRecover)) {
                        response.getWriter().write("!link");
                    } else {
                        String newPassword = MailConfig.generatePassword();
                        //Change password in DB
                        accountDAO.changePassword(username, newPassword);

                        //Create email object
                        Email email = new SimpleEmail();

                        //Config email server
                        email.setHostName(MailConfig.HOST_NAME);
                        email.setSmtpPort(MailConfig.TSL_PORT);
                        email.setAuthenticator(new DefaultAuthenticator(MailConfig.FROM_EMAIL, MailConfig.FROM_PASSWORD));
                        email.setTLS(true);

                        try {
                            //Set sender and receiver
                            email.setFrom(MailConfig.FROM_EMAIL);
                            email.addTo(emailRecover);
                            email.setSubject(MailConfig.SUBJECT);
                            email.setMsg(newPassword);
                            email.send();
                            response.getWriter().write("success");
                        } catch (EmailException e) {
                            e.printStackTrace();
                            System.out.println("Error when send email!");
                        }
                    }
                }
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
