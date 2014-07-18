$(document).ready ->
  $(".js-infinite-scroll").each ->
    $(@).infinitescroll
      navSelector  : ".pagination"
      nextSelector : ".pagination a:last"
      # // selector for the NEXT link (to page 2)
      itemSelector : ".js-post"
      loadingText  : "Loading new posts...",
      # // selector for all items you'll retrieve

    , (arrayOfNewElems) ->
      $("#infscr-loading").remove()
      $(arrayOfNewElems).each ->
        $(@).find(".js-timeago").timeago()
