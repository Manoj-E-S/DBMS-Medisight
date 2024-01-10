import { socket } from "./modules/utilities.js";

$("#addNewSymptomBtn").click(() => {
    socket.emit('incrementSelectElementCount');
    window.location.reload();
});
