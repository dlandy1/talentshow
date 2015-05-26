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
// = require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui/resizable
//= require_tree .
jQuery(document).ready(function () {
  $( ".open" ).click(function(){
    $('.post').animate({
      width: "60%",
      left: "40%"
    }, 50);
  });

  

    $('.screen').click(function() { 
 history.replaceState(null, "A new title!", "/");
  $('body').removeClass('no-scroll')
  $('.post').animate({
      left: "100%"
    }, 200);
  $('.post').html('<img id="loading" src="assets/showtime.gif" />')
  $('.screen').remove();  
});
     $('.url').click(function() { 
        window.open($('.url').attr('id'));
     });

});
