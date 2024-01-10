import { socket } from "./modules/utilities.js";

var symptomList = [];

$("#addNewSymptomBtn").click(() => {
    socket.emit('incrementSelectElementCount');
    window.location.reload();
});

$(".del-symptom-btn").click((event) => {
    var buttonId = $(event.target).attr('id');
    var symptomDivId = $(`#${buttonId}`).prev().attr("id");
    $(`#${buttonId}`).remove();
    $(`#${symptomDivId}`).remove();
    socket.emit('decrementSelectElementCount');
    window.location.reload();
});

$("#symptomSelector").submit((event) => {
    event.preventDefault();
    $(".select-symptoms").each((index, item) => {
        symptomList.push($(item).val())
    });
    console.log(symptomList);
    $.ajax({
        type: 'POST',
        url: "/showCancers",
        data: symptomList,
        dataType: "text",
        success: function(resultData) { alert("Save Complete") }
    });
});

