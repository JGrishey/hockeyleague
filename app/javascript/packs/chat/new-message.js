import pell from 'pell';

$(document).ready(() => {
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
                    document.getElementById('message_body').value = html
                }
            },
            styleWithCSS: true,
            actions: [
                {
                    name: 'image',
                    result: () => {
                        const url = window.prompt('Enter the image URL')
                        if (url) pell.exec('insertImage', url)
                        document.getElementsByClassName("pell-content")[0].innerHTML = "";
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                }
            ],
            classes: {
                actionbar: 'pell-actionbar',
                button: 'pell-button',
                content: 'pell-content pell-content-chat'
            }
        })
    }
})