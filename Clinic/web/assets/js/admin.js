window.onload = function () {
    const sidebar = document.querySelector('#sidebar');
    const closeBtn = document.querySelector('.btn-menu');

    closeBtn.addEventListener("click", function () {
        sidebar.classList.toggle("open");
        menuBtnChange();
    });

    function menuBtnChange() {
        if (sidebar.classList.contains("open")) {
            closeBtn.classList.replace("fa-bars", "fa-caret-left");
        } else {
            closeBtn.classList.replace("fa-caret-left", "fa-bars");
        }
    }
};

$('#sidebar li>a').click(function () {
    var href = $(this).attr('href').replace('#', '') + '.jsp';
    // console.log(href);

    $.get('../../view/admin/' + href, function (data) {
        // console.log(data);
        $('.main-content').html(data);
    });
});

function logout(e) {
    e.preventDefault();
    $.post('../../auth?type=logout');
    Swal.fire({
        icon: 'success',
        text: 'Logout successfully!',
        showConfirmButton: false,
        timer: 800
    });
    setTimeout(function () {
        window.location.href = "../common/home.jsp";
    }, 1000);
}

// Load data from database using AJAX
function loadData(type) {
    switch (type) {
        case 'accounts':
            $('#accounts > tbody').empty();
            $.post('../../loadData?type=accounts', function (data) {
                $('h2.data-number.data-account').html(data.length);

                $.each(data, function (i, val) {
                    const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                            .append($('<td>').text(val.accountID))
                            .append($('<td>').text(val.username))
                            .append($('<td>').text(val.accountName))
                            .append($('<td>').text(val.email))
                            .append($('<td>').text(val.phone))
                            .append($('<td>').text((val.accountRole == 1) ? 'Doctor' : 'Patient'));

                    $('#accounts > tbody').append(row);
                });
            })
            break;
        case 'doctors':
            {
                $('#doctors > tbody').empty();
                $.post('../../loadData?type=doctors', function (data) {
                    var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');
                    var aDelete = $('<a class="delete" href=""><i class="fa-solid fa-trash-can text-danger"></i></a>');
                    $('h2.data-number.data-doctor').html(data.length);

                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.username))
                                .append($('<td>').text(val.accountName))
                                .append($('<td>').text(val.email))
                                .append($('<td>').text(val.phone))
                                .append($('<td class="action">'));

                        row.find('td.action')
                                .append(aEdit.clone().attr({'href': '../../loadData?username=' + val.username}))
                                .append(aDelete.clone().attr({'href': '../../manageDoctor?type=delete&username=' + val.username}));

                        $('#doctors > tbody').append(row);
                    });
                });
            }
            break;
        case 'patients':
            {
                $('#patients > tbody').empty();
                $.post('../../loadData?type=patients', function (data) {
                    var aView = $('<a class="view" data-bs-toggle="modal" data-bs-target="#form-view" href=""><i class="fa-solid fa-eye text-primary me-3"></i></a>');
                    $('h2.data-number.data-patient').html(data.length);
                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.username))
                                .append($('<td>').text(val.accountName))
                                .append($('<td>').text(val.email))
                                .append($('<td>').text(val.phone))
                                .append($('<td class="action">'));

                        row.find('td.action')
                                .append(aView.clone().attr({'href': '../../loadData?username=' + val.username}))

                        $('#patients > tbody').append(row);
                    })
                });
            }
            break;
        case 'blogs':
            {
                $('#blogs > tbody').empty();
                $.post('../../loadData?type=blogs', function (data) {
                    var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');
                    var aDelete = $('<a class="delete" href=""><i class="fa-solid fa-trash-can text-danger"></i></a>');

                    $('h2.data-number.data-blog').html(data.length);

                    $.each(data, function (i, val) {
                        const row = $('<tr>')
                                .append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.title))
                                .append($('<td>').text(val.categoryName))
                                .append($('<td>').text(val.authorName))
                                .append($('<td>').text(val.createdDate))
                                .append($('<td>').html((val.status == 1 ? 'Approved<i class="fa-solid fa-circle-check text-success ms-2"></i>' : 'Pending<i class="fa-solid fa-circle-pause text-danger ms-2"></i>')))
                                .append($('<td>').text(val.publishedDate))
                                .append($('<td class="action">'));

                        row.find('td.action')
                                .append(aEdit.clone().attr({'href': '../../loadData?blogID=' + val.blogID}))
                                .append(aDelete.clone().attr({'href': '../../manageBlog?type=delete&blogID=' + val.blogID}));

                        $('#blogs > tbody').append(row);
                    })
                })
            }
            break;
        case 'categories':
            {
                $('#category').empty();
                $('#categoryLabel').empty();
                $.post('../../loadData?type=categories', function (data) {

                    $.each(data, function (i, val) {
                        $('#category').append($('<option value="' + (i + 1) + '">').text(val.categoryName))
                        $('#categoryLabel').append($('<option value="' + (i + 1) + '">').text(val.categoryName))
                    })
                })
            }
            break;
            case 'services': {
                $.post('../../loadData?type=services', function (data) {
                    var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');
    
                    $('#services > tbody').empty();
    
                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.serviceName))
                                .append($('<td>').text('$' + val.price))
                                .append($('<td>').html((val.status == 1 ? 'Available<i class="fa-solid fa-circle-check text-success ms-2"></i>' : 'Disabled<i class="fa-solid fa-ban text-danger ms-2"></i>')))
                                .append($('<td class="action">'));
    
                        row.find('td.action')
                                .append(aEdit.clone().attr({'href': '../../loadData?serviceID=' + val.serviceID}))
    
                        $('#services > tbody').append(row);
                    })
    
                })
            }
            break;
            case 'medicines': {
                $.post('../../loadData?type=medicines', function (data) {
                    var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');
    
                    $('#medicines > tbody').empty();
    
                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.medicineName))
                                .append($('<td>').text(val.brand))
                                .append($('<td class="action">'));
    
                        row.find('td.action')
                                .append(aEdit.clone().attr({'href': '../../loadData?medicineID=' + val.medicineID}))
    
                        $('#medicines > tbody').append(row);
                    })
    
                })
            }
            break;
        default:
            break;
    }
}

