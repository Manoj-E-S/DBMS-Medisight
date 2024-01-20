// const reloadURL = window.location.href;
// window.history.replaceState(window.history.state, "", "/showCancers");

$(".tests-btn").click((event) => {
    let diseaseName = $(event.target).prev().children('span').children('em').html() //.replace(" ", "_").toLowerCase();
    window.location.href = `/showTests/${diseaseName}`;
});

$(".doctors-btn").click((event) => {
    let currentBtnId = $(event.target).attr('id')
    let currentAccordianIndex = currentBtnId.substring(currentBtnId.length - 1);
    let departmentName = $(`#deptName${currentAccordianIndex}`).html()
    window.location.href = `/showDoctors/${departmentName}`;
})