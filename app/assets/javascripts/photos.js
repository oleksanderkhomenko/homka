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
