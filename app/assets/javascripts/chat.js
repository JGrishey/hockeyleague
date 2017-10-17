$(document).on("turbolinks:load", () => {
    $('#scrolling').scrollTop($('#scrolling').scrollHeight);
})


$(document).on('turbolinks:request-start', function() {
    window.scrollTo(0, 0);
    $("#loader").show();
    console.log("turbolinks loaded")
});

$(document).on('turbolinks:render', function() {
    $("#loader").hide();
    console.log("rendered")
});

$(document).on('turbolinks:load', function() {
    $("#loader").hide();
    console.log("rendered")
});