module Cinema
  class Movies < Grape::API
    format :json

    resource :bookings do
      desc 'List bookings within a date range.'
      get do
        Booking.between_dates(params[:init_date], params[:end_date])
      end
      
      desc 'Create a booking.'
      post do
        Booking.create_with_date(params[:movie_id], params[:date])
      end
    end

  end
end
