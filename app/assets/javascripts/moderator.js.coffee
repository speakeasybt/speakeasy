$(document).on 'ready page:load', ->  
  jQuery ->
    $(".log-container").click ->
      $(".log-metadata").slideToggle()
