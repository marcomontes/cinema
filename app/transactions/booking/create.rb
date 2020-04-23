class Booking::Create < BaseTransaction
  tee :params
  step :create_booking
  
  def params(input)
    @params = input.fetch(:params)
  end

  def create_booking(input)
    movie_calendar = Calendar.where(movie_date: @params[:date], movie_id: @params[:movie_id]).last
    @booking = Booking.new(calendar: movie_calendar, movie_id: movie_calendar.movie_id, movie_date: movie_calendar.movie_date)
    @booking.save
    Success(@booking)
  rescue
    Failure(error: @booking.errors.map{|k,v| v}.join(' | '))
  end

end
