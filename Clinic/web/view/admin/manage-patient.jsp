<section id="patient">
    <div class="title">Manage Patient</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <table class="table table-striped text-center" id="patients">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Username</th>
                        <th scope="col">Name</th>
                        <th scope="col">Mail</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start modal view Patient -->
<div class="modal fade" id="form-view" tabindex="-1" aria-labelledby="formViewLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formViewLabel">View Patient</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="view">
                    <div class="mb-3" hidden>
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" value="" name="username" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="accountName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="accountName" value="" name="accountName" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" value="" name="mail" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" value="" name="phone" readonly>
                    </div>
                    <label for="gender" class="me-3">Gender:</label>
                    <div class="form-check form-check-inline mb-3 me-2" id="gender">
                        <input class="form-check-input" type="radio" name="gender" id="male" value="0" disabled>
                        <label class="form-check-label" for="male">
                            Male
                        </label>
                    </div>
                    <div class="form-check form-check-inline mb-3 me-2">
                        <input class="form-check-input" type="radio" name="gender" id="female" value="1" disabled>
                        <label class="form-check-label" for="female">
                            Female
                        </label>
                    </div>
                    <div class="form-check form-check-inline mb-3">
                        <input class="form-check-input" type="radio" name="gender" id="other" value="2" disabled>
                        <label class="form-check-label" for="other">
                            Other
                        </label>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" value="" name="address" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="dob" class="form-label">DOB</label>
                        <input type="date" class="form-control" id="dob" value="" name="dob" readonly>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End modal view Patient -->

<script>
    $(document).ready(function () {
        loadData("patients");
        viewPatient();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#patients tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>