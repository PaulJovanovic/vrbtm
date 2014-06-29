$(".js-post-destroy").click ->
  $post = $(@).closest(".js-post")
  $.ajax(
    type: "POST"
    url: $post.data("url")
    dataType: "json"
    data:
      "_method": "delete"
    success: ->
      $post.fadeOut 400, ->
        $(@).remove()
  )
