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
//= require jquery.cookie
// = require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui/resizable
//= require_tree .

jQuery(document).ready(function () {

   if ($.cookie('noShowWelcome')) $('.email').hide();
    else {
        $(".close-welcome").click(function() {
            $(".email").fadeOut(1000);
            $.cookie('noShowWelcome', true);    
        });
    }
  $( ".open" ).click(function(){
    if ($(window).width() < 550){
      $('.post').animate({
      width: "100%",
      left: "0%"
    }, 50);
    }
   else{ $('.post').animate({
      width: "60%",
      left: "40%"
    }, 50);
 }
  });


$(function() {

  // Find all YouTube videos
  var $allVideos = $("iframe[src^='http://www.youtube.com']"),

      // The element that is fluid width
      $fluidEl = $("body");

  // Figure out and save aspect ratio for each video
  $allVideos.each(function() {

    $(this)
      .data('aspectRatio', this.height / this.width)
      
      // and remove the hard coded width/height
      .removeAttr('height')
      .removeAttr('width');

  });

  // When the window is resized
  // (You'll probably want to debounce this)
  $(window).resize(function() {

    var newWidth = $fluidEl.width();
    
    // Resize all videos according to their own aspect ratio
    $allVideos.each(function() {

      var $el = $(this);
      $el
        .width(newWidth)
        .height(newWidth * $el.data('aspectRatio'));

    });

  // Kick off one resize to fix all videos on page load
  }).resize();

});
  

    $('.screen').click(function() { 
 history.replaceState(null, "A new title!", "/");
  $('body').removeClass('no-scroll')
  $('.post').animate({
      left: "100%"
    }, 200);
  $('.post').append('<img id="loading" src="assets/showtime.gif" />')
  $('.screen').remove();  
});
     $('.url').click(function() { 
        window.open($('.url').attr('id'));
     });

});
