# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $(document).ajaxStart ->
      $('#loading').show()
      # show loading indicator
      return
    $(document).ajaxStop ->
      $('#loading').hide()
      # hide loading indicator
      return