class Movie::Create < BaseTransaction
  tee :params
  step :create_movie
  step :create_calendars
  
  def params(input)
    @params = input.fetch(:params)
  end

  def create_movie(input)
    @movie = Movie.new(@params[:movie])
    @movie.save
    Success(@movie)
  rescue
    Failure(error: @movie.errors.map{|k,v| v}.join(' | '))
  end

  def create_calendars(input)
    @params[:dates].each do |date|
      Calendar.create(movie_id: @movie.id, movie_date: date)
    end
    Success(@movie)
  rescue StandardError => exception
    Failure(error: exception)
  end

end
