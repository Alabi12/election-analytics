class CandidatesController < ApplicationController
  before_action :set_constituency
  before_action :set_candidate, only: [:show, :edit, :update, :destroy, :add_vote]
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy]

  def index
    # If constituency_id is present, find the constituency and set candidates
    if params[:constituency_id].present? && @constituency
      @candidates = @constituency.candidates
      @presidential_candidates = @constituency.candidates.where(candidate_type: 'Presidential')
      @parliamentary_candidates = @constituency.candidates.where(candidate_type: 'Parliamentary')
    else
      # If no constituency is found, fall back to all candidates or redirect
      @candidates = Candidate.all || []
      @presidential_candidates = []
      @parliamentary_candidates = []
    end
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
    # Try to find the constituency, but rescue from the error if not found
    @constituency = Constituency.find_by(id: params[:constituency_id])
  
    # # If the constituency was not found, redirect or render an error message
    # unless @constituency
    #   flash[:alert] = "Constituency not found"
    #   redirect_to constituencies_path  # Redirect to a valid page (like the list of constituencies)
    # end
  end  

  # Set the candidate to be used for show, edit, update, destroy
  def set_candidate
    @candidate = @constituency.candidates.find(params[:id])
  end

  # Strong parameters to allow only certain attributes for candidates
  def candidate_params
    params.require(:candidate).permit(:name, :party, :candidate_type, :image, :position, :vote_count)
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.admin?
      flash[:alert] = "You must be an admin to access this page."
      redirect_to root_path # Redirect to the home page or login page
    end
  end
end
