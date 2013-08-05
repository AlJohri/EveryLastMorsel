// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.

//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require jquery-fileupload
//= require lib/jquery/jquery.validate.js
//= require bootstrap-wysihtml5
//= require editable/bootstrap-editable
//= require editable/rails
//= require elm
//= require map

// Angular Dependencies (not enabled)
// require angular
// require angular-bootstrap
// require angular-resource
// require app
// require_tree ./angular

// Potentially Not Needed jQuery Libraries
// require lib/jquery/jquery.autoSuggest.js
// require lib/jquery/jquery.placeheld.js
// require lib/jquery/jquery.scrollTo.js

$(document).ready(function() {

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

  $.fn.editable.defaults.mode = 'inline';
  $('.editable').editable();

// 	$(".get-started").click(function () {
// 	   $('.section-signup').slideToggle('slow');
// 	   $('.section-signup')[0].scrollIntoView(true);
// 	});

});


