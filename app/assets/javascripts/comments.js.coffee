$(document).ready ->
  $(".js-post-comment-form").on "ajax:success", (event, data, status, xhr) ->
    comment = data.comment
    $("""
      <div class="row nmhxxxs mtxxxs-plus fade-xl">
        <div class="col-xs-2 col-md-1 phxxxs">
          <a href="/users/#{comment.user_id}">
            <img alt="Avatar" class="img-responsive" src="#{$("#current-user-avatar").attr("src")}">
          </a>
        </div>
        <div class="col-xs-10 col-md-11 phxxxs">
          <div class="">
            <a class="fsxxxs fwl c-teal" href="/users/#{comment.user_id}">#{$("#current-user-name").html()}</a>
          </div>
          #{comment.text}
        </div>
      </div>
    """).appendTo("#post-#{comment.post_id}-comments").animate({opacity: 1}, 400)
    $(event.target).find(".js-comment-text").val("")
    count = parseInt($("#post-#{comment.post_id}-comments-count").html())
    $("#post-#{comment.post_id}-comments-count").html(count + 1).removeClass("hide")
