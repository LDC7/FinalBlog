﻿$(function () {
    $.ajaxSetup({ cache: false });
    $(".openModalView").click(function (e) {
        e.preventDefault();
        $.get(this.href, function (data) {
            $('#dialogContent').html(data);
            $('#modDialog').modal('show');
        });
    });
})