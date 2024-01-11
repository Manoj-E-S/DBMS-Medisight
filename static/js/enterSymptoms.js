import { socket } from "./modules/utilities.js";

// window.localStorage.clear();

var symptomList = [];
try {
    var whatOptionToSelect = JSON.parse(window.localStorage.getItem("whatOptionToSelect")).value;
} catch(err) {
    console.error(err);
    var whatOptionToSelect = [0];
}

$(whatOptionToSelect).each(idx => {
    $(`#selectSymptoms${idx}`).val(whatOptionToSelect[idx]);
});

$("#addNewSymptomBtn").click(() => {
    let selectedVal = Number($(".select-symptoms").last().val());
    appendToWhatOptionToSelect(selectedVal);
    socket.emit('incrementSelectElementCount');
    window.location.reload();
});

$(".del-symptom-btn").click((event) => {
    let delBtnId = $(event.target).attr('id');
    $(`#${delBtnId}`).remove();

    let delSymptomId = $(`#${delBtnId}`).prev().attr("id");
    $(`#${delSymptomId}`).remove();

    let index = Number(delBtnId[delBtnId.length - 1]);
    removeFromWhatOptionToSelect(index);

    socket.emit('decrementSelectElementCount');
    window.location.reload();
});

$("#clearAllSymptoms").click(async () => {
    window.localStorage.clear();
    for(let i = 0; i < whatOptionToSelect.length - 1; i++) {
        await socket.emit('decrementSelectElementCount');
    }
    window.location.reload();
});

$("#symptomSelector").submit((event) => {
    event.preventDefault();
    $(".select-symptoms").each((index, item) => {
        if (index != $(".select-symptoms").length - 1)
        symptomList.push(Number($(item).val()));
    });
    
    $.ajax({
        type: 'POST',
        url: "/showCancers",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({patientSymptoms: symptomList}),
        success: function (response) {
            document.write(response.data);
        }
    });
});


function appendToWhatOptionToSelect(val) {
    whatOptionToSelect[whatOptionToSelect.length - 1] = val;
    whatOptionToSelect.push(0);
    window.localStorage.setItem("whatOptionToSelect", JSON.stringify({value: whatOptionToSelect}));
}

function removeFromWhatOptionToSelect(idx) {
    whatOptionToSelect.splice(idx, 1);
    window.localStorage.setItem("whatOptionToSelect", JSON.stringify({value: whatOptionToSelect}));
}

