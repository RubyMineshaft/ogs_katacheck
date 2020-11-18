class Review
  attr_accessor :full_review, :number, :uuid, :id, :type, :game_id, :engine, :engine_version, :network, :network_size, :date, :strength, :win_rate, :moves
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

    # table = Terminal::Table.new title: "Results".bold, headings: ['Color'.bold, 'Tier'.bold, "#".bold, "%".bold]
    # x = 1
    # while x < 4 do
    #   table.add_row [x == 2 ? "Black".bold : nil, x, review.public_send("black_tier_#{x}")[0], review.public_send("black_tier_#{x}")[1].round(2)]
    #   x += 1
    # end
    #
    # table.add_separator
    # table.add_row [{:value => 'Total'.bold, :colspan => 2, :alignment => :center}, review.black_total[0], "#{review.black_total[1].round(2)}%"]
    # table.add_separator
    # table.add_separator
    #
    # x = 1
    # while x < 4 do
    #   table.add_row [x == 2 ? "White".bold : nil, x, review.public_send("black_tier_#{x}")[0], review.public_send("black_tier_#{x}")[1].round(2)]
    #   x += 1
    # end
    #
    # table.add_separator
    #
    # table.add_row [{:value => 'Total'.bold, :colspan => 2, :alignment => :center}, review.white_total[0], "#{review.white_total[1].round(2)}%"]
    #
    # table.style = {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
    #
    # puts table

    table = Terminal::Table.new title: "Results".bold, headings: ['Tier'.bold, "#".bold, "%".bold]
    x = 1
    table.add_row [{value: "Black".bold.light_white.on_black, alignment: :center, colspan: 3}]
    table.add_separator
    while x < 4 do
      table.add_row [x, {value: review.public_send("black_tier_#{x}")[0], alignment: :center}, {value: review.public_send("black_tier_#{x}")[1].round(2).to_s + " %", alignment: :center}]
      x += 1
    end

    table.add_separator
    table.add_row [{:value => 'Total'.bold, :alignment => :center}, review.black_total[0], "#{review.black_total[1].round(2)}%"]
    table.add_separator

    table.add_row [{value: "White".bold.black.on_light_white.blink, alignment: :center, colspan: 3}]
    table.add_separator
    x = 1
    while x < 4 do
      table.add_row [x, review.public_send("white_tier_#{x}")[0], review.public_send("white_tier_#{x}")[1].round(2).to_s + " %"]
      x += 1
    end

    table.add_separator

    table.add_row [{:value => 'Total'.bold, :alignment => :center}, review.white_total[0], "#{review.white_total[1].round(2)}%"]

    table.style = {:width => 70, :padding_left => 2, :border_x => "=".blue, :border_i => "x".blue, :alignment => :center}

    puts table

    # puts ""
    # puts "^^ new"
    # puts "vv old"
    # puts ""
    # puts "-----------------------------------------------------"
    # puts "Black Tier 1 Moves: #{review.black_tier_1[0]} --- #{review.black_tier_1[1].round(2)}%"
    # puts "Black Tier 2 Moves: #{review.black_tier_2[0]} --- #{review.black_tier_2[1].round(2)}%"
    # puts "Black Tier 3 Moves: #{review.black_tier_3[0]} --- #{review.black_tier_3[1].round(2)}%"
    # puts "Black Tier 4 Moves: #{review.black_tier_4[0]} --- #{review.black_tier_4[1].round(2)}%"
    # puts "-----------------------------------------------------"
    # puts "White Tier 1 Moves: #{review.white_tier_1[0]} --- #{review.white_tier_1[1].round(2)}%"
    # puts "White Tier 2 Moves: #{review.white_tier_2[0]} --- #{review.white_tier_2[1].round(2)}%"
    # puts "White Tier 3 Moves: #{review.white_tier_3[0]} --- #{review.white_tier_3[1].round(2)}%"
    # puts "White Tier 4 Moves: #{review.white_tier_4[0]} --- #{review.white_tier_4[1].round(2)}%"
    # puts "-----------------------------------------------------"
    # puts "Black Total Top Moves: #{review.black_total[0]} --- #{review.black_total[1].round(2)}%"
    # puts "White Total Top Moves: #{review.white_total[0]} --- #{review.white_total[1].round(2)}%"
    # puts "-----------------------------------------------------"

  end

  def load_review
    FullReview.new(JSON.parse(Faraday.get("https://online-go.com/termination-api/game/#{@game_id}/ai_review/#{@id}").body))
  end
end
