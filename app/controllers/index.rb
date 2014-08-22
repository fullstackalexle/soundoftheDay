get '/' do
  erb :signin
end

get '/index' do
  erb :index
end

post '/authenticate' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    erb :index
  else
    @error = "Invalid username and/or email"
    erb :signin
  end
end

get '/users/new' do
  erb :signup
end

post '/users/new' do
  user = User.new(params[:signup])
  if user.save
    session[:user_id] = user.id
    erb :index
  else
    @error = "Unable to sign up with that username or email"
    erb :signup
  end
end

get '/users/show' do
  erb :'users/show'
end

post '/genreoftheday' do
  @query_date = params[:date]
  @latest_fifty = $client.get('/tracks', :created_at => {:to => @query_date})
  @latest_fifty = @latest_fifty.sort_by { |track| track[:playback_count] }.reverse
  @latest_fifty.to_json
end

post '/addtrack/show' do
  @playlists = current_user.playlists
  @new_track = params[:add_track]
  @new_track = $client.get('/tracks', :ids => @new_track.keys[0].to_i )[0]
  erb :'tracks/show'
end

post '/addtrack/new' do
  if params[:playlist_new]
    new_track = Track.create(params[:new_track])
    playlist = Playlist.create(title: params[:playlist_new], user_id: current_user.id)
    new_track.update(playlist_id: playlist.id)
    redirect '/users/show'
  elsif params[:playlist]
    playlist = Playlist.find(params[:playlist].to_i)
    new_track = Track.create(params[:new_track])
    new_track.update(playlist_id: playlist.id)
    redirect '/users/show'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end


