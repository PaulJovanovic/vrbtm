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
//= require jquery
//= require jquery_ujs
//= require jquery.timeago
//= require jquery.typeahead
//= require turbolinks
//= require handlebars
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
});
