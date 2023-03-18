<section id="profile">
    <div class="profile-header">
        <div class="title text-center text-dark">Hello, ${currentAccount.accountName}</div>
    </div>
    <div class="profile-body">
        <div class="profile-avatar text-center">
            <img src="../../assets/img/avatars/default.png" alt="">
            <h2 class="profile-username mt-3">${currentAccount.username}</h2>

            <!-- Form change infomation -->
            <div class="contaier-fluid">
                <div class="container p-3 w-50">
                    <form id="edit" class="row">
                        <div class="mb-3 px-3 col-6">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                            <br>
                            <input type="checkbox" onclick="showPassword('password')"> Show password
                        </div>
                        <div class="mb-3 px-3 col-6">
                            <label for="cfPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="cfPassword" name="passwordConfirm">
                            <br>
                            <input type="checkbox" onclick="showPassword('cfPassword')"> Show confirm password
                        </div>
                        <div class="mb-3 px-3">
                            <label for="accountName" class="form-label">Name</label>
                            <input type="text" class="form-control" id="accountName" name="accountName" required>
                        </div>
                        <div class="mb-3 px-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" aria-describedby="emailDes" id="email" name="email">
                            <div id="emailDes" class="form-text">
                                * Link email to account to reset password when you forgot
                            </div>
                        </div>
                        <div class="mb-3 px-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                        <div>
                            <label for="gender" class="me-3">Gender:</label>
                            <div class="form-check form-check-inline mb-3 me-2" id="gender">
                                <input class="form-check-input" type="radio" name="gender" id="male" value="0">
                                <label class="form-check-label" for="male">
                                    Male
                                </label>
                            </div>
                            <div class="form-check form-check-inline mb-3 me-2">
                                <input class="form-check-input" type="radio" name="gender" id="female" value="1">
                                <label class="form-check-label" for="female">
                                    Female
                                </label>
                            </div>
                            <div class="form-check form-check-inline mb-3">
                                <input class="form-check-input" type="radio" name="gender" id="other" value="2">
                                <label class="form-check-label" for="other">
                                    Other
                                </label>
                            </div>
                        </div>
                        <div class="mb-3 px-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                        <div class="mb-3 px-3">
                            <label for="dob" class="form-label">DOB</label>
                            <input type="date" class="form-control" id="dob" value="" name="dob" max="2000-01-01" min="1924-01-01" required>
                        </div>
                        <div class="text-center">
                            <p class="text-danger">* Please edit your infomation carefully!</p>
                            <button type="submit" class="btn btn-primary px-3" disabled>Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    function showPassword(passwordFieldId) {
        var passwordField = $("#" + passwordFieldId);
        if (passwordField.attr("type") === "password") {
            passwordField.attr("type", "text");
        } else {
            passwordField.attr("type", "password");
        }
    }

    function loadProfile() {
        // Load data to form
        $.post('../../loadData?username=${currentAccount.username}', function(data){
            $('#edit input#accountName').attr({'value': (data.accountName != null ? data.accountName : '')});
            $('#edit input#email').attr({'value': (data.email != null ? data.email : '')});
            $('#edit input#phone').attr({'value': (data.phone != null ? data.phone : '')});
            $('#edit input[name="gender"][value="' + data.gender + '"]').prop('checked', true);
            $('#edit input#address').attr({'value': (data.address != null ? data.address : '')});
            $('#edit input#dob').attr({'value': (data.dob != null ? data.dob : '')});
        })
    }
    loadProfile();
    // Validate data
    $('#edit').validate({
        rules: {
            password: {pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,50}$"},
            accountName: {letterswithbasicpunc: true},
            email: {
                email: true,
                pattern: "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$"
            },
            phone: {pattern: "^0{1}\\d{9}$"},
            address: {pattern: "^(\\d+\\s)?[A-z]+\\s[A-z]+$"},
            passwordConfirm: {equalTo: '#password'}
        }, messages: {
            email: "Invalid email format",
            phone: "Phone must 10 digits only and start with 0",
            password: "8-50 characters and contains at least 1 letter and 1 number!",
            passwordConfirm: "Not match"
        }
    });
    $('#edit input').on('keyup blur', function () {
        if ($('#edit').valid()) {
            $('#edit div > button').prop('disabled', false);
        } else {
            $('#edit div > button').prop('disabled', true);
        }
    })

    // Send data
    $('#edit').submit(function (e){
        e.preventDefault();

        Swal.fire({
            icon: 'warning',
            title: 'Confirmation',
            text: 'Are you sure to update infomation?',
            showCancelButton: true,
            confirmButtonText: 'Yes'
        }).then(result => {
            if (result.isConfirmed) {
                $.post('../../auth?type=edit&username=${currentAccount.username}', $('#edit').serialize(), function (data) {
                    if (data === "success") {
                        Swal.fire({
                            icon: 'success',
                            text: 'Update infomation successfully!',
                            timer: 800
                        });
                        setTimeout(function () {
                            loadProfile();
                            $('#edit')[0].reset();
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
</script>