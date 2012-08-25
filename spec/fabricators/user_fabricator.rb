Fabricator(:user) do
  email { sequence(:email) {|n| "email#{n}@example.org"} }
end
