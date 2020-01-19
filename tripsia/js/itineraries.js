$(document).ready(function () {
    // editModeBtn
    $('#editModeBtn').on('click', function () {
        $('#defaultState').addClass('animated fadeOut faster').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated fadeOut faster');

            let doneEditBtn = $('#doneEditBtn');

            doneEditBtn.removeClass('d-none')
            doneEditBtn.addClass('animated fadeIn faster').one(animationEnd, function () {
                $(this).removeClass('animated fadeIn faster');
            });
        });

        $('.card-footer .default-state').addClass('animated flipOutX fast').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated flipOutX fast');

            let editState = $('.card-footer .edit-state button');

            editState.removeClass('d-none');
            editState.addClass('animated fadeInDown faster').one(animationEnd, function () {
                $(this).addClass('animated fadeInDown faster');
            });
        });
    });

    // doneEditBtn
    $('#doneEditBtn').on('click', function () {
        $(this).addClass('animated fadeOut faster').one(animationEnd, function () {
            $(this).addClass('d-none');
            $(this).removeClass('animated fadeOut faster');

            let defaultState = $('#defaultState');

            defaultState.removeClass('d-none');
            defaultState.addClass('animated fadeIn faster').one(animationEnd, function () {
                $(this).removeClass('animated fadeIn faster');
            });

            $('.card-footer .edit-state button').addClass('animated flipOutX fast').one(animationEnd, function () {
                $(this).addClass('d-none');
                $(this).removeClass('animated flipOutX fast');

                let editState = $('.card-footer .default-state');

                editState.removeClass('d-none');
                editState.addClass('animated fadeInDown faster').one(animationEnd, function () {
                    $(this).addClass('animated fadeInDown faster');
                });
            });
        });
    });

    // Delete Modal Button
    $('button[data-target="#delModal"').on('click', function () {
        let id = $(this).attr('data-id');
        let title = $(this).attr('data-title');
        let modal = $('#delModal');

        modal.find(delIdClientId).val(id);
        modal.find(delTitleClientId).val(title);
        modal.find('.modal-title').html(`<i class="fas fa-trash-alt mr-1"></i> DELETE ${title.toUpperCase()} ITINERARY`);
        modal.find('.modal-body').text(`Are you sure you want to delete ${title} itinerary?`);
    });

    // Edit Modal Button
    $('button[data-target="#editModal"]').on('click', function () {
        let id = $(this).attr('data-id');
        let title = $(this).attr('data-title');
        let desc = $(this).attr('data-desc');
        let modal = $('#editModal');

        modal.find(editIdClientId).val(id);

        modal.find(editTitleClientId).val(title);
        modal.find(editTitleClientId).next().addClass('active');

        if (desc !== "") {
            modal.find(editDescClientId).val(desc);
            modal.find(editDescClientId).next().addClass('active');
        }
    });
});