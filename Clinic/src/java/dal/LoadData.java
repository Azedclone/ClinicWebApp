package dal;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.*;

public class LoadData extends HttpServlet {

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
        String type = request.getParameter("type");

        if (type != null) {
            switch (type) {
                case "accounts": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> accounts = accountDAO.getAccounts();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(accounts));
                    response.getWriter().close();
                }
                break;
                case "doctors": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> doctors = accountDAO.getDoctors();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(doctors));
                    response.getWriter().close();
                }
                break;
                case "patients": {
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> patients = accountDAO.getPatients();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(patients));
                    response.getWriter().close();
                }
                break;
                case "categories": {
                    BlogDAO blogDAO = new BlogDAO();
                    List<Category> categories = blogDAO.getCategories();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(categories));
                    response.getWriter().close();
                }
                break;
                case "blogs": {
                    BlogDAO blogDAO = new BlogDAO();
                    List<Blog> blogs = blogDAO.getBlogs();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(blogs));
                    response.getWriter().close();
                }
                break;
                case "services": {
                    ServiceDAO serviceDAO = new ServiceDAO();
                    List<Service> services = serviceDAO.getServices();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(services));
                    response.getWriter().close();
                }
                break;
                case "medicines": {
                    MedicineDAO medicineDAO = new MedicineDAO();
                    List<Medicine> medicines = medicineDAO.getMedicines();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(new Gson().toJson(medicines));
                }
                break;
                case "appointments": {
                    AppointmentDAO appointmentDAO = new AppointmentDAO();
                    HttpSession session = request.getSession();
                    Account currentAccount = (Account) session.getAttribute("currentAccount");
                    if (currentAccount.getAccountRole() == 2) {
                        List<Appointment> appointments = appointmentDAO.getAppointmentsForPat(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(appointments));
                    } else if (currentAccount.getAccountRole() == 1) {
                        List<Appointment> appointments = appointmentDAO.getAppointmentsForDoc(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(appointments));
                    }
                }
                break;
                case "examinations": {
                    ExaminationDAO examinationDAO = new ExaminationDAO();
                    HttpSession session = request.getSession();
                    Account currentAccount = (Account) session.getAttribute("currentAccount");
                    if (currentAccount.getAccountRole() == 2) {
                        List<Examination> examinations = examinationDAO.getExaminationsForPat(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(examinations));
                    } else if (currentAccount.getAccountRole() == 1) {
                        List<Examination> examinations = examinationDAO.getExaminationsForDoc(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(examinations));
                    }
                }
                break;
                case "prescriptions": {
                    PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
                    HttpSession session = request.getSession();
                    Account currentAccount = (Account) session.getAttribute("currentAccount");
                    if (currentAccount.getAccountRole() == 2) {
                        List<Prescription> prescriptions = prescriptionDAO.getPrescriptionsForPat(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(prescriptions));
                    } else if (currentAccount.getAccountRole() == 1) {
                        List<Prescription> prescriptions = prescriptionDAO.getPrescriptionsForDoc(currentAccount.getAccountID());
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        response.getWriter().write(new Gson().toJson(prescriptions));
                    }
                }
                break;
                default:
                    break;
            }
        }

        String username = request.getParameter("username");
        if (username != null) {
            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.getAccount(username);
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String accountJson = gsonBuilder.create().toJson(account);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(accountJson);
            response.getWriter().close();
        }

        String blogID = request.getParameter("blogID");
        if (blogID != null) {
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlog(Integer.parseInt(blogID));
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String blogJson = gsonBuilder.create().toJson(blog);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(blogJson);
            response.getWriter().close();
        }

        String serviceID = request.getParameter("serviceID");
        if (serviceID != null) {
            ServiceDAO serviceDAO = new ServiceDAO();
            Service service = serviceDAO.getService(Integer.parseInt(serviceID));
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(new Gson().toJson(service));
            response.getWriter().close();
        }

        String medicineID = request.getParameter("medicineID");
        if (medicineID != null) {
            MedicineDAO medicineDAO = new MedicineDAO();
            Medicine medicine = medicineDAO.getMedicine(Integer.parseInt(medicineID));
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(new Gson().toJson(medicine));
            response.getWriter().close();
        }

        String appointmentID = request.getParameter("appointmentID");
        if (appointmentID != null) {
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            Appointment appointment = appointmentDAO.getAppointment(Integer.parseInt(appointmentID));
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String appointmentJson = gsonBuilder.create().toJson(appointment);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(appointmentJson);
        }

        String examinationID = request.getParameter("examinationID");
        if (examinationID != null) {
            ExaminationDAO examinationDAO = new ExaminationDAO();
            Examination examination = examinationDAO.getExamination(Integer.parseInt(examinationID));
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String examinationJson = gsonBuilder.create().toJson(examination);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(examinationJson);
            response.getWriter().close();
        }

        String prescriptionID = request.getParameter("prescriptionID");
        if (prescriptionID != null) {
            PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
            Prescription prescription = prescriptionDAO.getPrescription(Integer.parseInt(prescriptionID));
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.setDateFormat("yyyy-MM-dd");
            String prescriptionJson = gsonBuilder.create().toJson(prescription);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(prescriptionJson);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
