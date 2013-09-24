class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
    @tournament.candidatos = ""
    @candidates_num = 1
    @tournament.candidates.each do |candidate|  
      if @tournament.candidates.length == @candidates_num
        @tournament.candidatos = @tournament.candidatos + candidate.name + ":" + candidate.email 
      else 
        @tournament.candidatos = @tournament.candidatos + candidate.name + ":" + candidate.email + ","
      end
      @candidates_num = @candidates_num + 1
    end
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    @candidatos = tournament_params[:candidatos].split(',')

    respond_to do |format|
      if @tournament.save
        @candidatos.each do |candidate| 
          candidate_data = candidate.split(':')
          c = Candidate.new(:name => candidate_data[0], :email => candidate_data[1], :tournament_id => @tournament.id)
          if c.save
            CandidateMailer.join_tournament(current_user, @tournament, c).deliver
          end
        end
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tournament }
      else
        format.html { render action: 'new' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    @candidatos = tournament_params[:candidatos].split(',')
    respond_to do |format|
      if @tournament.update(tournament_params)
        @candidatos.each do |candidate| 
          candidate_data = candidate.split(':')
          c_found = Candidate.find_all_by_email(candidate_data[1])
          if c_found.length == 0
            c = Candidate.new(:name => candidate_data[0], :email => candidate_data[1], :tournament_id => @tournament.id)
            if c.save
              CandidateMailer.join_tournament(current_user, @tournament, c).deliver
            end
          end
        end
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :ispairs, :players_number, :signup_limit_date, :start_date, :end_date, :sport_id, :user_id, :format_id, :candidatos)
    end
end
