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
    @story1title = news["articles"][0]["title"]
    @story2title = news["articles"][1]["title"]
    @story3title = news["articles"][2]["title"]
    @story4title = news["articles"][3]["title"]
    @story5title = news["articles"][4]["title"]
    @story6title = news["articles"][5]["title"]
    @story7title = news["articles"][6]["title"]
    @story8title = news["articles"][7]["title"]
    @story9title = news["articles"][8]["title"]
    @story1img = news["articles"][0]["urlToImage"]
    @story2img = news["articles"][1]["urlToImage"]
    @story3img = news["articles"][2]["urlToImage"]
    @story4img = news["articles"][3]["urlToImage"]
    @story5img = news["articles"][4]["urlToImage"]
    @story6img = news["articles"][5]["urlToImage"]
    @story7img = news["articles"][6]["urlToImage"]
    @story8img = news["articles"][7]["urlToImage"]
    @story9img = news["articles"][8]["urlToImage"]
    @story1url = news["articles"][0]["url"]
    @story2url = news["articles"][1]["url"]
    @story3url = news["articles"][2]["url"]
    @story4url = news["articles"][3]["url"]
    @story5url = news["articles"][4]["url"]
    @story6url = news["articles"][5]["url"]
    @story7url = news["articles"][6]["url"]
    @story8url = news["articles"][7]["url"]
    @story9url = news["articles"][8]["url"]
    view "ask"
end
   