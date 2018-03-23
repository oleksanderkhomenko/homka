(function() {
  App.cable.subscriptions.create("FeedChannel", {
    connected: function() {
      console.log('connected');
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
      $('#feed-'+data['feed_id']).replaceWith(data['feed']);
    },
    destroy: function(data) {
      console.log(data)
      if(data['delete_feed']) {
        $('#feed-'+data['feed_id']).remove();
      } else {
        $('#feed-'+data['feed_id']).replaceWith(data['feed']);
      }
    }
  };

}).call(this);
