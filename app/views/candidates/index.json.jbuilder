json.array!(@candidates) do |candidate|
  json.extract! candidate, :email, :is_send, :is_signup, :tournament_id
  json.url candidate_url(candidate, format: :json)
end
