require 'spec_helper'

describe Cinema::API do
  include Rack::Test::Methods

  def app
    Cinema::API
  end

  it 'should return booking list given a date range' do
    params =  {"init_date": "2020-04-29", "end_date": "2020-04-30"}
    get '/api/bookings', params, format: :json
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("movie")
    expect(last_response.body).to include("date")
    expect(last_response.body).to include("bookings")
  end

  it "creates a booking" do
    movies  = DB[:movies]
    params  = { "movie_id": movies.all[0][:id], "date": "2020-04-30" }
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/bookings", params, headers: headers

    expect(last_response.status).to eq(201)
    expect(last_response.body).to include("calendar_id")
  end

  it "should not create a booking if there are more than 10 bookings" do
    movies  = DB[:movies]
    params = { "movie_id": movies.all[1][:id], "date": "2020-04-30" }
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/bookings", params, headers: headers

    expect(last_response.status).to eq(201)
    expect(last_response.body).to include("This movie reach the booking limit")
  end

end
