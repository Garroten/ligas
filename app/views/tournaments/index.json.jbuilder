json.array!(@tournaments) do |tournament|
  json.extract! tournament, :name, :ispairs, :players_number, :signup_limit_date, :start_date, :end_date
  json.url tournament_url(tournament, format: :json)
end
