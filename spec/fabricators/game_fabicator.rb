Fabricator(:game) do
  player_a {Fabricate(:user)}
  player_b {Fabricate(:user)}
end
