class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:cancel]

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
  def edit    
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @candidate }
      else
        format.html { render action: 'new' }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url }
      format.json { head :no_content }
    end
  end
  
  def enrole
    @candidate = Candidate.find(params[:id])
    @tournament = Tournament.find(@candidate.tournament_id)
    if @candidate.cancel
      render :template => "candidates/message", :alert => 'Esta peticion ha sido cancelada previamente'
    else
      if @candidate.user_id != nil
        if @candidate.user_id == current_user.id
          redirect_to @tournament, notice: 'Ya estas apuntado al torneo'
        else  
          render :template => "candidates/message", :notice => 'Esta paticion ya ha sido atendida'
        end
      else
        #enrolar            
        if @candidate.update(:user_id => current_user.id, :is_signup => true)
          redirect_to @tournament, notice: 'Candidate was successfully enrolled.'
        end
      end 
    end
  end
  
  def cancel
    @candidate = Candidate.find(params[:id])
    @tournament = Tournament.find(@candidate.tournament_id)
    if @candidate.update(:is_signup => false, :cancel => true)
      render :template => "candidates/message", :notice => 'Tu invitacion ha sido cancelada'
    end         
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:email, :is_send, :is_signup, :tournament_id)
    end
end
