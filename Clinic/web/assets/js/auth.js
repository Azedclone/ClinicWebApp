const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 1000,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

//Login
function login() {
    $('#login').submit((event) => {
        event.preventDefault();

        $.post('../../auth?type=login', $('#login').serialize(), function (data) {
            switch (data) {
                case 'success':
                    {
                        Toast.fire({
                            icon: 'success',
                            title: 'Login successfully!'
                        });
                        setTimeout(() => {
                            window.location.href = "../common/home.jsp";
                        }, 1000);
                    }
                    break;
                case 'wrong':
                    {
                        Toast.fire({
                            icon: 'error',
                            title: 'Wrong password or username!'
                        });
                    }
                    break;
                default:
                    {
                        Toast.fire({
                            icon: 'error',
                            title: 'Error in server side!'
                        });
                    }
                    break;
            }
        })
    })
}

//Logout
function logout() {
    $(document).on('click', 'a#logout', function (e) {
        e.preventDefault();

        $.post('../../auth?type=logout');

        Toast.fire({
            icon: 'success',
            title: 'Logout successfully!'
        });
        setTimeout(() => {
            window.location.reload();
        }, 1000);
    });
}

//Register
function register() {
    $('#register').validate({
        rules: {
            passwordConfirm: {
                equalTo: '#password'
            }
        },
        messages: {
            passwordConfirm: 'Not match password'
        }
    });
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

    $('#register input').on('keyup blur', function () {
        if ($('#register').valid()) {
            $('#register > div > button').prop('disabled', false);
        } else {
            $('#register > div > button').prop('disabled', true);
        }
    })

    $('#register').submit(function (e) {
        e.preventDefault();

        $.post('../../auth?type=register', $('#register').serialize(), function (data) {
            switch (data) {
                case 'success':
                    {
                        Toast.fire({
                            icon: 'success',
                            title: 'Register successfully!'
                        });
                        setTimeout(() => {
                            window.location.href = "login.jsp";
                        }, 1000);
                    }
                    break;
                case 'exist':
                    {
                        Swal.fire({
                            icon: 'error',
                            title: 'Account existed!'
                        })
                    }
                    break;
                default:
                    {
                        Toast.fire({
                            icon: 'error',
                            title: 'Error in server side!'
                        })
                    }
                    break;
            }
        })
    });
}

// Forgot password
function forgot() {
    $('#forgot').validate({
        rules: {
            email: {
                email: true
            }
        }
    });

    $('#forgot').submit(function (e) {
        e.preventDefault();

        $.post('../../auth?type=forgot', $('#forgot').serialize(), function (data) {
            switch (data) {
                case 'success':
                    {
                        Swal.fire({
                            icon: 'success',
                            title: 'Reset password successfully!',
                            text: 'Please check your mail to see new password!'
                        });
                    }
                    break;
                case '!exist':
                    {
                        Toast.fire({
                            icon: 'error',
                            title: 'Username not exist!'
                        })
                    }
                    break;
                case '!link':
                    {
                        Swal.fire({
                            icon: 'error',
                            title: 'This mail does not link to your account!'
                        });
                    }
                    break;
                default:
                {
                    Toast.fire({
                        icon: 'error',
                        title: 'Error in server side!'
                    })
                }
            }
        })
    })

    $('#forgot input').on('keyup blur', function () {
        if ($('#forgot').valid()) {
            $('#forgot > div > button').prop('disabled', false);
        } else {
            $('#forgot > div > button').prop('disabled', true);
        }
    })
}