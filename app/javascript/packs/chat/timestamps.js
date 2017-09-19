$(document).ready(() => {
    if (document.getElementById("messages")) {
        setInterval(refreshPartial, 60000)
    }
})

const refreshPartial = () => {
    console.log("Hello");
    $.ajax({
        url: "chat_boxes/timestamps"
    })
}