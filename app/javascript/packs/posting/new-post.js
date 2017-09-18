import pell from 'pell';
const sanitizeHtml = require('sanitize-html');

$(document).ready(() => {
    if (document.getElementById("pell")) {
        $("#submit").on('click', (e) => {
            e.preventDefault()
            $("#real-submit").click()
        })

        const editor = pell.init({
            element: document.getElementById('pell'),
            onChange: html => {
                if (document.getElementById('post_content')) {
                    document.getElementById('post_content').value = html
                } else {
                    document.getElementById('comment_content').value = html
                }
            },
            styleWithCSS: true,
            actions: [
                {
                    name: 'bold',
                    result: () => {
                        pell.exec('bold')
                        console.log($("button [title=Bold]"))
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'underline',
                    result: () => {
                        pell.exec('underline')
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'italic',
                    result: () => { 
                        pell.exec('italic')
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'strikethrough',
                    result: () => { 
                        pell.exec('strikethrough')
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'heading1',
                    result: () => {
                        pell.exec('formatBlock', '<H1>');
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'heading2',
                    result: () => {
                        pell.exec('formatBlock', '<H2>');
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                {
                    name: 'html',
                    title: 'Code',
                    icon: '<b>&lt/&gt</b>',
                    result: () => {
                        document.getElementsByClassName("pell-content")[0].focus();
                        const input = window.prompt('Enter the code');
                        if (input) pell.exec('insertHTML', input)
                        document.getElementsByClassName("pell-content")[0].focus();
                    }
                },
                'paragraph',
                'quote',
                'olist',
                'ulist',
                'line',
                'image',
                'link'
            ],
            classes: {
                actionbar: 'pell-actionbar',
                button: 'pell-button',
                content: 'pell-content'
            }
        })
        if (document.getElementById("post_content")) {
            if (document.getElementById("post_content").value) {
                document.getElementsByClassName("pell-content")[0].innerHTML = document.getElementById("post_content").value
            }
        } else if (document.getElementById("comment_content")) {
            if (document.getElementById("comment_content").value) {
                document.getElementsByClassName("pell-content")[0].innerHTML = document.getElementById("comment_content").value
            }
        }
    }
})