class Judge
  attr_accessor :game, :shoot 
  
  def initialize(game)
    self.game = game
  end

  def judge_shoot(x,y, role)
    serie = @game.series.find_or_create_by(complete: false)
    @shoot = Shoot.new(:"#{role}_cord" => [x, y], :"#{Game.oposite_role(role)}_cord" => random_cord())
    if role == 'shoot'
      serie.a_goal = @shoot.goal?
      serie.a_shooted = true
    else
      serie.b_goal = @shoot.goal?
      serie.b_shooted = true
    end
    @game.toggle_role
    check_if_game_ended()
    @game.save!
  end

  def goal?
    @shoot.result
  end

  def check_if_game_ended
    a_points = b_points = 0
    series = @game.series
    series.map{|s|
      a_points += 1 if s.a_goal
      b_points += 1 if s.b_goal
    }

    if (a_points - b_points).abs > 3 || series.size == Game::MAX_SERIES_NUMBER && a_points != b_points
      set_winner(a_points, b_points)
    end
  end


  private
  def random_cord
    [rand(5), rand(3)]  
  end

  def set_winner(a_points, b_points)
    @game.ended = true
    @game.winner = a_points > b_points ? @game.player_a : @game.player_b
  end
end
