import '../../stylesheets/posts/post'

$('.add-comment').click(function() {
  $(`#text-area-${$(this).attr('data-id')}`).val('')
  $(`#add-comment-${$(this).attr('data-id')}`).toggle('fast')
})