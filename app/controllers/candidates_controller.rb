class CandidatesController < ApplicationController
  before_action :set_constituency
  before_action :set_candidate, only: %i[edit update destroy]

  def new
    @candidate = @constituency.candidates.new
  end

  def create
    @candidate = @constituency.candidates.new(candidate_params)
    if @candidate.save
      redirect_to @constituency, notice: 'Candidate created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @candidate.update(candidate_params)
      redirect_to @constituency, notice: 'Candidate updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to @constituency, notice: 'Candidate deleted successfully.'
  end

  private

  def set_constituency
    @constituency = Constituency.find(params[:constituency_id])
  end

  def set_candidate
    @candidate = @constituency.candidates.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:name, :party, :bio)
  end
end
