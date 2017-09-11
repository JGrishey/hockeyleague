$(document).on('click', 'form .remove_goals', function(event) {
  $(this).parent().children('.removable')[0].value = 1;
  $(this).closest('fieldset').hide();
  return event.preventDefault();
});

$(document).on('click', 'form .add_goals', function(event) {
  const time = new Date().getTime();
  const regexp = new RegExp($(this).data('id'), 'g');
  $(this).before($(this).data('goals').replace(regexp, time));
  return event.preventDefault();
});

$(document).on('click', 'form .remove_penalties', function(event) {
  $(this).parent().children('.removable')[0].value = 1;
  $(this).closest('fieldset').hide();
  return event.preventDefault();
});

$(document).on('click', 'form .add_penalties', function(event) {
  const time = new Date().getTime();
  const regexp = new RegExp($(this).data('id'), 'g');
  $(this).before($(this).data('penalties').replace(regexp, time));
  return event.preventDefault();
});

$(document).on('click', 'form .add_movements', function(event) {
  const time = new Date().getTime();
  const regexp = new RegExp($(this).data('id'), 'g');
  $(this).before($(this).data('movements').replace(regexp, time));
  return event.preventDefault();
});

$(document).on('click', 'form .remove_movements', function(event) {
  $(this).parent().parent().parent().children('.removable')[0].value = 1;
  $(this).closest('fieldset').hide();
  return event.preventDefault();
});

$(document).on('click', 'form .remove_players', function(event) {
  $(this).parent().parent().parent().children('.removable')[0].value = 1;
  $(this).closest('fieldset').hide();
  return event.preventDefault();
});

$(document).on('click', 'form .add_players', function(event) {
  const time = new Date().getTime();
  const regexp = new RegExp($(this).data('id'), 'g');
  $(this).before($(this).data('players').replace(regexp, time));
  return event.preventDefault();
});