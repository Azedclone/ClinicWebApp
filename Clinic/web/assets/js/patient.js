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

    $.get('../../view/patient/' + href, function (data) {
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
                var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');
                $.each(data, function (i, val) {
                    const row = $('<tr>').append($('<th scope="row">').text(i + 1))
                        .append($('<td>').text(val.bookedDate))
                        .append($('<td>').text('Slot ' + val.slotID))
                        .append($('<td>').text(val.doctorName))
                        .append($('<td>').text('$8'))
                        .append($('<td class="action">'));

                    row.find('td.action')
                        .append(aEdit.clone().attr({'href': '../../loadData?appointmentID=' + val.appointmentID}));

                $('#appointments > tbody').append(row);
                });
            })
            break;
            case 'examinations':
        {
            $('examinations tbody#accordion').empty();
            
            var aEdit = $('<a class="edit" data-bs-toggle="modal" data-bs-target="#form-edit" href=""><i class="fa-solid fa-pen text-dark me-3"></i></a>');

             $('#examinations > tbody').empty();

             $.post('../../loadData?type=examinations', function (data){

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
        default:
            break;
    }
}

function createAppointment() {
    // Validate data
    $('#create').validate({
        rules: {
            sympton: {letterswithbasicpunc: true},
            message: {letterswithbasicpunc: true}
        }
    });
    $('#create input').on('keyup blur', function () {
        if ($('#create').valid()) {
            $('#create > button').prop('disabled', false);
        } else {
            $('#create > button').prop('disabled', true);
        }
    });

    $('#create').submit(function(e){
        e.preventDefault();

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to create appointment?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if(result.isConfirmed) {
                $.post('../../manageAppointment?type=create', $('#create').serialize(), function(data){
                    switch(data) {
                        case 'success': {
                            Swal.fire({
                                icon: 'success',
                                text: 'Create appointment successfully!',
                                timer: 800
                            });
                            setTimeout(function () {
                                loadData("appointments");
                                $('#create')[0].reset();
                                $('#form-create').modal('hide');
                                $('.modal-backdrop').remove();
                            }, 800);
                        }
                        break;
                        case 'n/a': {
                            Swal.fire({
                                icon: 'error',
                                text: 'Sorry but there are not any doctor available!, please schedule another day or slot!'
                            });
                        }
                        break;
                        case 'duplicate': {
                            Swal.fire({
                                icon: 'error',
                                text: 'You already have an appointment in that time!'
                            });
                        }
                        break;
                        default:{
                            Swal.fire({
                                icon: 'error',
                                text: 'Error in server side!'
                            });
                        }
                            break;
                    }
                })
            }
        })
    });
}

function editAppointment() {
    // Load available data to form
    $(document).on('click', 'a.edit', function (e) {
        e.preventDefault();

        $.post($(this).attr('href'), function (data) {
            $('#edit input#appointmentIDLabel').attr('value', data.appointmentID);
            $('#edit input#symptonLabel').attr('value', data.sympton);
            $('#edit textarea#messageLabel').val(data.message);
        })
    });

    // Validate data
    $('#edit').validate({
        rules: {
            sympton: {letterswithbasicpunc: true},
            message: {letterswithbasicpunc: true}
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
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to edit this appointment?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../manageAppointment?type=edit', $('#edit').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Edit appointment successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadData('appointments');
                            $('#edit')[0].reset();
                            $('#form-edit').modal('hide');
                            $('.modal-backdrop').remove();
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
    createAppointment();
    resetForm();
    editAppointment();
}