// Create doctor
function createDoctor() {
    $("#create").on('shown', function () {
        $('.modal-backdrop').show();
    });

    $('#create').validate();
    $('#username').rules('add', {
        pattern: "^(?=[a-zA-Z]+)\\w{2,20}$",
        messages: {
            pattern: '2-20 characters and accept alphanumeric and underscore only!'
        }
    });
    $('#password').rules('add', {
        pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,50}$",
        messages: {
            pattern: '8-50 characters and contains at least 1 letter and 1 number!'
        }
    });
    $('#create input').on('keyup blur', function () {
        if ($('#create').valid()) {
            $('#create > button').prop('disabled', false);
        } else {
            $('#create > button').prop('disabled', true);
        }
    })

    $('#create').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to create this account?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageDoctor?type=create', $('#create').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create doctor successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('doctors');
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                            $('#create > button').prop('disabled', true);
                        }, 800)
                    } else if (data === "exist") {
                        Swal.fire({
                            icon: 'error',
                            text: 'Username existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Edit doctor
function editDoctor() {
    // Fill data to form edit
    $(document).on('click', 'a.edit', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#edit input#usernameLabel').attr({'value': data.username});
            $('#edit input#accountName').attr({'value': (data.accountName != null ? data.accountName : '')});
            $('#edit input#email').attr({'value': (data.email != null ? data.email : '')});
            $('#edit input#phone').attr({'value': (data.phone != null ? data.phone : '')});
            $('#edit input[name="gender"][value="' + data.gender + '"]').prop('checked', true);
            $('#edit input#address').attr({'value': (data.address != null ? data.address : '')});
            $('#edit input#dob').attr({'value': (data.dob != null ? data.dob : '')});
        });
    })
    // Validate data
    $('#edit').validate({
        rules: {
            accountName: {letterswithbasicpunc: true},
            email: {
                email: true,
                pattern: "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$"
            },
            phone: {pattern: "^0{1}\\d{9}$"},
            address: {pattern: "^(\\d+\\s)?[A-z]+\\s[A-z]+$"}
        }, messages: {
            email: "Invalid email format",
            phone: "Phone must 10 digits only and start with 0"
        }
    });
    $('#edit input').on('keyup blur', function () {
        if ($('#edit').valid()) {
            $('#edit > button').prop('disabled', false);
        } else {
            $('#edit > button').prop('disabled', true);
        }
    })

    // Send data to server
    $('#edit').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to update this account?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageDoctor?type=edit', $('#edit').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Update doctor successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('doctors');
                            $('#edit')[0].reset();
                            $('#form-edit').modal('hide');
                            $('.modal-backdrop').remove();
                            $('#edit > button').prop('disabled', true);
                        }, 800)
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Delete doctor
function deleteDoctor() {
    $(document).on('click', 'a.delete', function (e) {
        e.preventDefault();

        Swal.fire({
            icon: 'warning',
            title: 'Delete doctor',
            text: 'Are you sure to delete this doctor',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post($(this).attr('href'), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            title: 'Delete successful',
                            text: 'Delete doctor successfully!',
                            showConfirmButton: false,
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData("doctors");
                        }, 800);
                    }
                })
            }
        })
    });
}

