import pell from 'pell';

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
                        document.getElementById('message_body').value = html
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