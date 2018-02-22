$(function() {
  fancyBoxInitialize();
  document.addEventListener("turbolinks:load", function() {
    fancyBoxInitialize();
  })
});

function fancyBoxInitialize() {
  $('[data-fancybox]').fancybox({
    buttons : [
      'fullScreen',
      'close'
    ],
    loop: true,
    clickSlide : false,
    arrows: true
  });
}

$(document).on('click', '.add-photos', function() {
  let path = $('.container form').attr('action');
  let files = $('.container form input[type="file"]').get(0).files;
  let progress = $('.photo-progress');
  let progressBar = progress.find('.progress-bar');
  let container = $('.modal-body .container');
  let modalButtons = $('.modal-footer button');
  let imageCount = files.length
  if (imageCount > 0) {
    progress.show();
    container.hide();
    modalButtons.prop('disabled', true);
    progressBar.css({width: 0});
    Array.from(files).reduce(function(promise, file, index) {
      let image = new FormData();
      image.append('photo[image]', file);
      return promise.then(function () {
        return $.ajax({
        type: "POST",
          url: path,
          processData: false,
          contentType: false,
          data: image
        }).then(function() {
          progressBar.css({width: (index + 1) * 100 / imageCount + '%'});
          if (imageCount === (index + 1)) {
            $('#AddPhotos').modal('hide');
            modalButtons.prop('disabled', false);
          }
        });
      })
    }, Promise.resolve());
  }
});