// View patient
function viewPatient() {
    // Fill data to form view
    $(document).on('click', 'a.view', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#view input#username').attr({'value': data.username});
            $('#view input#accountName').attr({'value': (data.accountName != null ? data.accountName : '')});
            $('#view input#email').attr({'value': (data.email != null ? data.email : '')});
            $('#view input#phone').attr({'value': (data.phone != null ? data.phone : '')});
            $('#view input[name="gender"][value="' + data.gender + '"]').prop('checked', true);
            $('#view input#address').attr({'value': (data.address != null ? data.address : '')});
            $('#view input#dob').attr({'value': (data.dob != null ? data.dob : '')});
        });
    })
}

// Create blog
function createBlog() {
    // Validate data
    $('#create').validate({
        rules: {
            title: {pattern: "^(?=[a-zA-Z]+)[a-zA-Z0-9\\s]{2,30}$"},
            content: {letterswithbasicpunc: true},
        }, messages: {
            title: "Letters, numbers, spaces only (Start with letter, 2 < length < 30)"
        }
    });
    $('#create input,textarea').on('keyup blur', function () {
        if ($('#create').valid()) {
            $('#create > button').prop('disabled', false);
        } else {
            $('#create > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#create').submit(function (e) {
        e.preventDefault();
        var formData = new FormData($('#create')[0]);

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to create this blog?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../../manageBlog?type=create',
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    data: formData
                }).done(function (data) {
                    if (data === 'success') {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create blog successfully!',
                            timer: 800,
                        });
                        setTimeout(function () {
                            loadData("blogs");
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800);
                    } else if (data === 'exist') {
                        Swal.fire({
                            icon: 'error',
                            text: 'Title existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Edit blog
function editBlog() {
    // Fill exist data to form
    $(document).on('click', 'a.edit', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#edit input#blogID').attr('value', data.blogID);
            $('#edit input#titleLabel').attr('value', data.title);
            $('#edit select#categoryLabel option[value="' + data.categoryID + '"]').prop("selected", true);
            $('#edit img#thumbPreview').attr('src', '../../assets/img/blogs/' + data.thumbnails)
            $('#edit textarea#contentLabel').val(data.content);
            $('#edit input[name="status"][value="' + data.status + '"]').prop('checked', true);
        })
    })

    // Validate data
    $('#edit').validate({
        rules: {
            title: {pattern: "^(?=[a-zA-Z]+)[a-zA-Z0-9\\s]{2,30}$"},
            content: {letterswithbasicpunc: true},
        }, messages: {
            title: "Letters, numbers, spaces only (Start with letter, 2 < length < 30)"
        }
    });
    $('#edit input,textarea').on('keyup blur', function () {
        if ($('#edit').valid()) {
            $('#edit > button').prop('disabled', false);
        } else {
            $('#edit > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#edit').submit(function (e) {
        e.preventDefault();
        var formData = new FormData($('#edit')[0]);

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to edit this blog?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../../manageBlog?type=edit',
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    data: formData
                }).done(function (data) {
                    if (data === 'success') {
                        Swal.fire({
                            icon: 'success',
                            text: 'Edit blog successfully!',
                            timer: 800,
                        });
                        setTimeout(function () {
                            loadData("blogs");
                            $('#edit')[0].reset();
                            $('#form-edit').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800);
                    } else if (data === 'exist') {
                        Swal.fire({
                            icon: 'error',
                            text: 'Title existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Delete blog
function deleteBlog() {
    $(document).on('click', 'a.delete', function (e) {
        e.preventDefault();

        Swal.fire({
            icon: 'warning',
            title: 'Delete blog',
            text: 'Are you sure to delete this blog?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post($(this).attr('href'), function (data) {
                    if (data === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Delete successful',
                            text: 'Delete blog successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData("blogs");
                        }, 1000);
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side!',
                            timer: 800
                        });
                    }
                })
            }
        })
    })
}

// Create service
function createService() {
    // Validate data
    $('#create').validate({
        rules : {
            serviceName: {letterswithbasicpunc:true},
            price:{range:[1000, 10000]}
        }
    });
    $('#create input').on('keyup blur', function () {
        if ($('#create').valid()) {
            $('#create > button').prop('disabled', false);
        } else {
            $('#create > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#create').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to create this service?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageService?type=create', $('#create').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create service successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('services');
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800)
                    } else if (data === "exist") {
                        Swal.fire({
                            icon: 'error',
                            text: 'Username existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Edit service
function editService() {
    // Fill exist data to form
    $(document).on('click', 'a.edit', function (e) {
        $.post($(this).attr('href'), function (data) {
            $('#edit input#serviceID').attr('value', data.serviceID);
            $('#edit input#nameLabel').attr('value', data.serviceName);
            $('#edit input#priceLabel').attr('value', data.price);
            $('#edit input[name="status"][value="' + data.status + '"]').prop('checked', true);
        })
    });

    // Validate data
    $('#edit').validate({
        rules : {
            serviceName: {letterswithbasicpunc:true},
            price:{range:[1000, 10000]}
        }
    });
    $('#edit input').on('keyup blur', function () {
        if ($('#edit').valid()) {
            $('#edit > button').prop('disabled', false);
        } else {
            $('#edit > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#edit').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to edit this service?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageService?type=edit', $('#edit').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Edit service successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('services');
                            $('#edit')[0].reset();
                            $('#form-edit').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800)
                    } else if (data === "exist") {
                        Swal.fire({
                            icon: 'error',
                            text: 'Service existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Create medicine
function createMedicine() {
    // Validate data
    $('#create').validate({
        rules : {
            serviceName: {letterswithbasicpunc:true},
            brand: {lettersonly: true}
        }
    });
    $('#create input').on('keyup blur', function () {
        if ($('#create').valid()) {
            $('#create > button').prop('disabled', false);
        } else {
            $('#create > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#create').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to create this medicine?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageMedicine?type=create', $('#create').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create medicine successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('medicines');
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800)
                    } else if (data === "exist") {
                        Swal.fire({
                            icon: 'error',
                            text: 'Medicine name existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Edit medicine
function editMedicine() {
    // Fill exist data to form
    $(document).on('click', 'a.edit', function (e) {
        $.post($(this).attr('href'), function (data) {
            $('#edit input#medicineID').attr('value', data.medicineID);
            $('#edit input#nameLabel').attr('value', data.medicineName);
            $('#edit input#brandLabel').attr('value', data.brand);
            $('#edit input#descriptionLabel').attr('value', data.description);
        })
    });

    // Validate data
    $('#edit').validate({
        rules : {
            medicineName: {letterswithbasicpunc:true},
            brand: {lettersonly: true},
            description: {letterswithbasicpunc:true}
        }
    });
    $('#edit input').on('keyup blur', function () {
        if ($('#edit').valid()) {
            $('#edit > button').prop('disabled', false);
        } else {
            $('#edit > button').prop('disabled', true);
        }
    });

    // Send data to server
    $('#edit').submit(function (e) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to edit this medicine?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageMedicine?type=edit', $('#edit').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Edit medicine successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('medicines');
                            $('#edit')[0].reset();
                            $('#form-edit').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800)
                    } else if (data === "exist") {
                        Swal.fire({
                            icon: 'error',
                            text: 'Medicine name existed!'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side'
                        });
                    }
                })
            }
        })
    })
}

// Reset form after hidden
function resetForm() {
    $(".modal").on("shown.bs.modal", function () {
        if ($(".modal-backdrop").length >= 1) {
            $(".modal-backdrop").not(':first').remove();
        }
    })

    $('#form-create').on('hidden.bs.modal', function () {
        $('#create')[0].reset();
        $('#create > button').prop('disabled', true);
    });

    $('#form-edit').on('hidden.bs.modal', function () {
        $('#edit')[0].reset();
        $('#edit > button').prop('disabled', true);
    });

    $('#form-view').on('hidden.bs.modal', function () {
        $('#view')[0].reset();
    });
}


// Manage doctor
function manageDoctor() {
    createDoctor();
    resetForm();
    editDoctor();
    deleteDoctor();
}

// Manage blog
function manageBlog() {
    // Preview img before upload
    $('#thumbnails').change(function () {
        const file = this.files[0];

        if (file) {
            let reader = new FileReader();
            reader.onload = function (event) {
                $('#thumbnailsPreview').attr('src', event.target.result);
                $('#thumbnailsPreview').css({"width": "88%", "height": "50%"});
                $('#thumbnailsPreview').show();
            }
            reader.readAsDataURL(file);
        }
    });

    $('#thumbLabel').change(function () {
        const file = this.files[0];

        if (file) {
            let reader = new FileReader();
            reader.onload = function (event) {
                $('#thumbPreview').attr('src', event.target.result);
                $('#thumbPreview').css({"width": "88%", "height": "50%"});
                $('#thumbPreview').show();
            }
            reader.readAsDataURL(file);
        }
    });

    createBlog();
    resetForm();
    editBlog();
    deleteBlog();
}

function manageService() {
    createService();
    resetForm();
    editService();
}

function manageMedicine() {
    createMedicine();
    resetForm();
    editMedicine();
}
