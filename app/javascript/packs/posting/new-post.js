import pell from 'pell';
const sanitizeHtml = require('sanitize-html');

$(document).ready(() => {
    if (document.getElementsByClassName("pell-content").length == 0) {
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
                        name: 'iframe',
                        title: 'iframe',
                        icon: '<b>&lt/&gt</b>',
                        result: () => {
                            document.getElementsByClassName("pell-content")[0].focus();
                            const input = window.prompt('Enter the iframe src. (i.e. https://gfycat.com/ifr/ArcticAllBaldeagle)');

                            const iframe = `<div style='position:relative;padding-bottom:57%'><iframe src='${input}' frameborder='0' scrolling='no' width='100%' height='100%' style='position:absolute;top:0;left:0;' allowfullscreen></iframe></div>`

                            if (input) pell.exec('insertHTML', iframe)
                            document.getElementsByClassName("pell-content")[0].focus();
                        }
                    },
                    'paragraph',
                    'quote',
                    'olist',
                    'ulist',
                    'line',
                    {   
                        name: 'image',
                        icon: '&#128247;',
                        title: 'Image',
                        result: () => {
                            document.getElementsByClassName("pell-content")[0].focus();
                            const url = window.prompt('Enter the image URL')
                            if (url) pell.exec('insertImage', url)
                            document.getElementsByClassName("pell-content")[0].focus();
                        }
                    },
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
    }
})