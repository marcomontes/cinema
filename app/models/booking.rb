class Booking < Sequel::Model
  many_to_one :calendar

  attr_accessor :movie_id
  attr_accessor :movie_date

  def self.between_dates(init_date, end_date)
    # join(:calendars, movie_date: init_date..end_date)
    calendars = Calendar.where(movie_date: init_date..end_date)
    bookings  = where(calendar_id: calendars.map(&:id)).group_and_count(:calendar_id)
    results = []
    
    bookings.each do |booking|
      calendar = Calendar.where(id: booking[:calendar_id]).first
      movie = Movie.where(id: calendar.movie_id).first
      results << { movie: movie.name, date: calendar[:movie_date], bookings: booking[:count] }
    end
    
    return results
  end

  def self.create_with_date(movie_id, date)
    movie_calendar = Calendar.where(movie_date: date, movie_id: movie_id).last
    booking = new(calendar: movie_calendar, movie_id: movie_calendar.movie_id, movie_date: movie_calendar.movie_date)
    
    begin
      booking.save
      return booking
    rescue => e
      return { error: booking.errors.present? ? booking.errors[:calendar_id].join : 'Error' }
    end
  end

  def validate
    super
    movie_calendar = Calendar.where(movie_date: self.movie_date, movie_id: self.movie_id).last
    active_bookings = Booking.where(calendar: movie_calendar)

    if active_bookings.count >= 10
      errors.add(:calendar_id, "This movie reach the booking limit")
    end
  end
end
