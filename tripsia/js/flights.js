﻿$(document).ready(function () {
    $('#flightsTable').DataTable({
        pageLength: 25
    });

    $('.dataTables_length').addClass('bs-select');

    $('th.sorting').css("font-family", "Font Awesome 5 Pro");
});