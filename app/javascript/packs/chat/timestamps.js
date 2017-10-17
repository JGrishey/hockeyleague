$(document).on("turbolinks:load", () => {
    if (document.getElementById("messages")) {
        let refresh = setInterval(refreshPartial, 60000)
    } else {
        if (!(typeof refresh === 'undefined')) {
            clearInterval(refresh)
        }
    }
})

const refreshPartial = () => {
    $.ajax({
        url: "/chat_boxes/timestamps"
    })
}