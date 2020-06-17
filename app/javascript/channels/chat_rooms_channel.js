import consumer from "./consumer"

$(document).on("turbolinks:load", function () {
  const chat_room_id = $('#message_chat_room_id').val()
  const other_user = $('#chat-username').attr('data-username')

  if (this.chat_subscription) {
    consumer.subscriptions.remove(this.chat_subscription);
    this.chat_subscription = null
  }

  function updateScroll() {
    const element = document.getElementById('messages');
    element.scrollTop = element.scrollHeight;
  }

  if (chat_room_id) {
    let connection = consumer.subscriptions.create({ channel: "ChatRoomsChannel", chat_room_id: chat_room_id }, {
      connected() {
        this.perform('seen', { chat_room_id: chat_room_id })
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        if (data.type == 'creation') {
          if (data.user == other_user) {
            if ($('#messages').length) {
              $('#messages').append(`${data.html_other_user}`)
              this.perform('seen', { chat_room_id: chat_room_id })
            }
          } else {
            $('#messages').append(`${data.html_current_user}`)
          }
          updateScroll()
          $('#message_text').val('')
        } else if (data.type == 'seen') {
          data.messages_id.forEach(id => {
            $(`#message-${id}-seen`).addClass('text-success')
          })
        } else {
          const message_id = `#message-${data.message_id}`
          $(`${message_id} p:first-child`).html(
            '<i class="fas fa-ban"></i> This message was deleted'
          )
          $(`${message_id} a`).remove()
          $(`${message_id}-seen`).remove()
        }
      }
    })

    this.chat_subscription = connection
  }
})
