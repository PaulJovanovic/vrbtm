openTab = ($tab) ->
  $tab.addClass("active")
  $($tab.data("target")).removeClass("hide")

closeTab = ($tab) ->
  $tab.removeClass("active")
  $($tab.data("target")).addClass("hide")

toggleTab = ($tab) ->
  $tab.toggleClass("active")
  $($tab.data("target")).toggleClass("hide")

$(".js-tab").click (event) ->
  $tab = $(@)
  $(this).closest(".js-tabs").find(".js-tab.active[data-unfocus='true']").each ->
    if $(@).get(0) != $tab.get(0)
      toggleTab($(@))
  toggleTab($(@))
  event.stopPropagation();

$(document).on "click", (event) ->
  $(".js-tab.active[data-unfocus='true']").each ->
    toggleTab($(@))
