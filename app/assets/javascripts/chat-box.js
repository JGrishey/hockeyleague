$(function() {
    if ($('#infinite-scrolling').size() > 0) {
      $(window).on('scroll', function() {});
      const more_messages_url = $('.pagination .next_page a').attr('href');
      if (more_messages_url && ($(window).scrollTop() > ($(document).height() - $(window).height() - 60))) {
              $('.pagination').html('<img src="" alt="Loading..." title="Loading..." />');
              $.getScript(more_messages_url);
              
            }
      return;
      return;
    }
});