class Series
  include Mongoid::Document
  include Mongoid::Timestamps

  field :a_goal,        type: Boolean
  field :b_goal,        type: Boolean
  field :a_shooted,     type: Boolean, default: false
  field :b_shooted,     type: Boolean, default: false
  field :number,        type: Integer, default: 1
  field :complete,      type: Boolean, default: false


  embedded_in :game
  before_save :check_if_completed

  private

  def check_if_completed
    if self.a_shooted && self.b_shooted
      self.complete = true
    end
  end

end
