get '/' do
  erb :index
end

post '/genreoftheday' do
  @query_date = params[:date]
  @latest_fifty = $client.get('/tracks', :created_at => {:to => @query_date}, :limit => 200)
  @latest_fifty = @latest_fifty.sort_by { |track| track[:playback_count] }.reverse
  @latest_fifty.to_json
end


