class CandidatesController < ApplicationController
  before_action :set_constituency
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /constituencies/:constituency_id/candidates
  def index
    @presidential_candidates = @constituency.candidates.where(candidate_type: 'Presidential')
    @parliamentary_candidates = @constituency.candidates.where(candidate_type: 'Parliamentary')
  end

  # GET /constituencies/:constituency_id/candidates/new
  def new
    @candidate = @constituency.candidates.build
  end

  # POST /constituencies/:constituency_id/candidates
  def create
    @candidate = @constituency.candidates.build(candidate_params)
    if @candidate.save
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
    params.require(:candidate).permit(:name, :party, :candidate_type, :image)
  end
end
