$(document).ready(() => {
    const leftButton = document.getElementById("scroll-left")
    const rightButton = document.getElementById("scroll-right")

    $(leftButton).click((e) => {
        e.preventDefault();

        $("#games").animate({
            marginLeft: "-=200px",
        }, "fast")
    })

    $(rightButton).click((e) => {
        e.preventDefault();

        $("#games").animate({
            marginLeft: "+=200px"
        }, "fast")
    })
})