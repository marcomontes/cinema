module Cinema
  class Movies < Grape::API
    format :json

    resource :bookings do
      desc 'List bookings within a date range.'
      get do
        { data: 'List Movies' }
      end
      
      desc 'Create a booking.'
      post do
        { data: 'Create Booking' }
      end
    end

  end
end
