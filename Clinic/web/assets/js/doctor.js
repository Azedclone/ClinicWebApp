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

    $.get('../../view/doctor/' + href, function (data) {
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
        case 'appointments':
            $('#appointments > tbody').empty();
            $.post('../../loadData?type=appointments', function (data) {
                var aView = $('<a class="view" data-bs-toggle="modal" data-bs-target="#form-view" href=""><i class="fa-solid fa-eye text-primary me-3"></i></a>');
                $.each(data, function (i, val) {
                    const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                            .append($('<td>').text(val.bookedDate))
                            .append($('<td>').text('Slot ' + val.slotID))
                            .append($('<td>').text(val.patientName))
                            .append($('<td>').text('$8'))
                            .append($('<td class="action">'));

                    row.find('td.action')
                            .append(aView.clone().attr({'href': '../../loadData?appointmentID=' + val.appointmentID}));

                    $('#appointments > tbody').append(row);
                });
            })
            break;
        case 'patients':
            {
                $('#patients').empty();
                $.post('../../loadData?type=patients', function (data) {
                    $.each(data, function (i, val) {
                        $('#patients').append($('<option value="' + (val.accountID) + '">').text(val.accountName));
                    })
                })
            }
            break;
        case 'services':
            {
                $('#services').empty();
                $.post('../../loadData?type=services', function (data) {
                    $.each(data, function (i, val) {
                        $('#services').append($($('<label class="me-3"><input type="checkbox" name="service" value="' + val.serviceID + '" class="form-check-input me-2">' + val.serviceName + '</label>')));
                    })
                })
            }
            break;
        case 'examinations':
            {
                var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');

                $('#examinations > tbody').empty();

                $.post('../../loadData?type=examinations', function (data) {

                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.patientName))
                                .append($('<td>').text(val.serviceName))
                                .append($('<td>').text(val.createdDate))
                                .append($('<td>').html((val.status == 1 ? 'Paid<i class="fa-solid fa-circle-check text-success ms-2"></i>' : 'Not paid<i class="fa-solid fa-circle-pause text-danger ms-2"></i>')))
                                .append($('<td class="action">'));

                        row.find('td.action')
                                .append(aEdit.clone().attr({'href': '../../loadData?examinationID=' + val.examinationID}));

                        $('#examinations > tbody').append(row);
                    });
                })
            }
            break;
            case 'medicines' : {
                $('#medicines').empty();
                $.post('../../loadData?type=medicines', function (data) {
                    $.each(data, function (i, val) {
                        $('#medicines').append($($('<label class="me-3"><input type="checkbox" name="medicine" value="' + val.medicineID + '" class="form-check-input me-2">' + val.medicineName + '</label>')));
                    })
                })
            }
            break;
            case 'prescriptions':
            {
                var aView = $('<a class="view" data-bs-toggle="modal" data-bs-target="#form-view" href=""><i class="fa-solid fa-eye text-primary me-3"></i></a>');

                $('#prescriptions > tbody').empty();

                $.post('../../loadData?type=prescriptions', function (data) {
                    $.each(data, function (i, val) {
                        const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                                .append($('<td>').text(val.patientName))
                                .append($('<td>').text(val.medicineName))
                                .append($('<td>').text(val.createdDate))
                                .append($('<td class="action">'));

                        row.find('td.action')
                                .append(aView.clone().attr({'href': '../../loadData?prescriptionID=' + val.prescriptionID}));

                        $('#prescriptions > tbody').append(row);
                    });
                })
            }
            break;
        default:
            break;
    }
}

// View appointment
function viewAppointment() {
    // Load available data to form
    $(document).on('click', 'a.view', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#view input#appointmentIDLabel').attr('value', data.appointmentID);
            $('#view input#symptonLabel').attr('value', data.sympton);
            $('#view textarea#messageLabel').val(data.message);
        })
    });
}

// Create examination
function createExamination() {
    //Send data 
    $('#create').submit(function (e) {
        e.preventDefault();

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to create this examination?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageExamination?type=create', $('#create').serialize(), function (data) {
                    if (data === 'success') {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create examination successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData("examinations");
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800);
                    }
                })
            }
        })
    })
}

// Edit examination
function editExamination() {
    // Load data to form
    $(document).on('click', 'a.edit', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#edit input#examinationID').attr('value', data.examinationID);
            $('#edit input#patientName').attr('value', data.patientName);
            $('#edit input#serviceName').attr('value', data.serviceName);
            $('#edit textarea#result').attr('value', data.result);
            $('#edit input[name="status"][value="' + data.status + '"]').prop('checked', true);
        });

        // Validate data
        $('#edit').validate({
            rules: {
                result: {letterswithbasicpunc: true}
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
    
            Swal.fire({
                icon: 'question',
                title: 'Confirmation',
                text: 'Are you sure to update this examination?',
                showCancelButton: true,
                confirmButtonText: 'Yes'
            }).then(result => {
                if (result.isConfirmed) {
                    $.post('../../manageExamination?type=edit', $('#edit').serialize(), function(data){
                        if (data === 'success'){
                            Swal.fire({
                                icon: 'success',
                                text: 'Update examination successfully!',
                                timer: 800
                            });
                            setTimeout(function () {
                                loadData("examinations");
                                $('#edit')[0].reset();
                                $('#form-edit').modal('hide');
                                $('.modal-backdrop').remove();
                            }, 800);
                        } else {
                            Swal.fire({
                                icon: 'error',
                                text: 'Error in server side!'
                            });
                        }
                    })
                }
            });
        })
    });
}


// Create prescription
function createPrescription() {
    //Send data 
    $('#create').submit(function (e) {
        e.preventDefault();

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to create this prescription?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../managePrescription?type=create', $('#create').serialize(), function (data) {
                    if (data === 'success') {
                        Swal.fire({
                            icon: 'success',
                            text: 'Create prescription successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData("prescriptions");
                            $('#create')[0].reset();
                            $('#form-create').modal('hide');
                            $('.modal-backdrop').remove();
                        }, 800);
                    } else {
                        Swal.fire({
                            icon: 'error',
                            text: 'Error in server side!'
                        });
                    }
                })
            }
        })
    })
}

// View prescripiton
function viewPrescription(){
    // Load data to form view
    $(document).on('click', 'a.view', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#view textarea#instructionLabel').val(data.instruction);
        });
}
)};

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

// Manage appointments
function manageAppointment() {
    resetForm();
    viewAppointment();
}

function manageExamination() {
    createExamination();
    resetForm();
    editExamination();
}

function managePrescription() {
    createPrescription();
    viewPrescription();
}