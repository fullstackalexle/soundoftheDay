$(document).ready(function() {

  container = $('.container');
  searchForm = $('#search');
  top200Viewport = $('.top200');

  searchForm.submit(function(event){
    event.preventDefault();
    top200Viewport.children().remove();

    $.ajax('/genreoftheday', {
      type: 'POST',
      data: searchForm.serialize(),
      dataType: "json"
    }).done(function(data){
      container.css('margin', '20px auto');
      container.css('width', '80%');
      for (i = 0; i < data.length; i++){
        trackUrl = data[i].permalink_url.replace(":", "%3A");
        trackUrl = data[i].permalink_url.replace("/", "%2F");
        if (data[i].artwork_url == null){
          data[i].artwork_url = "https://wiki.openttd.org/images/thumb/6/6d/No_image.png/80px-No_image.png"
        }
        top200Viewport.append("<h1>" + (i+1) + ". " + data[i].title + "</h1>" + "<img style=\'margin-right: 10px\' src=\'" + data[i].artwork_url + "\'><div style=\'display: inline-block; width: 70%\'><p>Genre: " + data[i].genre + "</p><p>Playback Count: " + data[i].playback_count + "</p><p>Uploaded At: " + data[i].created_at + "</p></div><object width=\'100%\' style=\'display: block\'><param name=\'movie\' value=\'http://player.soundcloud.com/player.swf?url=" + trackUrl + "&enable_api=true&object_id=yourPlayerId\'></param><param name=\'allowscriptaccess\' value=\'always\'></param><embed allowscriptaccess=\'always\' height=\'81\' src=\'http://player.soundcloud.com/player.swf?url=" + trackUrl + "&enable_api=true&object_id=yourPlayerId\' type=\'application/x-shockwave-flash\' width=\'100%\' name=\'yourPlayerId\'></embed></object>"
      )}
    })
  })
});



