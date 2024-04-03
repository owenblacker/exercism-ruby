# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  FULL_PRICE = 15
  DISCOUNT_PRICE = 10
  SCARY_MOVIE_AGE_THRESHOLD = 18
  
  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    return @age >= 60 ? DISCOUNT_PRICE : FULL_PRICE
  end

  def watch_scary_movie?
    return  @age >= SCARY_MOVIE_AGE_THRESHOLD
  end

  # Popcorn is 🍿
  def claim_free_popcorn!
    if @member then "🍿"
    else raise NotMovieClubMemberError.new()
    end
  end
end
