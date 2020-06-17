const loadMoreMessages = function() {
  if ($('#messages').length == 0) { return }
  if ($('#next_link').length && $('#messages').scrollTop() < 250) {
    $('#next_link')[0].click();
    $('#next_link').remove();
  }
};

$('#messages').scroll(loadMoreMessages);
