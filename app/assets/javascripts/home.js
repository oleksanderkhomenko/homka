function fScroll() {
  if(($('.content').scrollTop()+$('.content').height()) === $('.content').prop('scrollHeight')) {
    // Rails.fire($('.loading-more form').get(0), 'submit');
    console.log('bikini bottom');
  }
}