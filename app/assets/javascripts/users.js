$(document).on('click', '#albums-tab', function() {
  sessionStorage.setItem('user-tab', 'albums');
});

$(document).on('click', '#photos-tab', function() {
  sessionStorage.setItem('user-tab', 'photos');
});


$(function() {
  activeUserTab();
  $(document).on('turbolinks:load', function() {
    activeUserTab();
  });
})

function activeUserTab() {
  let activeTab = sessionStorage.getItem('user-tab');
  let albumsTab = $('#albums-tab');
  let albumsContentTab = $('div #albums');
  let photosTab = $('#photos-tab');
  let photosContentTab = $('div #photos');
  if(activeTab === 'albums') {
    albumsTab.addClass('active');
    albumsContentTab.addClass('show active');
    photosTab.removeClass('active');
    photosContentTab.removeClass('show active');
  } else if (activeTab === 'photos') {
    albumsTab.removeClass('active');
    albumsContentTab.removeClass('show active');
    photosTab.addClass('active');
    photosContentTab.addClass('show active');
  } else {
    photosTab.addClass('active');
    photosContentTab.addClass('show active');
  }
}
