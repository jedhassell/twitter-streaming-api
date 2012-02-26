map = null
markers = []
$ ->
  myLatlng = new google.maps.LatLng(32.463426, -84.979248)
  myOptions =
    zoom: 4
    center: myLatlng
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)

  google.maps.event.addListener(map, 'click', (e) ->
    $.post('/tweets/map_click',
      {lat: e.latLng.lat(), lng: e.latLng.lng()},
        (data) ->
          add_markers data
      );
  )

add_markers = (data) ->
  for marker in markers
    marker.setMap(null)
  markers = []
  for tweet in data
    markers.push new google.maps.Marker
      position: new google.maps.LatLng(tweet.location[1], tweet.location[0])
      map: map
      title: 'not sure'