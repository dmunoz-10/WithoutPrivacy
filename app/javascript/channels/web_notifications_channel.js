import consumer from "./consumer"

consumer.subscriptions.create("WebNotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action == 'talked' && $('#messages').length) {
    } else {
      $('#WebNotifications').prepend(data.html)
      $('#WebNotificationsCount').html(data.count)
      $(`#toast-${data.id}`).toast('show')
    }
  }
});
