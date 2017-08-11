# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  isLoading = false
  $(window).on 'scroll', ->
    more_posts_url = $('.pagination .next_page a').attr('href')
    if !isLoading && more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
      isLoading = true
      $.getScript more_posts_url
        .done( (rendered) ->
          isLoading = false
        )
        .fail (ex) ->
          isLoading = false
    return
  
  