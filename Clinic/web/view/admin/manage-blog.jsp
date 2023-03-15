<section id="blog">
    <div class="title">Manage Blog</div>
    <div class="container-fluid">
        <div class="container list">
            <form action="#" method="" class="float-start">
                Search: <input type="text" name="name" id="search">
            </form>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#form-create">
                <i class="fa-solid fa-plus me-3"></i>Create Blog
            </button>
            <table class="table table-striped text-center" id="blogs">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Title</th>
                        <th scope="col">Category</th>
                        <th scope="col">Author</th>
                        <th scope="col">Created Date</th>
                        <th scope="col">Status</th>
                        <th scope="col">Published Date</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Start Form Create blog -->
<div class="modal fade" id="form-create" tabindex="-1" aria-labelledby="formCreateLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formCreateLabel">Create Blog</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="title" class="form-label">Title</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="category" class="form-label">Category</label>
                        <select class="form-select" id="category" name="categoryID">
                            <!-- Must load all categories here -->
                          </select>
                    </div>
                    <div class="mb-3">
                        <label for="thumbnails" class="form-label">Thumbnails</label>
                        <input accept="image/jpeg" type="file" class="form-control mb-3" id="thumbnails" name="thumbnails">
                        <div class="text-center">
                            <img src="../../assets/img/blogs/default_thumbnails.jpg" alt="thumbnails" id="thumbnailsPreview" style="width: 88%; height: 50%;">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label">Content</label>
                        <textarea type="text" rows="6" class="form-control" id="content" name="content"></textarea>
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
<!-- End Form Create blog -->

<!-- Start form edit blog -->
<div class="modal fade" id="form-edit" tabindex="-1" aria-labelledby="formEditLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-3 text-uppercase fw-bold" id="formEditLabel">Edit Blog</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit" enctype="multipart/form-data">
                    <div class="mb-3" hidden>
                        <label for="blogID" class="form-label">ID</label>
                        <input type="text" class="form-control" id="blogID" value="" name="blogID" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="titleLabel" class="form-label">Title</label>
                        <input type="text" class="form-control" id="titleLabel" value="" name="title">
                    </div>
                    <div class="mb-3">
                        <label for="categoryLabel" class="form-label">Category</label>
                        <select class="form-select" id="categoryLabel" name="categoryID">
                            <!-- Must load all categories here -->
                          </select>
                    </div>
                    <div class="mb-3">
                        <label for="thumbLabel" class="form-label">Thumbnails</label>
                        <input accept="image/jpeg" type="file" class="form-control mb-3" id="thumbLabel" name="thumbnails">
                        <div class="text-center">
                            <img src="#" alt="thumbnails" id="thumbPreview" style="width: 88%; height: 50%;">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="contentLabel" class="form-label">Content</label>
                        <textarea rows="6" class="form-control" id="contentLabel" name="content"></textarea>
                    </div>
                    <div>
                        <label for="status" class="me-3">Status:</label>
                        <div class="form-check form-check-inline mb-3 me-2" id="status">
                            <input class="form-check-input" type="radio" name="status" id="pending" value="0">
                            <label class="form-check-label" for="pending">
                                Pending
                            </label>
                        </div>
                        <div class="form-check form-check-inline mb-3 me-2">
                            <input class="form-check-input" type="radio" name="status" id="active" value="1">
                            <label class="form-check-label" for="active">
                                Active
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
        loadData("blogs");
        loadData("categories");
        manageBlog();

        $("#search").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#blogs tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    })
</script>
