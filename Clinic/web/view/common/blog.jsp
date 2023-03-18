<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentAccount" value="${sessionScope.currentAccount}"></c:set>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Home page</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
            <!-- My CSS -->
            <link rel="stylesheet" href="../../assets/css/common.css">

        </head>
        <body>
            <!-- Start navbar -->
        <%@include file="../include/navbar.jsp"%>
            <!-- End navbar -->

            <section id="blog">
                <div class="container-fluid">
                    <div class="container">
                        <div class="card-container d-flex justify-content-between">
                            <div class="card rounded-3" style="width: 20rem; border-color: #2a8bec;">
                                <img src="../../assets/img/blogs/blog_1.jpg" class="card-img-top rounded-top-3 p-4" alt="...">
                                <div class="card-body">
                                    <p class="card-title fw-semibold" style="font-size: 16px;">
                                        3 Causes Of Gastric ulcers Appetite And How To Overcom.
                                    </p>
                                    <p class="card-subtitle text-secondary" style="font-size: 13px;">
                                        Donec condimentum, lacus vitae pellentesque feugiat,Proin magna.
                                    </p>
                                </div>
                                <div class="card-footer d-flex">
                                    <img src="../../assets/img/doctors/doctor_1.jpg" alt="" class="my-auto">
                                    <p class="author fw-semibold ps-3 m-0">
                                        Shao Khahn<br>
                                        <span style="font-size: 12px;">30m read   26 Feb 2023</span>
                                    </p>
                                </div>
                            </div>
                            <div class="card rounded-3" style="width: 20rem; border-color: #2a8bec;">
                                <img src="../../assets/img/blogs/blog_2.jpg" class="card-img-top rounded-top-3 p-4" alt="...">
                                <div class="card-body">
                                    <p class="card-title fw-semibold" style="font-size: 16px;">
                                        3 Causes Of Gastric ulcers Appetite And How To Overcom.
                                    </p>
                                    <p class="card-subtitle text-secondary" style="font-size: 13px;">
                                        Donec condimentum, lacus vitae pellentesque feugiat,Proin magna.
                                    </p>
                                </div>
                                <div class="card-footer d-flex">
                                    <img src="../../assets/img/doctors/doctor_2.jpg" alt="" class="my-auto">
                                    <p class="author fw-semibold ps-3 m-0">
                                        Mikhail Varshavski<br>
                                        <span style="font-size: 12px;">30m read   26 Feb 2023</span>
                                    </p>
                                </div>
                            </div>
                            <div class="card rounded-3" style="width: 20rem; border-color: #2a8bec;">
                                <img src="../../assets/img/blogs/blog_3.jpg" class="card-img-top rounded-top-3 p-4" alt="...">
                                <div class="card-body">
                                    <p class="card-title fw-semibold" style="font-size: 16px;">
                                        3 Causes Of Gastric ulcers Appetite And How To Overcom.
                                    </p>
                                    <p class="card-subtitle text-secondary" style="font-size: 13px;">
                                        Donec condimentum, lacus vitae pellentesque feugiat,Proin magna.
                                    </p>
                                </div>
                                <div class="card-footer d-flex">
                                    <img src="../../assets/img/doctors/doctor_3.jpg" alt="" class="my-auto">
                                    <p class="author fw-semibold ps-3 m-0">
                                        Johny Sin<br>
                                        <span style="font-size: 12px;">30m read 26 Feb 2023</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            

        <!-- Start footer -->
        <%@include file="../include/footer.jsp"%>
        <!-- End footer -->

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
        <!-- JQuery -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="../../assets/js/auth.js"></script>
        <script>
            $(document).ready(() => {
                logout();
            })
        </script>
    </body>
</html>
