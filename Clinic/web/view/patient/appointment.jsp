<section id="appointment">
    <div class="title">Appointment</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Appointemnt
            </button>

            <table class="table table-striped text-center" id="appointments">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Booked Date</th>
                        <th scope="col">Slot</th>
                        <th scope="col">Doctor</th>
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

<!-- Start form create appointment -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Appointment</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create">
                    <div class="mb-3">
                        <label class="form-label">Schedule</label>
                        <div class="d-flex justify-content-between">
                            <input type="text" class="form-control" id="bookDate" value="" name="bookedDate">
                            <select class="form-select" id="slots" name="slotID">
                                <option value="1">Slot 1</option>
                                <option value="2">Slot 2</option>
                                <option value="3">Slot 3</option>
                                <option value="4">Slot 4</option>
                                <option value="5">Slot 5</option>
                                <option value="6">Slot 6</option>
                            </select>
                        </div>
                        <br>
                        <div class="text-center">
                            <small class="slotDes fst-italic text-secondary">
                                * Slot 1: 7 AM - Slot 2: 9 AM - Slot 3: 11 AM <br>
                                * Slot 4: 1 PM - Slot 5: 3 PM - Slot 6: 5 PM
                            </small>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="sympton" class="form-label">Sympton</label>
                        <input type="text" class="form-control" id="sympton" value="" name="sympton" required maxlength="200">
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea rows="6" class="form-control" id="message" value="" name="message" maxlength="200"></textarea>
                        <small class="fst-italic text-secondary">* Max length is 200 characters</small>
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
<!-- End form create appointment -->

<!-- Start Form edit appointment -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Appointment</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit">
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
                        <textarea rows="6" class="form-control" id="messageLabel" value="" name="message" maxlength="200"></textarea>
                        <small class="fst-italic text-secondary">* Max length is 200 characters</small>
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
<!-- End Form edit appointment -->

<script>
    $(function() {
        loadData('appointments');
        $('#bookDate').datepicker({
            minDate: 0,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'yy-mm-dd'
        });
        manageAppointment();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#appointments tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>