$(document).ready(() => {
    if (document.getElementById("messages")) {
        setInterval(refreshPartial, 60000)
    }
})

const refreshPartial = () => {
    $.ajax({
        url: "chat_boxes/timestamps"
    })
}