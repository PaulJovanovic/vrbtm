$(document).ready ->
  $(document).on "mouseenter", ".js-notification", (event) ->
    $notification = $(@)
    event.stopPropagation()
    if !$notification.data("read")?
      $.ajax(
        type: "POST"
        url: $notification.data("url")
        dataType: "json"
        success: ->
          console.log("yo")
          $notification.data("read", "true")
          count = parseInt($(".js-notification-badge-count").html()) - 1
          console.log(count)
          $(".js-notification-badge-count").html(count)
          if count == 0
            $(".js-notification-badge").addClass("hide")
      )


