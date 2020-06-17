const loadNextPage = function() {
  if ($('#posts').length == 0) { return }
  if ($('#next_link').length && $(window).scrollTop() > ($(document).height() - $(window).height() - 500)) {
    $('#next_link')[0].click();
    $('#next_link').remove();
  }
};

window.addEventListener('scroll', loadNextPage);
