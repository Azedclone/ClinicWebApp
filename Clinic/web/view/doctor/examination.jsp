<section id="examination">
    <div class="title">Examination</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Examination
            </button>
            <table class="table table-striped text-center" id="examinations">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Service Name</th>
                        <th scope="col">Created Date</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start form create examination -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Examination</h1>
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
                        <label for="services" class="form-label">Select Service</label>
                        <br>
                        <div id="services">
                        </div>
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
<!-- End form create examination -->

<!-- Start form edit examination -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Examination</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit">
                    <div class="mb-3" hidden>
                        <label for="examinationID" class="form-label">Examination ID</label>
                        <input type="text" class="form-control" id="examinationID" value="" name="examinationID">
                    </div>
                    <div class="mb-3">
                        <label for="patientName" class="form-label">Patient</label>
                        <input type="text" class="form-control" id="patientName" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="serviceName" class="form-label">Service</label>
                        <input type="text" class="form-control" id="serviceName" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="result" class="form-label">Result</label>
                        <textarea rows="6" class="form-control" id="result" name="result"></textarea>
                    </div>
                    <div>
                        <label for="status" class="me-3">Status:</label>
                        <div class="form-check form-check-inline mb-3 me-2" id="status">
                            <input class="form-check-input" type="radio" name="status" id="notpaidStatus" value="0">
                            <label class="form-check-label" for="notpaidStatus">
                                Not paid
                            </label>
                        </div>
                        <div class="form-check form-check-inline mb-3 me-2">
                            <input class="form-check-input" type="radio" name="status" id="paidStatus" value="1">
                            <label class="form-check-label" for="paidStatus">
                                Paid
                            </label>
                        </div>
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
<!-- End form edit examination-->

<script>
    $(document).ready(function(){
    loadData('examinations');
        loadData('patients');
        loadData('services');
        manageExamination();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#examinations tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>
