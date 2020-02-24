require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

#enter your Dark Sky API key here
ForecastIO.api_key = "0798299ae02b2b089bd1afa7a16ba7c2"

get "/" do
   view "location"
end

get "/news" do
    results = Geocoder.search(params["q"])
    latlong = results.first.coordinates
    lat = "#{latlong[0]}"
    long = "#{latlong[1]}"
    @forecast = ForecastIO.forecast("#{lat}","#{long}").to_hash
    @current_temp = @forecast["currently"]["temperature"]
    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ea424f6ab854fe0be46492d7ac3f5cc"
    news = HTTParty.get(url).parsed_response.to_hash
    @story1 = news["articles"][0]["title"]
    @story2 = news["articles"][1]["title"]
    @story3 = news["articles"][2]["title"]
    @story4 = news["articles"][3]["title"]
    @story5 = news["articles"][4]["title"]
    @story6 = news["articles"][5]["title"]
    @story7 = news["articles"][6]["title"]
    @story8 = news["articles"][7]["title"]
    @story9 = news["articles"][7]["title"]
    view "ask"
end
   