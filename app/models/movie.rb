class Movie < Sequel::Model
  
  def self.create_from_api(name, description, image_url, dates = [])
    movie = self.create(name: name, description: description, image_url: image_url)
    dates.each do |date|
      Calendar.create(movie_id: movie[:id], movie_date: date)
    end

    #   movie_calendar = Calendar.where(movie_date: '2020-04-22', movie_id: 1).last
    #   Booking.create(calendar: movie_calendar, movie_id: 1, movie_date: '2020-04-22')
    #   movie_calendar = Calendar.where(movie_date: '2020-04-22', movie_id: 2).last
    #   Booking.create(calendar: movie_calendar, movie_id: 2, movie_date: '2020-04-22')

    return movie
  end

end
