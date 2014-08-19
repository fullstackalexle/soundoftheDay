get '/' do
  erb :index
end

post '/genreoftheday' do
  @query_date = params[:date]
  @latest_fifty = $client.get('/tracks', :created_at => {:to => @query_date})
  erb :genreoftheday
end


