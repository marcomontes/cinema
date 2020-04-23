module Cinema
  class API < Grape::API
    prefix :api
    format :json

    mount ::Cinema::Movies
  end
end
