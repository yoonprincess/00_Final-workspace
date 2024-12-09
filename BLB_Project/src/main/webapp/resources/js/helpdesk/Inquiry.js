

$(function () {
    $("#inquiryList>tbody>tr").click(function () {
        const ino = $(this).children(".ino").text();
        if (ino) {
            location.href = "inquiry/" + ino;
        }
    });
});


