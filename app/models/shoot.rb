class Shoot
  attr_accessor :shoot_cord, :safe_cord

  def goal?
    shoot_cord == safe_cord
  end
end
