$(document).on('click', '.save-album', function() {
  $('.modal-footer button').prop('disabled', true);
  Rails.fire($('.container form').get(0), 'submit');
});
