# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#submit').click(get_tweets)

get_tweets = () ->
  params =
    longitude: $('#longitude').val()
    latitude: $('#latitude').val()

  $.post('/tweets/closest_tweets',
    params,
    (data) ->
       $('#tweet_container').html(data)
  );

