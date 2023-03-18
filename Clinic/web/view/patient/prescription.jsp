<section id="prescription">
    <div class="title">Prescription</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <table class="table table-striped text-center" id="prescriptions">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Doctor</th>
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


<!-- Start form view Prescription -->
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
                        <label for="instruction" class="form-label">Instruction</label>
                        <textarea rows="6" class="form-control" id="instruction" name="instruction" readonly></textarea>
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
        viewPrescription();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#prescriptions tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
