class Review
  attr_accessor :full_review, :number, :id, :type, :game_id, :engine, :engine_version, :network, :network_size, :date, :strength, :win_rate, :moves
  @@all = []

  def initialize(attributes, number:)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @number = number
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.find_by_number(number)
    @@all.find{|review| review.number == number}
  end

  def check

    puts "Checking player submitted moves against #{@engine} #{@type} review ##{@id}..."
    review = load_review
    review.process
    puts ""
    puts "-----------------------------------------------------"
    puts "Black Tier 1 Moves: #{review.black_tier_1[0]} --- #{review.black_tier_1[1].round(2)}%"
    puts "Black Tier 2 Moves: #{review.black_tier_2[0]} --- #{review.black_tier_2[1].round(2)}%"
    puts "Black Tier 3 Moves: #{review.black_tier_3[0]} --- #{review.black_tier_3[1].round(2)}%"
    puts "Black Tier 4 Moves: #{review.black_tier_4[0]} --- #{review.black_tier_4[1].round(2)}%"
    puts "-----------------------------------------------------"
    puts "White Tier 1 Moves: #{review.white_tier_1[0]} --- #{review.white_tier_1[1].round(2)}%"
    puts "White Tier 2 Moves: #{review.white_tier_2[0]} --- #{review.white_tier_2[1].round(2)}%"
    puts "White Tier 3 Moves: #{review.white_tier_3[0]} --- #{review.white_tier_3[1].round(2)}%"
    puts "White Tier 4 Moves: #{review.white_tier_4[0]} --- #{review.white_tier_4[1].round(2)}%"
    puts "-----------------------------------------------------"
    puts "Black Total Top Moves: #{review.black_total[0]} --- #{review.black_total[1].round(2)}%"
    puts "White Total Top Moves: #{review.white_total[0]} --- #{review.white_total[1].round(2)}%"
    puts "-----------------------------------------------------"

  end

  def load_review
    FullReview.new(JSON.parse(Faraday.get("https://online-go.com/termination-api/game/#{@game_id}/ai_review/#{@id}").body))
  end
end
