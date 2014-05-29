class Like
  constructor: (@form) ->
    if @form.find("input[name=_method]").length == 0
      @form.append("<input type='hidden' name='_method' value='post'/>")
    @method = @form.find("input[name=_method]")
    @count = @form.find(".js-like-count")

    @form.find(".js-like-submit").click (e)=>
      e.preventDefault()
      @form.submit()

    @form.on "submit", =>
      @updateCounter()
      @toggleActive()

    @form.on "ajax:success", (event, data, status, xhr) =>
      @toggleMethod()

    @form.on "ajax:error", (event, xhr, status, error) =>
      @updateCounter()
      @toggleActive()


  methodIsPost: ->
    @method.val() == "post"

  displayCount: (count) ->
    @count.html(count)
    if count > 0
      @count.removeClass("hide")
    else
      @count.addClass("hide")

  updateCounter: ->
    count = parseInt(@count.html())
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

  toggleActive: ->
    if @methodIsPost()
      @form.find(".js-like-submit").addClass("active");
    else
      @form.find(".js-like-submit").removeClass("active");

$(document).ready ->
  $(".js-like").each ->
    new Like($(@))

