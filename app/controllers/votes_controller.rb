class VotesController < ApplicationController
  load_and_authorize_resource
  before_action :set_candidate, only: [:index, :new, :create]
  before_action :set_vote, only: [:edit, :update, :destroy]

  # GET /candidates/:candidate_id/votes
  def index
    @votes = @candidate.votes
  end

  # GET /candidates/:candidate_id/votes/new
  def new
    @vote = @candidate.votes.build
  end

  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to party_agent_dashboard_path, notice: 'Vote count submitted successfully.'
    else
      redirect_to party_agent_dashboard_path, alert: 'Failed to submit votes. Please try again.'
    end
  end

  # GET /candidates/:candidate_id/votes/:id/edit
  def edit
  end

  # PATCH/PUT /candidates/:candidate_id/votes/:id
  def update
    if @vote.update(vote_params)
      redirect_to candidate_votes_path(@candidate), notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /candidates/:candidate_id/votes/:id
  def destroy
    @vote.destroy
    redirect_to candidate_votes_path(@candidate), notice: 'Vote was successfully deleted.'
  end

  private

  def set_candidate
    @candidate = Candidate.find_by(id: params[:candidate_id])
  end

  def set_vote
    @vote = @candidate.votes.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :vote_count)
  end
end
