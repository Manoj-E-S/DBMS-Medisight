import { socket } from "./modules/utilities.js";

$("#addNewSymptomBtn").click(() => {
    socket.emit('incrementSelectElementCount');
    window.location.reload();
});

$(".del-symptom-btn").click((event) => {
    var buttonId = $(event.target).attr('id');
    var symptomDivId = $(`#${buttonId}`).prev().attr("id");
    $(`#${buttonId}`).remove();
    $(`#${symptomDivId}`).remove(); 
});