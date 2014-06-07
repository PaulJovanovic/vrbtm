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
//= require handlebars
//= require jquery.timeago
//= require jquery.typeahead
//= require like
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
    templates: {
      suggestion: Handlebars.compile([
        '<p>{{name}}</p>'
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
            tokens: user.name.split(" ")
          };
        });
      }
    }
  });

  users.initialize();

  $(".js-quote-source-name").keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });

  $('.js-quote-source-name').keyup(function(event) {
    $(".js-quote-citable-id").val("");
    if ($(this).val().trim().charAt(0) == '@') {
      $(".js-quote-citable-type").val("User");
    } else {
      $(".js-quote-citable-type").val("Source");
    }
  });

  $('.js-quote-source-name').typeahead(null, {
    name: 'users',
    source: users.ttAdapter(),
    templates: {
      suggestion: Handlebars.compile([
        '<p>{{name}}</p>'
      ].join(''))
    }
  }).on('typeahead:selected', function(event, selection) {
    $(".js-quote-citable-id").val(selection.id);
    $(".js-quote-source-name").val(selection.name);
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
});
