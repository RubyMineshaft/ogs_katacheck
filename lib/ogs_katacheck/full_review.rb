class FullReview
  attr_accessor :win_rates, :uuid, :scores, :id, :type, :game_id, :engine, :engine_version, :network, :network_size, :date, :strength, :win_rate, :moves,
    :total_moves, :black_tier_1, :black_tier_2, :black_tier_3, :black_tier_4, :white_tier_1, :white_tier_2, :white_tier_3, :white_tier_4, :black_total, :white_total

  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @black_tier_1 = [0, 0]
    @black_tier_2 = [0, 0]
    @black_tier_3 = [0, 0]
    @black_tier_4 = [0, 0]
    @black_total = [0, 0]
    @white_total = [0, 0]
    @white_tier_1 = [0, 0]
    @white_tier_2 = [0, 0]
    @white_tier_3 = [0, 0]
    @white_tier_4 = [0, 0]

    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def calculate_percentages
    white_moves = (@total_moves / 2.0).floor
    black_moves = (@total_moves / 2.0).ceil

    @black_tier_1[1] = @black_tier_1[0].to_f / black_moves * 100
    @black_tier_2[1] = @black_tier_2[0].to_f / black_moves * 100
    @black_tier_3[1] = @black_tier_3[0].to_f / black_moves * 100
    @black_tier_4[1] = @black_tier_4[0].to_f / black_moves * 100
    @white_tier_1[1] = @white_tier_1[0].to_f / white_moves * 100
    @white_tier_2[1] = @white_tier_2[0].to_f / white_moves * 100
    @white_tier_3[1] = @white_tier_3[0].to_f / white_moves * 100
    @white_tier_4[1] = @white_tier_4[0].to_f / white_moves * 100

    @black_total[0] = @black_tier_1[0] + @black_tier_2[0] + @black_tier_3[0] + @black_tier_4[0]
    @white_total[0] = @white_tier_1[0] + @white_tier_2[0] + @white_tier_3[0] + @white_tier_4[0]

    @white_total[1] = @white_tier_1[1] + @white_tier_2[1] + @white_tier_3[1] + @white_tier_4[1]
    @black_total[1] = @black_tier_1[1] + @black_tier_2[1] + @black_tier_3[1] + @black_tier_4[1]
  end


  def process
    @total_moves = @moves.count;

    @moves.each do |move|
      current_move = move[1]["move_number"]
      previous_move = @moves[(current_move.to_i - 1).to_s]
      move_made = move[1]["move"]
      if current_move.to_i >= 2
        if previous_move["branches"][0]["moves"][0] == move_made
          current_move % 2 == 0 ? @white_tier_1[0] += 1 : @black_tier_1[0] += 1
        elsif previous_move["branches"].count >= 2 && previous_move["branches"][1]["moves"][0] == move_made
          current_move % 2 == 0 ? @white_tier_2[0] += 1 : @black_tier_2[0] += 1
        elsif previous_move["branches"].count >= 3 && previous_move["branches"][2]["moves"][0] == move_made
          current_move % 2 == 0 ? @white_tier_3[0] += 1 : @black_tier_3[0] += 1
        elsif previous_move["branches"].count >= 4 && previous_move["branches"][3]["moves"][0] == move_made
          current_move % 2 == 0 ? @white_tier_4[0] += 1 : @black_tier_4[0] += 1
        end
      end
    end
    calculate_percentages
  end
end
