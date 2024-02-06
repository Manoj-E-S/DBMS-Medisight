$("#doctorRegisterForm").submit((event) => {
    event.preventDefault();

    let sendData = {
        departmentId: Number($("#departmentId").val()),
        doctorName: $("#doctorName").val(),
        doctorPhno: $("#doctorPhno").val(),
        doctorOfficeNo: $("#doctorOfficeNo").val(),
        doctorOfficeAddress: $("#doctorOfficeAddress").val(),
    };

    $.ajax({
        type: 'POST',
        url: "/registerDoctor",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(sendData),
        success: function (res) {
            alert("Registered Successfully");
            window.location.href = '/';
        },
        failure: function (err) {
            alert("Registration Failed");
            console.error(err);
        }
    });
});

$("#cancelRegister").click(() => {
    window.location.href = '/';
});