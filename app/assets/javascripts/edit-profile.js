$(document).ready( () => {
    if ($("#user_avatar")) {
        let realInput = $("#user_avatar")

        $(realInput).change(() => {
            $('#file-display').html("File uploaded");
        })

        $('#upload-btn').click((e) => {
            $(realInput).click()
            e.preventDefault();
        });
    }

    if ($("#team_logo")) {
        let realInput = $("#team_logo")

        $(realInput).change(() => {
            $('#file-display').html("File uploaded");
        })

        $('#upload-btn').click((e) => {
            $(realInput).click()
            e.preventDefault();
        });
    }
})