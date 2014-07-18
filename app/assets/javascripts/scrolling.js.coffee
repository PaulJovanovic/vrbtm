$(document).ready ->
  $(".js-infinite-scroll").each ->
    $(@).infinitescroll
      navSelector  : ".pagination"
      nextSelector : ".pagination a:last"
      itemSelector : ".js-post"
      bufferPx     : 800,
    , (arrayOfNewElems) ->
      $("#infscr-loading").remove()
      $(arrayOfNewElems).each ->
        $(@).find(".js-timeago").timeago()
