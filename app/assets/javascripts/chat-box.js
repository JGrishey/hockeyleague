$(function() {
    if ($('#infinite-scrolling').size() > 0) {
      $(window).on('scroll', function() {});
      const more_messages_url = $('.pagination .next_page a').attr('href');
              $('.pagination').html('<img src="" alt="Loading..." title="Loading..." />');
              $.getScript(more_messages_url);
      return;
      return;
    }
});

$(document).ready(() => {
  $('#message_body').keypress(function(e){
      if(e.which == 13){
           $(this).closest('form').submit();
       }
    });
})