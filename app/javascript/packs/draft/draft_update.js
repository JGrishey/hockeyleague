$(document).ready(() => {
    if (document.getElementById("unplaced")) {
        setInterval(refreshPartial, 15000)
    }
})

const refreshPartial = () => {
    $.ajax({
        url: "pages/draft_update"
    })
}