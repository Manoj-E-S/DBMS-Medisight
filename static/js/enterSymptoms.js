import { socket } from "./modules/utilities.js";


// Globals

var symptomList = [];
try {
    var whatOptionToSelect = JSON.parse(window.localStorage.getItem("whatOptionToSelect")).value;
} catch(err) {
    var whatOptionToSelect = [1];
}

$(whatOptionToSelect).each(idx => {
    $(`#selectSymptoms${idx}`).val(whatOptionToSelect[idx]);
});

// END Globals


// Initial Action
if(doctor_registered) {
    alert("Profile Submitted successfully");
    window.location = '/';
}



// Event Listeners

$("#addNewSymptomBtn").click(() => {
    let selectedVal = Number($(".select-symptoms").last().val());
    appendToWhatOptionToSelect(selectedVal);
    socket.emit('incrementSelectElementCount');
    window.location.reload();
});

$(".del-symptom-btn").click((event) => {
    let delBtnId = $(event.target).attr('id');
    $(event.target).prev().remove();
    $(event.target).remove();

    let index = Number(delBtnId[delBtnId.length - 1]);
    removeFromWhatOptionToSelect(index);

    socket.emit('decrementSelectElementCount');
    window.location.reload();
});

$("#clearAllSymptoms").click(async () => {
    await clearLocalStorage();
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
        success: function (res) {
            let queryValue = JSON.stringify(res);
            let queryParams = new URLSearchParams(queryValue).toString();
            window.location.href = `/showCancers?data=${queryParams}`;
        },
        failure: function (err) {
            console.error(err);
        }
    });
});

$("#registerDoctor").click(() => {
    window.location.href = "/registerDoctor";
});

$("#signUpPageLink").click(() => {
    window.location.href = "/signUp";
});

$("#loginPageLink").click(() => {
    window.location.href = "/login";
});

// END Event Listeners



// Utilities

function appendToWhatOptionToSelect(val) {
    whatOptionToSelect[whatOptionToSelect.length - 1] = val;
    whatOptionToSelect.push(1);
    window.localStorage.setItem("whatOptionToSelect", JSON.stringify({value: whatOptionToSelect}));
}

function removeFromWhatOptionToSelect(idx) {
    whatOptionToSelect.splice(idx, 1);
    window.localStorage.setItem("whatOptionToSelect", JSON.stringify({value: whatOptionToSelect}));
}

async function clearLocalStorage() {
    window.localStorage.clear();
    for(let i = 0; i < whatOptionToSelect.length - 1; i++) {
        await socket.emit('decrementSelectElementCount');
    }
    window.location.reload();
}

// END Utilities