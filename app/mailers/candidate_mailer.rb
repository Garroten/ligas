class CandidateMailer < ActionMailer::Base
  default from: "info@ligas.com"
  
  def join_tournament(user, tournament, candidate)    
    @candidate = candidate
    @user = user
    @tournament = tournament
    @url  = 'http://example.com/login'
    mail(to: @candidate.email, subject: 'Quieres unirte al torneo' + @tournament.name)
  end
end
