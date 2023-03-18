<section id="prescription">
    <div class="title">Prescription</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Prescription
            </button>
            <table class="table table-striped text-center" id="prescriptions">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Medicine</th>
                        <th scope="col">Created Date</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start form create prescription -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Prescription</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create">
                    <div class="mb-3">
                        <label for="patients" class="form-label">Select Patient</label>
                        <select class="form-select" id="patients" name="patientID">
                            <!-- Must load all patient here -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="medicines" class="form-label">Select Medicine</label>
                        <br>
                        <div id="medicines">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="instruction" class="form-label">Instruction</label>
                        <textarea rows="6" class="form-control" id="instruction" value="" name="instruction"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Create</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End form create prescription -->

<!-- Start form view prescription -->
<div class="modal fade" id="form-view" tabindex="-1" aria-labelledby="formViewLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formViewLabel">View Prescription</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="view">
                    <div class="mb-3">
                        <label for="instructionLabel" class="form-label">Instruction</label>
                        <textarea type="text" class="form-control" id="instructionLabel" name="instruction" readonly></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End form view Prescription-->

<script>
    $(function() {
        loadData("prescriptions");
        loadData("patients");
        loadData("medicines");
        managePrescription();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#prescriptions tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
