class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :next_role,       type: String# shoot|safe
  field :ended,           type: Boolean
  field :max_series,      type: Integer, default: 5 

  belongs_to :player_a, class_name: 'User'
  belongs_to :player_b, class_name: 'User'
  belongs_to :winner,   class_name: 'User' 

  embeds_many :series


  validates :player_a, :player_b, presence: true
  validates :next_role, inclusion: {in: %w(shoot safe)}

  before_save :random_role

  def result

  end

  private

  def random_role 
    self.next_role = rand(2) == 0 ? 'shoot' : 'safe'
  end

  def toggle_role
    self.next_role = self.next_role == 'shoot' ? 'safe' : 'shoot'
  end
end
