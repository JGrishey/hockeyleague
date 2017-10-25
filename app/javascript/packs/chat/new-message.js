import pell from 'pell';

import Parser from "simple-text-parser"

let parser = new Parser()

parser.addRule(/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g,
    (tag) => {
        return "<a href='" + tag + "'>" + tag + "</a>"
    })

$(document).ready(() => {
    if (document.getElementsByClassName("pell-content").length == 0) {
        if (document.getElementById("pell")) {
            $(document).ready(() => {
                $('#pell').keypress(function(e){
                    if(e.which == 13){
                        $(this).closest('form').submit();
                        e.preventDefault();
                        $(".pell-content")[0].innerHTML = ""
                    }
                });

                $("#message_submit").on('click', (e) => {
                    $(".pell-content")[0].innerHTML = ""
                })
            })

            const editor = pell.init({
                element: document.getElementById('pell'),
                onChange: html => {
                    if (document.getElementById('message_body')) {
                        document.getElementById('message_body').value = parser.render(html)
                    }
                },
                styleWithCSS: true,
                actions: [
                    {   
                        name: 'image',
                        icon: '<img src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-camera-128.png" width="30" height="30"/>',
                        title: 'Image',
                        result: () => {
                            document.getElementsByClassName("pell-content")[0].focus();
                            const url = window.prompt('Enter the image URL')
                            if (url) pell.exec('insertImage', url)
                            document.getElementsByClassName("pell-content")[0].innerHTML = "";
                            document.getElementsByClassName("pell-content")[0].focus();
                        }
                    },
                ],
                classes: {
                    actionbar: 'pell-actionbar pell-actionbar-chat col-1',
                    button: 'pell-button-chat',
                    content: 'pell-content pell-content-chat col-11'
                }
            })
        }
    }
})