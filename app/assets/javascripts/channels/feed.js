var feedSubscription = undefined;
$(function() {
  if(location.pathname === '/') {
    createSubscription();
  }
  $(document).on('turbolinks:load', function() {
    if(location.pathname === '/' && App.cable.subscriptions.subscriptions.length < 1) {
      createSubscription();
    } else if (location.pathname !== '/') {
      unsubscribe();
    }
  })
});

function createSubscription () {
  if (feedSubscription) {
    return;
  }
  feedSubscription = App.cable.subscriptions.create("FeedChannel", {
    connected: function() {
      console.log('connected');
    },
    disconnected: function() {
      console.log('disconnected');
    },
    received: function(data) {
      return Feed[data['action']](data);
    }
  });

  Feed = {
    create: function(data) {
      $('.feed').prepend(data['feed']);
    },
    update: function(data) {
      $('#feed-'+data['feed_id']+' .photos-count').html(data['photos_count'])
      $('#feed-'+data['feed_id']+' .row').prepend(data['photo']);
    },
    destroy: function(data) {
      if(data['delete_feed'] && data['feed_ids']) {
        $.each(data['feed_ids'], function( index, feed_id ) {
          $('#feed-'+feed_id).remove();
        });
      } else if (data['delete_feed']) {
        $('#feed-'+data['feed_id']).remove();
      } else {
        var photoCount = $('#feed-'+data['feed_id']+' .photos-count');
        photoCount.html(photoCount.html()-1);
        $('#photo-'+data['photo_id']).remove();
      }
    }
  };
}

function unsubscribe () {
  if(App.cable.subscriptions.subscriptions.length > 0) {
      feedSubscription.unsubscribe();
      feedSubscription = undefined;
    }
}
