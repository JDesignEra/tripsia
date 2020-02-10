$(document).ready(function () {
    $(setCountryBtnCid).on('click', function () {
        toastSuccess('Populating hotel lists, it may take some time.');
    });
});

function leaveReviewBtn_OnClick(el) {
    $(idTxtBoxCid).val($(el).attr('data-id'));
}