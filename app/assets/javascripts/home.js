function fScroll() {
  if(($('.content').scrollTop()+$('.content').height()) === $('.content').prop('scrollHeight')) {
    let link = $('.next-page-link');
    if (link.length > 0) {
      $(link).get(0).click();
    }
  }
}
