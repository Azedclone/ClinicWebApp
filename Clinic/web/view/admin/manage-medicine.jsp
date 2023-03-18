<section id="medicine">
    <div class="title">Manage Medicine</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Medicine
            </button>
            <table class="table table-striped text-center" id="medicines">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Brand</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start form create medicine -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Medicine</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create">
                    <div class="mb-3">
                        <label for="medicineName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="medicineName" name="medicineName" required>
                    </div>
                    <div class="mb-3">
                        <label for="brandMedicine" class="form-label">Brand</label>
                        <input type="text" class="form-control" id="brandMedicine" name="brand" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description" required>
                    </div>
                    <button type="submit" class="btn btn-primary" disabled>Create</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End form create medicine -->

<!-- Start form edit medicine -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Medicine</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit">
                    <div class="mb-3" hidden>
                        <label for="medicineID" class="form-label">ID</label>
                        <input type="text" class="form-control" id="medicineID" value="" name="medicineID">
                    </div>
                    <div class="mb-3">
                        <label for="nameLabel" class="form-label">Name</label>
                        <input type="text" class="form-control" id="nameLabel" name="medicineName" required>
                    </div>
                    <div class="mb-3">
                        <label for="brandLabel" class="form-label">Brand</label>
                        <input type="text" class="form-control" id="brandLabel" name="brand" required>
                    </div>
                    <div class="mb-3">
                        <label for="descriptionLabel" class="form-label">Description</label>
                        <input type="text" class="form-control" id="descriptionLabel" name="description" required>
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
<!-- End form edit medicine -->

<script>
    $(document).ready(function () {
        loadData("medicines");
        manageMedicine();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#medicines tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>

