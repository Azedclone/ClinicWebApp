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
                        <th scope="col">Doctor</th>
                        <th scope="col">Service</th>
                        <th scope="col">Created Date</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody id="accordion">
                    
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
                    <button type="submit" class="btn btn-primary" disabled>Create</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End form create examination -->

<script>
    $(document).ready(function(){
        $( "#accordion" ).accordion({
      collapsible: true
    });
        loadData('patients');
        loadData('services');
    })
</script>
