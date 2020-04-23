module Cinema
  class Movies < Grape::API
    format :json

    resource :movies do
      desc 'List movies within a date.'
      get do
        Calendar.get_movies_by_day(params[:day].to_i)
      end
      
      desc 'Create a movie.'
      post do
        Movie::Create.call(params: params)
      end
    end

  end
end
