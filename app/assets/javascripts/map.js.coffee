#globals for state
map = null
markers = {}
current_bouncing_marker = null

$ ->
  $('#map_side_bar').css 'max-height', $(window).height()
  myLatlng = new google.maps.LatLng(32.463426, -84.979248)
  myOptions =
    zoom: 6
    center: myLatlng
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)

  google.maps.event.addListener(map, 'click', (e) ->
    $.post('/tweets/closest_tweets.json',
      {latitude: e.latLng.lat(), longitude: e.latLng.lng()},
        (data) ->
          add_markers data
      );
  )

add_markers = (data) ->
  #    clear old markers
  current_bouncing_marker = null
  for id, marker of markers
    marker.setMap(null)
  markers = {}

  infowindow = new google.maps.InfoWindow
  $('#map_side_bar').html ''

  for tweet in data
    new_marker = new google.maps.Marker
      position: new google.maps.LatLng(tweet.location.lat, tweet.location.lng)
      map: map
      tweet_id: tweet._id

    content_string = "<div id='#{tweet._id}' class='infowindow')'><img src='#{tweet.pic}'/><p>#{tweet.text}</p></div>"
    new_marker.content_string = content_string

    google.maps.event.addListener new_marker, 'click', () ->
      infowindow.setContent this.content_string
      infowindow.open map, this
      set_selected(this.tweet_id)

    markers[tweet._id] = new_marker

    $('#map_side_bar').append(content_string)

    $("#map_side_bar div##{tweet._id}").click () ->
      set_selected(this.id)

set_selected = (id) ->
  if(current_bouncing_marker != null)
    markers[current_bouncing_marker].setAnimation(0)
  markers[id].setAnimation(google.maps.Animation.BOUNCE)
  $("##{id}").addClass 'selected'
  $("#map_side_bar div##{current_bouncing_marker}").removeClass 'selected'
  current_bouncing_marker = id