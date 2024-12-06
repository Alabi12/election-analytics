class CandidatesController < ApplicationController
  before_action :set_constituency
  before_action :set_candidate, only: [:show, :edit, :update, :destroy, :add_vote]

  def index
    if params[:constituency_id]
      @constituency = Constituency.find(params[:constituency_id])
      @candidates = @constituency.candidates
    else
      @candidates = Candidate.all || []
    end

    @presidential_candidates = @constituency.candidates.where(candidate_type: 'Presidential') if @constituency
    @parliamentary_candidates = @constituency.candidates.where(candidate_type: 'Parliamentary') if @constituency
  end

  # GET /constituencies/:constituency_id/candidates/new
  def new
    @candidate = @constituency.candidates.build
  end

  # POST /constituencies/:constituency_id/candidates
  def create
    @candidate = @constituency.candidates.build(candidate_params)
  
    if @candidate.save
      # After the candidate is saved, create an initial vote record
      @candidate.votes.create!(vote_count: params[:candidate][:vote_count].to_i) if params[:candidate][:vote_count].present?
  
      redirect_to constituency_candidates_path(@constituency), notice: 'Candidate was successfully created.'
    else
      render :new
    end
  end  

  # GET /constituencies/:constituency_id/candidates/:id
  def show
    # @candidate is already set by the before_action
  end

  # GET /constituencies/:constituency_id/candidates/:id/edit
  def edit
    # @candidate is already set by the before_action
  end

  # PATCH/PUT /constituencies/:constituency_id/candidates/:id
  def update
    if @candidate.update(candidate_params)
      redirect_to constituency_candidate_path(@constituency, @candidate), notice: 'Candidate was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /constituencies/:constituency_id/candidates/:id
  def destroy
    @candidate.destroy
    redirect_to constituency_candidates_path(@constituency), notice: 'Candidate was successfully destroyed.'
  end

  # POST /constituencies/:constituency_id/candidates/:id/add_votes
  def add_vote
    @candidate.votes.create!(vote_count: params[:vote_count])
    redirect_to constituency_candidate_path(@constituency, @candidate), notice: 'Votes were successfully added.'
  end

  private

  # Set the constituency for the candidate
  def set_constituency
    @constituency = Constituency.find(params[:constituency_id])
  end

  # Set the candidate to be used for show, edit, update, destroy
  def set_candidate
    @candidate = @constituency.candidates.find(params[:id])
  end

  # Strong parameters to allow only certain attributes for candidates
  def candidate_params
    params.require(:candidate).permit(:name, :party, :candidate_type, :image, :position, :vote_count)
  end
end
