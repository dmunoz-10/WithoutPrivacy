import '../../stylesheets/posts/post'

$('.card-image').hover(function() {
  $('> .card-img-overlay', this).removeClass('d-none')
}, function() {
  $('> .card-img-overlay', this).addClass('d-none')
})

$('.card-img-overlay').click(function() {
  window.location.replace(`${$(this).attr('data-url')}`)
})