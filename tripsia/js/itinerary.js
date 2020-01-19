$(document).ready(function () {
    // Edit Mode Button
    $('#editModeBtn').on('click', function () {
        $('.default-state').addClass('animated fadeOut faster').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated fadeOut faster');

            let editState = $('.edit-state');

            editState.removeClass('d-none');
            editState.addClass('animated fadeIn faster').one(animationEnd, function () {
                $(this).removeClass('animated fadeIn faster');
            });
        });

        let cardFooter = $('.card-footer');

        cardFooter.removeClass('d-none');
        cardFooter.addClass('animated fadeInDown faster').one(animationEnd, function () {
            $(this).removeClass('animated fadeInDown faster');
        });
    });

    // Done Editing Mode Button
    $('#doneEditBtn').on('click', function () {
        $('.edit-state').addClass('animated fadeOut faster').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated fadeOut faster');

            let defaultState = $('.default-state');

            defaultState.removeClass('d-none');
            defaultState.addClass('animated fadeIn faster').one(animationEnd, function () {
                $(this).removeClass('animated fadeIn faster');
            });
        });

        $('.card-footer').addClass('animated flipOutX fast').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated flipOutX fast');
        });
    });

    // Edit Modal Button
    $('button[data-target="#editModal"]').on('click', function () {
        let id = $(this).attr('data-id');
        let date = $(this).attr('data-date');
        let time = $(this).attr('data-time');
        let title = $(this).attr('data-title');
        let desc = $(this).attr('data-desc');

        $(editIdClientId).val(id);

        $(editDateClientId).val(date);
        $(editDateClientId).parent().find('label').addClass('active');

        $(editTimeClientId).val(time);
        $(editTimeClientId).next().addClass('active');

        $(editTitleClientId).val(title);
        $(editTitleClientId).next().addClass('active');

        if (desc !== "") {
            $(editDescClientId).val(desc);
            $(editDescClientId).next().addClass('active');
        }
        else {
            $(editDescClientId).val('');
            $(editDescClientId).next().removeClass('active');
        }
    });

    // Delete Modal Button
    $('button[data-target="#delModal"]').on('click', function () {
        let id = $(this).attr('data-id');
        let title = $(this).attr('data-title');
        let modal = $('#delModal');

        console.log(title);

        $(delIdClientId).val(id);
        $(delTitleClientId).val(title);
        modal.find('.modal-title').html(`<i class="fas fa-trash-alt mr-1"></i> DELETE ${title.toUpperCase()} SCHEDULE`);
        modal.find('.modal-body').text(`Are you sure you want to delete ${title} schedule?`);
    });
});