var animationEnd = (function (el) {
    var animations = {
        "animation": "animationend",
        "OAnimation": "oAnimationEnd",
        "MozAnimation": "mozAnimationEnd",
        "WebkitAnimation": "webkitAnimationEnd"
    };

    for (var t in animations) {
        if (el.style[t] !== undefined) {
            return animations[t];
        }
    }
})(document.createElement("fakeelement"));

$(document).ready(function () {
    // Init toast
    $('.toast').toast();

    // Init date picker
    $('.datepicker').pickadate({
        format: 'dd/mm/yyyy'
    });

    // Init time picker
    $('.timepicker').pickatime({
        twelvehour: true
    });

    // Active navbar link
    let currUrl = window.location.href;
    let checkUrl = currUrl.slice(currUrl.indexOf('localhost'));

    if (checkUrl === hostUrl || checkUrl === `${hostUrl}/`) {
        $('.navbar-nav.main-nav a[href="default.aspx"]').parent().addClass('active');
    }
    else {
        let href = currUrl.slice(currUrl.lastIndexOf('/') + 1);
        $(`.navbar-nav.main-nav a[href="${href}"]`).parent().addClass('active');
    }

    // md-outline label fix
    $('.md-outline').each(function () {
        if ($(this).find('input').val()) {
            $(this).find('label').addClass('active');
        }
    });

    // btn-block fix
    $('span.waves-input-wrapper.waves-effect.waves-light').each(function () {
        if ($(this).find('.btn.btn-block').length !== 0) {
            $(this).addClass('btn-block');
        }
    });

    // Random gradient
    randomGradient('.random-gradient');
});

function toastSuccess(msg, title = null, duration = null) {
    toastr.success(msg, title, {
        closeButton: true,
        progressBar: true,
        timeOut: duration !== null ? duration : 5000
    });
}

function toastDanger(msg, title = null, duration = null) {
    toastr.error(msg, title, {
        closeButton: true,
        progressBar: true,
        timeOut: duration !== null ? duration : 5000
    });
}

function showModal(modalId) {
    $(modalId).modal('show');
}

function randomGradient(target) {
    $(target).each(function () {
        let card = $(this);
        $.getJSON("js/gradients.json", function (data) {
            let element = data[Math.floor(Math.random() * 100)];
            console.log(element.name);

            card.css("background", "-webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, " + element.colors[0] + "), color-stop(100%, " + element.colors[1] + "))");
            card.css("background", "-webkit-linear-gradient(left, " + element.colors[0] + " 0%," + element.colors[1] + " 100%)");
            card.css("background", "-moz-linear-gradient(left, " + element.colors[0] + " 0%," + element.colors[1] + " 100%)");
            card.css("background", "-o-linear-gradient(left, " + element.colors[0] + " 0%," + element.colors[1] + " 100%)");
            card.css("background", "linear-gradient(left, " + element.colors[0] + " 0%," + element.colors[1] + " 100%)");
        });
    });
}