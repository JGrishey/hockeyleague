import Parser from "simple-text-parser"

let parser = new Parser()

parser.addRule(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/,
    (tag) => {
        return "<a href='" + tag + "'>" + tag + "</a>"
    })

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