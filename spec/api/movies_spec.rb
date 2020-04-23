require 'spec_helper'

describe Cinema::API do
  include Rack::Test::Methods

  def app
    Cinema::App.instance
  end

  it 'should return movies given a week day' do
    get '/api/movies', { "day": 4 }, format: :json
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("id")
    expect(last_response.body).to include("name")
    expect(last_response.body).to include("description")
    expect(last_response.body).to include("image_url")
  end

  it "creates a movie" do
    params = {
      "movie": {
        "name": "Alien",
        "description": "Alien is a 1979 science-fiction horror film directed by Ridley Scott and written by Dan O'Bannon. Based on a story by O'Bannon and Ronald Shusett, it follows the crew of the commercial space tug Nostromo, who encounter the eponymous Alien, a deadly and aggressive extraterrestrial set loose on the ship.",
        "image_url": "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Alien_movie_poster.jpg/220px-Alien_movie_poster.jpg"
      },
      "dates": ["2020-04-23", "2020-04-24", "2020-04-25", "2020-04-26", "2020-04-27", "2020-04-28"]
    }
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/movies", params, headers: headers

    expect(last_response.status).to eq(201)
    expect(last_response.body).to include("Alien")
  end

  it "should validate movie creation" do
    params = {
      "movie": {
        "name": "",
        "description": "Alien is a 1979 science-fiction horror film directed by Ridley Scott and written by Dan O'Bannon. Based on a story by O'Bannon and Ronald Shusett, it follows the crew of the commercial space tug Nostromo, who encounter the eponymous Alien, a deadly and aggressive extraterrestrial set loose on the ship.",
        "image_url": "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Alien_movie_poster.jpg/220px-Alien_movie_poster.jpg"
      },
      "dates": ["2020-04-23", "2020-04-24", "2020-04-25", "2020-04-26", "2020-04-27", "2020-04-28"]
    }
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/movies", params, headers: headers

    expect(last_response.body).to include("Name cannot be empty")
  end

end
