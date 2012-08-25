class Serie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :a_goal,        type: Boolean
  field :b_goal,        type: Boolean
  field :number,        type: Integer, default: 1
  field :complete,      type: Boolean, default: false

end
