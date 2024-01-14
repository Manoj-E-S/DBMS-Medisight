var socket = io();

// function reloadPageOnce() {
//     if(!window.location.hash) {
//         window.location = window.location + '#loaded';
//         window.location.reload();
//     }
// }

// function fromURLRemoveQueryStringIfAny(url) {
//     var qIndex = url.indexOf("?");
//     if(qIndex !== -1) {
//         var query =  url.substring(qIndex);
//         var finalUrl = url.replace(query,"");
//         window.location.href = finalUrl;
//     }
// }

///////////////////////////////////////////////////////////

export {
    // fromURLRemoveQueryStringIfAny,
    // reloadPageOnce,
    socket
}