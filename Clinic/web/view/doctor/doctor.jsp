<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentAccount" value="${sessionScope.currentAccount}"></c:set>
<c:set var="role" value="${currentAccount.accountRole}"></c:set>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <title>Doctor page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
        <!-- Panel CSS -->
        <link rel="stylesheet" href="../../assets/css/panel.css">
    </head>
    <body>
        <!-- Start Sidebar -->
        <section id="sidebar">
            <div class="logo-details">
                <div class="icon">
                    <i class="fa-solid fa-house-medical"></i>
                </div>
                <div class="logo-name bg-white rounded-2 px-2">
                    <a href="../common/home.jsp" class="text-primary m-0 text-decoration-none">G4<span class="text-dark">-CLINIC</span></a>
                </div>
                <i class="fa-solid fa-bars btn-menu"></i>
            </div>

            <ul class="nav-lists">
                <li>
                    <a href="#appointment">
                        <i class="fa-regular fa-calendar-check"></i>
                        <span class="link-name">Appointment</span>
                    </a>
                    <span class="tool-tip">Appointment</span>
                </li>
                <li>
                    <a href="#examination">
                        <i class="fa-solid fa-flask-vial"></i>
                        <span class="link-name">Examination</span>
                    </a>
                    <span class="tool-tip">Examination</span>
                </li>
                <li>
                    <a href="#prescription">
                        <i class="fa-solid fa-prescription"></i>
                        <span class="link-name">Prescription</span>
                    </a>
                    <span class="tool-tip">Prescription</span>
                </li>
                <li>
                    <a href="#profile">
                        <i class="fa-solid fa-gear"></i>
                        <span class="link-name">Profile</span>
                    </a>
                    <span class="tool-tip">Profile</span>
                </li>
                <li class="profile">
                    <div class="profile-details">
                        <img src="../../assets/img/avatars/${currentAccount.avatar}" alt="profile image" class="me-2">
                        <div class="profile-content">
                            <div class="name">
                                ${currentAccount.accountName}
                            </div>
                            <div class="designation">
                                <c:choose>
                                    <c:when test="${role == 0}">
                                        Admin
                                    </c:when>
                                    <c:when test="${role == 1}">
                                        Doctor
                                    </c:when>
                                    <c:when test="${role == 2}">
                                        Patient
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <i class="fa-solid fa-right-from-bracket btn-logout" onclick="logout(event)"></i>
                </li>
            </ul>

        </section>
        <!-- End Sidebar -->

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
        <!-- JQuery -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- JQuery Validation plugin -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js" integrity="sha512-6S5LYNn3ZJCIm0f9L6BCerqFlQ4f5MwNKq+EthDXabtaJvg3TuFLhpno9pcm+5Ynm6jdA9xfpQoMz2fcjVMk9g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- JQuery UI -->
        <script src="
https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js
"></script>
        <!-- Sweet Alert 2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Doctor JS -->
        <script src="../../assets/js/doctor.js"></script>

        <div class="main-content">
            <%@include file="appointment.jsp" %>
        </div>
    </body>
</html>