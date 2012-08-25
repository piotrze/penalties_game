Fabricator(:series) do
  a_goal true
  b_goal false
  a_shooted true
  b_shooted true
  complete true
  game {Fabricate.build(:game)}
end
