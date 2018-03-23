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
      console.log(data)
    },
    update: function(data) {

    },
    destroy: function(data) {

    }
  };

}).call(this);
