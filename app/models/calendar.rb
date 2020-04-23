class Calendar < Sequel::Model
  one_to_many :movies
  one_to_many :bookings

  def self.get_movies_by_day(day_selected)
    date = get_date_by_day(day_selected)
    movie_ids = where(movie_date: date).map(&:movie_id)
    movies = Movie.where(id: movie_ids)
    return movies
  end

  def self.get_date_by_day(day_selected)
    date = Date.today
    day_number = date.wday

    search_date = if day_selected == 1
      date - day_number + 1
    elsif day_number > day_selected
      date + (day_number - day_selected)
    elsif day_number < day_selected
      date + (day_selected - day_number)
    else
      date
    end

    return search_date
  end

end
