class Booking < Sequel::Model
  many_to_one :calendar

  attr_accessor :movie_id
  attr_accessor :movie_date

  def self.between_dates(init_date, end_date)
    join(:calendars, movie_date: init_date..end_date)
  end

  def validate
    super
    movie_calendar = Calendar.where(movie_date: self.movie_date, movie_id: self.movie_id).last
    active_bookings = Booking.where(calendar: movie_calendar)

    if active_bookings.count > 10
      errors.add(:calendar_id, "This movie reach the booking limit")
    end
  end
end
