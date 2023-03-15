<section id="doctor">
    <div class="title">Manage Doctor</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-user-plus me-3"></i>Create Doctor
            </button>

            <table class="table table-striped text-center" id="doctors">
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

<!-- Start form create doctor -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Doctor</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="create">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" aria-describedby="usernameHelp" name="username" required>
                        <div id="usernameHelp" class="form-text">User name must not be duplicate.</div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" aria-describedby="passwordHelp" name="password" required>
                        <div id="passwordHelp" class="form-text">Password should contains at least 8 character.</div>
                    </div>
                    <button type="submit" class="btn btn-primary" disabled>Submit</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End form create doctor -->

<!-- Start Form edit Doctor -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Doctor</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit">
                    <div class="mb-3" hidden>
                        <label for="usernameLabel" class="form-label">Username</label>
                        <input type="text" class="form-control" id="usernameLabel" value="" name="username" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="accountName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="accountName" value="" name="accountName" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" value="" name="email">
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" value="" name="phone">
                    </div>
                    <label for="gender" class="me-3">Gender:</label>
                    <div class="form-check form-check-inline mb-3 me-2" id="gender">
                        <input class="form-check-input" type="radio" name="gender" id="male" value="0" checked>
                        <label class="form-check-label" for="male">
                            Male
                        </label>
                    </div>
                    <div class="form-check form-check-inline mb-3 me-2">
                        <input class="form-check-input" type="radio" name="gender" id="female" value="1">
                        <label class="form-check-label" for="female">
                            Female
                        </label>
                    </div>
                    <div class="form-check form-check-inline mb-3">
                        <input class="form-check-input" type="radio" name="gender" id="other" value="2">
                        <label class="form-check-label" for="other">
                            Other
                        </label>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" value="" name="address">
                    </div>
                    <div class="mb-3">
                        <label for="dob" class="form-label">DOB</label>
                        <input type="date" class="form-control" id="dob" value="" name="dob" max="2000-01-01" min="1924-01-01">
                    </div>
                    <button type="submit" class="btn btn-primary" disabled>Save</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End Form edit Doctor -->

<script>
    $(document).ready(function () {
        loadData("doctors");
        manageDoctor();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#doctors tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>