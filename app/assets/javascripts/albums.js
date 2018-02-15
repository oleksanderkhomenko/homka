$(document).on('click', '.save-album', function() {
  Rails.fire($('.container form').get(0), 'submit');
});

