$(document).ready(function() {

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
      for (i = 0; i < data.length; i++){
        if (data[i].artwork_url == null){
          data[i].artwork_url = "https://wiki.openttd.org/images/thumb/6/6d/No_image.png/80px-No_image.png"
        }
        top200Viewport.append("<h1>" + (i+1) + ". " + data[i].title + "</h1>" + "<img src=\'" + data[i].artwork_url + "\'><div style=\'display: inline-block\'><p>Genre: " + data[i].genre + "</p><p>Playback Count: " + data[i].playback_count + "</p><p>Uploaded At: " + data[i].created_at + "</p>"
      )}
    })
  })
});



