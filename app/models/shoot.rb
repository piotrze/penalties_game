class Shoot
  attr_accessor :shoot_cord, :safe_cord

  def initialize(options)
    for k,v in options
      self.send "#{k}=", v.map(&:to_i)
    end
  end

  def goal?
    shoot_cord != safe_cord
  end
end
