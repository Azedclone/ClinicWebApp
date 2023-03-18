<section id="appointment">
    <div class="title">Appointment</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>

            <table class="table table-striped text-center" id="appointments">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Booked Date</th>
                        <th scope="col">Slot</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Price</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start Form view appointment -->
<div class="modal fade" id="form-view" tabindex="-1" aria-labelledby="formViewLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formViewLabel">View Appointment</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="view">
                    <div class="mb-3" hidden>
                        <label for="appointmentIDLabel" class="form-label">Appointment ID</label>
                        <input type="text" class="form-control" id="appointmentIDLabel" value="" name="appointmentID" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="symptonLabel" class="form-label">Sympton</label>
                        <input type="text" class="form-control" id="symptonLabel" value="" name="sympton" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="messageLabel" class="form-label">Message</label>
                        <textarea rows="6" class="form-control" id="messageLabel" value="" name="message" maxlength="200" readonly></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End Form view appointment -->

<script>
    $(function() {
        loadData("appointments");
        manageAppointment();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#appointments tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>