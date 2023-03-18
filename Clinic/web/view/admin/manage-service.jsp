<section id="service">
    <div class="title">Manage Service</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Service
            </button>
            <table class="table table-striped text-center" id="services">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
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

<!-- Start Form create service -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Service</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create">
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="serviceName" required>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" class="form-control" id="price" name="price" required>
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
<!-- End Form create service -->

<!-- Start form edit blog -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Service</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit">
                    <div class="mb-3" hidden>
                        <label for="serviceID" class="form-label">ID</label>
                        <input type="text" class="form-control" id="serviceID" value="" name="serviceID">
                    </div>
                    <div class="mb-3">
                        <label for="nameLabel" class="form-label">Name</label>
                        <input type="text" class="form-control" id="nameLabel" name="serviceName" required>
                    </div>
                    <div class="mb-3">
                        <label for="priceLabel" class="form-label">Price</label>
                        <input type="number" class="form-control" id="priceLabel" name="price" min="1000" max="10000">
                    </div>
                    <div>
                        <label for="status" class="me-3">Status:</label>
                        <div class="form-check form-check-inline mb-3 me-2" id="status">
                            <input class="form-check-input" type="radio" name="status" id="disable" value="0">
                            <label class="form-check-label" for="disable">
                                Disable
                            </label>
                        </div>
                        <div class="form-check form-check-inline mb-3 me-2">
                            <input class="form-check-input" type="radio" name="status" id="available" value="1">
                            <label class="form-check-label" for="available">
                                Available
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
<!-- End form edit blog -->

<script>
    $(document).ready(function () {
        loadData("services");
        manageService();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#services tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>
