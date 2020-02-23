require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

#enter your Dark Sky API key here
ForecastIO.api_key = "0798299ae02b2b089bd1afa7a16ba7c2"

#pp forecast

#url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ea424f6ab854fe0be46492d7ac3f5cc"
#news = HTTParty.get(url).parsed_response.to_hash
#pp news

get "/" do
    "Hello, world"
    #puts "In Evanston, it is currently #{current_temp} degrees."

    #for daily in forecast["daily"]["data"]
        #puts "A high temperature of #{daily["temperatureHigh"]} and #{daily["summary"]}"
    #end
   view "location"
end

get "/news" do
    results = Geocoder.search(params["q"])
    latlong = results.first.coordinates
    lat = "#{latlong[0]}"
    long = "#{latlong[1]}"
    forecast = ForecastIO.forecast("#{lat}","#{long}").to_hash
    current_temp = forecast["currently"]["temperature"]
    "Current temperature: #{current_temp} degrees."
    
    for daily in forecast["daily"]["data"]
        "A high temperature of #{daily["temperatureHigh"]} and #{daily["summary"]}"
    end
    #view "ask"
end