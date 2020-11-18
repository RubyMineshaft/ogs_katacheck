class OGSKataCheck::CLI

  def call
    puts "Enter the Game ID you'd like to check for AI use:"

    game_id = gets.strip
    get_reviews(game_id)
    show_review_menu(game_id)
    check_id = gets.strip.to_i
    check(check_id)
    puts ""
    puts "Check another game? (Y/N)"
    input = gets.strip.downcase
    if input == "y"
      Review.destroy_all
      FullReview.destroy_all
      call
    else
      show_farewell
    end
  end

  def get_reviews(game_id)
    response = Faraday.get "https://online-go.com/api/v1/games/#{game_id}/ai_reviews"
    data = JSON.parse(response.body)
    data.each_with_index do |review, index|
      Review.new(review, number: index + 1)
    end

  end

  def show_review_menu(game_id)
    puts ""
    puts ""
    puts "Game ID: #{game_id}"
    puts ""
    puts "The following reviews are available:"

    Review.all.each do |review|
      review.date = Time.new(review.date.slice(0,4), review.date.slice(5, 2), review.date.slice(8, 2), review.date.slice(11, 2), review.date.slice(14, 2), review.date.slice(17, 2), "+00:00")
      puts "#{review.number}.  #{review.id} -- #{review.engine} -- #{review.type} -- #{review.date.localtime.strftime("%e %b %Y, %I:%M%p %Z")}"
    end

    puts ""
    puts "Enter the number of a review to check:"

  end

  def check(check_id)
    puts "Processing. Please wait..."
    review = Review.find_by_number(check_id)
    review.check
  end

  def show_farewell
    puts "Goodbye!"
  end

end
