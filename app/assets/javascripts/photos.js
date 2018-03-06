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
    arrows: true,
    baseTpl :
        '<div class="fancybox-container" role="dialog" tabindex="-1">' +
            '<div class="fancybox-bg"></div>' +
            '<div class="fancybox-inner">' +
                '<div class="fancybox-infobar">' +
                    '<span data-fancybox-index></span>&nbsp;/&nbsp;<span data-fancybox-count></span>' +
                '</div>' +
                '<div class="fancybox-toolbar">{{buttons}}</div>' +
                '<div class="fancybox-navigation">{{arrows}}</div>' +
                '<div class="fancybox-stage"></div>' +
                '<div class="fancybox-caption-wrap"><div class="fancybox-caption"></div></div>' +
            '</div>' +
        '</div>'
  });
}

$(document).on('click', '.add-photos', function() {
  let path = $('.container form').attr('action');
  let files = $('.container form input[type="file"]').get(0).files;
  let progress = $('.photo-progress');
  let progressBar = progress.find('.progress-bar');
  let container = $('.modal-body .container');
  let modalButtons = $('.modal-footer button');
  let imageCount = files.length;
  let addButton = $('.add-photos');
  if (imageCount > 0) {
    progress.show();
    container.hide();
    addButton.hide();
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
            modalButtons.prop('disabled', false);
            setTimeout(function() {
              $('#AddPhotos').modal('hide');
            }, 2500);
          }
        });
      })
    }, Promise.resolve());
  }
});
