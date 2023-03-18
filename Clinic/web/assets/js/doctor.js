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
            case 'patients': {
                $('#patients').empty();
                $.post('../../loadData?type=patients', function (data) {
                    $.each(data, function (i, val) {
                        $('#patients').append($('<option value="' + (val.accountID) + '">').text(val.accountName));
                    })
                })
            }
            break;
            case 'services': {
                $('#services').empty();
                $.post('../../loadData?type=services', function (data) {
                    $.each(data, function (i, val) {
                        $('#services').append($($('<label class="me-3"><input type="checkbox" name="service" value="'+ val.serviceID +'" class="form-check-input me-2">' + val.serviceName + '</label>')));
                    })
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
function createExamination(){
    $('#create').submit(function(e){
        e.preventDefault();

        Swal.fire({
            icon: 'question',
            title: 'Confirmation',
            text: 'Are you sure to create this examination?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result =>{
            if (result.isConfirmed) {
                $.post('../../manageExamination?type=create', $('#create').serialize(), function(data){
                    if (data === 'success'){
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