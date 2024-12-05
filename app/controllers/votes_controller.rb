class VotesController < ApplicationController
  before_action :set_candidate
  before_action :set_vote, only: [:edit, :update, :destroy]

  def index
    @votes = @candidate.votes
  end

  def new
    @vote = @candidate.votes.build
  end

  def create
    @vote = @candidate.votes.build(vote_params)
    if @vote.save
      redirect_to candidate_votes_path(@candidate), notice: 'Vote was successfully recorded.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vote.update(vote_params)
      redirect_to candidate_votes_path(@candidate), notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vote.destroy
    redirect_to candidate_votes_path(@candidate), notice: 'Vote was successfully deleted.'
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def set_vote
    @vote = @candidate.votes.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:voter_name, :vote_count)
  end
end
