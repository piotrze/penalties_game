class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  MAX_SERIES_NUMBER = 5

  field :next_role,       type: String# shoot|safe
  field :ended,           type: Boolean

  belongs_to :player_a, class_name: 'User'
  belongs_to :player_b, class_name: 'User'
  belongs_to :winner,   class_name: 'User' 

  embeds_many :series


  validates :player_a, :player_b, presence: true
  validates :next_role, inclusion: {in: %w(shoot safe)}

  before_validation :random_role, on: :create


  def self.oposite_role(role)
    role == 'shoot' ? 'safe' : 'shoot'
  end
  
  def toggle_role
    self.next_role = Game.oposite_role(self.next_role)
  end

  private

  def random_role 
    self.next_role = rand(2) == 0 ? 'shoot' : 'safe'
  end

end
