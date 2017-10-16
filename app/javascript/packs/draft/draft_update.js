$(document).ready(() => {
    if (document.getElementById("unplaced")) {
        setInterval(refreshPartial, 15000)
    }
})

const refreshPartial = () => {
    $.ajax({
        url: "chat_boxes/draft_update"
    })
}