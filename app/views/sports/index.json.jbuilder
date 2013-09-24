json.array!(@sports) do |sport|
  json.extract! sport, :name, :ispairs, :playernumber
  json.url sport_url(sport, format: :json)
end
