class Judge
  attr_accessor :game, :shoot 
  
  def initialize(game)
    self.game = game
  end

  def judge_shoot(x,y)
    shoot = Shoot.new(shoot_cord: [x, y], safe_cord: random_cord())
    serie = @game.series.find_or_create_by(completed: false)
    serie.a_goal = shoot.result

  end

  #TODO almost the same method as judge_shoot, but now it's more clear
  def judge_safe(x,y)
    shoot = Shoot.new(shoot_cord: random_cord(), safe_cord: [x, y])
    serie = @game.series.find_or_create_by(completed: false)
    serie.b_goal = shoot.result
  end

  def goal?
    @shoot.result
  end

  private
  def random_cord
    [rand(5), rand(3)]  
  end

  def 
end
