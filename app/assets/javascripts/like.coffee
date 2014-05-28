class Like
  constructor: (@form) ->
    if @form.find("input[name=_method]").length == 0
      @form.append("<input type='hidden' name='_method' value='post'/>")
    @method = @form.find("input[name=_method]")
    @counter = $("#" + @form.find(".js-like-likable-type").val() + "-" + @form.find(".js-like-likable-id").val() + "-likes")
    @counterCount = @counter.find(".js-like-count")

    @form.on "submit", =>
      @updateCounter()
      @toggleText()

    @form.on "ajax:success", (event, data, status, xhr) =>
      @toggleMethod()

    @form.on "ajax:error", (event, xhr, status, error) =>
      @toggleMethod()
      @updateCounter()
      @toggleText()


  methodIsPost: ->
    @method.val() == "post"

  displayCount: (count) ->
    @counterCount.html(count)
    if count > 0
      if count == 1
        @counter.find(".js-like-text").html("like")
        @counter.removeClass("hide")
      else if count == 2
        @counter.find(".js-like-text").html("likes")
    else
      @counter.addClass("hide")

  updateCounter: ->
    count = parseInt(@counterCount.html())
    if @methodIsPost()
      count++
    else
      count--
    @displayCount(count)

  toggleMethod: ->
    if @methodIsPost()
      @method.val("delete")
    else
      @method.val("post")

  toggleText: ->
    if @methodIsPost()
      @form.find(".js-like-submit").val("Unlike");
    else
      @form.find(".js-like-submit").val("Like");

$(document).ready ->
  $(".js-like").each ->
    new Like($(@))

