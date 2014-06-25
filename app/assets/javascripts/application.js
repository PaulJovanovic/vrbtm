// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require jquery.ui.effect
//= require jquery.ui.draggable
//= require jquery.ui.resizable
//= require jquery.ui.slider
//= require jquery.ui.touch-punch.min
//= require handlebars
//= require jquery.timeago
//= require jquery.typeahead
//= require minicolors
//= require like
//= require comments
//= require_tree .

$(document).ready(function() {
  $.timeago.settings = {
    refreshMillis: 60000,
    allowFuture: true,
    localeTitle: false,
    cutoff: 0,
    strings: {
      prefixAgo: "",
      prefixFromNow: "",
      suffixAgo: "ago",
      suffixFromNow: "",
      seconds: "less than a minute",
      minute: "a minute",
      minutes: "%d minutes",
      hour: "an hour",
      hours: "%d hours",
      day: "1 day",
      days: "%d days",
      month: "a month",
      months: "%d months",
      year: "a year",
      years: "%d years",
      wordSeparator: " ",
      numbers: []
    }
  };

  $("abbr.js-timeago").timeago();

  $(".js-post-quote-text").focus(function() {
    $(".js-post-information").removeClass("hide");
  });

  var textTrackings = function(quoteText) {
    var trackings = [];
    var text = quoteText.replace(/\n/g, '<br/>').trim();
    var words = text.split(" ");
    $.each(words, function() {
      trackings.push('<span class="js-post-quote-image-word">' + this + '</span>');
    });
    $(".js-post-quote-image-text").html(trackings.join(" "));
  }

  $(".js-post-quote-text").keyup(function() {
    textTrackings($(this).val());
  }).change(function() {
    textTrackings($(this).val());
  });

  $("#user-posts-create").submit(function() {
    if ($("#post-image-toggle").hasClass("active")) {
      var conversion = 394 / $("#post-image-box").width();
      var backgroundColor = $("#post-image-background-color").val();
      var fontSize = $("#post-image-font-size").val();
      var position = $("#post-image-text-box").position();
      var left = position.left;
      var top = position.top;
      var words = [];
      var quotationLeftPosition = $("#post-image-quotation-mark-left").position();
      var quotationRightPosition = $("#post-image-quotation-mark-right").position();
      $(".js-post-quote-image-word").each(function() {
        words.push('{"left":' + conversion * (left + $(this).position().left) + ',"top":' + conversion * (top + $(this).position().top) + ',"text":"' + $(this).html() + '"}');
      });
      $(".js-post-photo-attributes").val('{"background_color":"' + backgroundColor + '","font_size":' + conversion * fontSize + ',"words":[' + words.join(",") + '],"quotation_marks":[{"left":' + conversion * (left + quotationLeftPosition.left) + ',"top":'+ conversion * (top + quotationLeftPosition.top - 2) +'},{"left":' + conversion * (left + quotationRightPosition.left) + ',"top":' + conversion * (top + quotationRightPosition.top - 2) +'}]}');
    }
  });

  var nameTracking = function(sourceName) {
    var trackings = [];
    var words = sourceName.trim().split(" ");
    $.each(words, function() {
      trackings.push('<span class="js-post-quote-image-word">' + this + '</span>');
    });
    $(".js-post-quote-image-name").html(trackings.join(" "));
  }

  $("#quote_name").keyup(function() {
    nameTracking($(this).val());
  }).change(function() {
    nameTracking($(this).val());
  });

  $(".js-draggable").draggable();
  $(".js-resizable").resizable();

  $.minicolors = {
    defaults: {
      animationSpeed: 50,
      animationEasing: 'swing',
      change: null,
      changeDelay: 0,
      control: 'hue',
      defaultValue: '',
      hide: null,
      hideSpeed: 100,
      inline: false,
      letterCase: 'uppercase',
      opacity: false,
      position: 'bottom right',
      show: null,
      showSpeed: 100,
      theme: 'default'
    }
  };

  $('.js-minicolors').minicolors({
    change: function(hex, opacity) {
      $("#post-image-box").css({backgroundColor: hex});
    }
  });

  $("#post-image-font-size").keyup(function() {
    $("#post-image-text-box").css({fontSize: $(this).val() + "px"});
  });

  $("#post-image-font-size-slider").slider({
    orientation: "vertical",
    range: "min",
    min: 10,
    max: 32,
    value: 18,
    slide: function( event, ui ) {
      $("#post-image-font-size").val( ui.value );
      $("#post-image-text-box").css({fontSize: ui.value + "px"});
    }
  });

  function componentToHex(c) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
  }

  function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
  }

  function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
      r: parseInt(result[1], 16),
      g: parseInt(result[2], 16),
      b: parseInt(result[3], 16)
    } : null;
  }

  var gradient_numbers = [];
  $(".js-gradient").each(function() {
    gradient_numbers.push(parseInt($(this).data("number")));
  });
  var min_number = Math.min.apply(null, gradient_numbers);
  var max_number = Math.max.apply(null, gradient_numbers);

  setTimeout(function(){
    $(".js-gradient").each(function(){
      var number = parseFloat($(this).data("number"));
      var percent = (number - min_number) * 1.0 / (max_number - min_number);
      var min_rgb = hexToRgb("#27292A");
      var max_rgb = hexToRgb("#45BECE");
      $(this).animate({backgroundColor: rgbToHex(min_rgb.r + Math.floor(percent * (max_rgb.r - min_rgb.r)), min_rgb.g + Math.floor(percent * (max_rgb.g - min_rgb.g)), min_rgb.b + Math.floor(percent * (max_rgb.b - min_rgb.b)))}, 1400 * percent);
    });
  }, 400);

  $(".js-tab").click(function() {
    $(this).toggleClass("active");
    $($(this).data("target")).toggleClass("hide");
  });

  $(".js-post-tags-toggle").click(function() {
    var $icon = $(this).find(".js-post-tags-toggle-icon");
    if($icon.hasClass("fa-plus")) {
      $(".js-post-tags").removeClass("hide");
      $icon.addClass("fa-minus").removeClass("fa-plus");
    } else {
      $(".js-post-tags").addClass("hide");
      $icon.addClass("fa-plus").removeClass("fa-minus");
    }
  });

  $(".js-post-more-toggle").click(function() {
    $(this).toggleClass("active");
    $(this).closest(".js-post").find(".js-post-more").toggleClass("hide");
  });

  var people = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/peoples/search?name=%QUERY',
      filter: function (people) {
        return $.map(people, function (person) {
          return {
            id: person.id,
            name: person.name,
            url: person.url,
            image: person.image,
            tokens: person.name.split(" ")
          };
        });
      }
    }
  });

  people.initialize();

  $('.js-people-search').typeahead(null, {
    name: 'people',
    source: people.ttAdapter(),
    minLength: 2,
    templates: {
      suggestion: Handlebars.compile([
        '<table class="full-width">',
        '<tr>',
        '<td class="dhs"><img src="{{image}}" class="das"/></td>',
        '<td class="plxs c-teal fwl">{{name}}</td>',
        '</tr>',
        '</table>'
      ].join(''))
    }
  }).on('typeahead:selected', function(event, selection) {
    window.location = selection.url;
  });

  var users = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/sources/search?name=%QUERY',
      filter: function (users) {
        return $.map(users, function (user) {
          return {
            id: user.id,
            name: user.name,
            tokens: user.name.split(" "),
            image: user.image,
            info: user.info
          };
        });
      }
    }
  });

  users.initialize();

  $(".js-post-quote-name").keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });

  $('.js-post-quote-name').keyup(function(event) {
    $(".js-quote-citable-id").val("");
    if ($(this).val().trim().charAt(0) == '@') {
      $(".js-quote-citable-type").val("User");
    } else {
      $(".js-quote-citable-type").val("Source");
    }
  });

  $('.js-post-quote-name').typeahead(null, {
    name: 'users',
    source: users.ttAdapter(),
    minLength: 2,
    templates: {
      suggestion: Handlebars.compile([
        '<table class="full-width">',
        '<tr>',
        '<td class="dhs"><img src="{{image}}" class="das"/></td>',
        '<td class="plxs c-teal fwl">{{name}}</td>',
        '<td class="c-2 fsxxxs text-right">{{info}}</td>',
        '</tr>',
        '</table>'
      ].join(''))
    }
  }).on('typeahead:selected', function(event, selection) {
    $(".js-quote-citable-id").val(selection.id);
    $(".js-post-quote-name").val(selection.name).change();
  });

  $("#quotes-create").on("ajax:success", function(event, data, status, xhr) {
    $(".js-post-quote-id").val(data.id);
    $("#user-posts-create").submit();
  });

  $("#quotes-create input[type=submit]").click(function(event) {
    var successTrigger = function(source_id) {
      $(".js-quote-citable-id").val(source_id);
      $("#quotes-create").submit();
    };

    event.preventDefault();
    if ($(".js-quote-citable-id").val().length > 0) {
      successTrigger($(".js-quote-citable-id").val());
    }
    else {
      $.ajax({
        type: "POST",
        url: "/sources",
        data: {
          source: {
            name: $("#quote_name").val()
          }
        }
      }).success(function(data) {
        successTrigger(data.id);
      }).fail(function() {
        alert("error");
      });
    }
    return false;
  });

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '733767459997727',
      xfbml      : true,
      version    : 'v2.0'
    });
  };

  (function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  $(".js-facebook-share").click(function() {
    var $post = $(this).closest(".js-post");
    var $tags = $post.find(".js-post-tag");
    var $photo = $post.find(".js-post-photo");
    var facebookParams = {};

    if ($photo.length > 0) {
      facebookParams["picture"] = $photo.attr("src");
    } else {
      facebookParams["message"] = "\"" + $post.find(".js-post-text").text() + "\" -" + $post.find(".js-post-name").text(),
      facebookParams["actions"] = {
        name: $post.find(".js-post-name").text(),
        link: $(this).data("link")
      };
      if ($tags.length > 0) {
        facebookParams["message"] += "\n";
        $tags.each(function() {
          facebookParams["message"] += "#" + $(this).text() + " ";
        });
      }
    }

    FB.login(function(){
      FB.api('/me/feed', 'post', facebookParams, function(response) {
        console.log(response);
      });
    }, {scope: 'publish_actions'});
  })
});
