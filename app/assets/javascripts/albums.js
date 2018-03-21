$(document).on('click', '.save-album', function() {
  $('.modal-footer button').prop('disabled', true);
  Rails.fire($('.container form').get(0), 'submit');
});

function showDeleteSpinner() {
  $('.delete-album-button').hide();
  $('.spinner').show();
}
