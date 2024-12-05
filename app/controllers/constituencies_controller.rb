class ConstituenciesController < ApplicationController
  before_action :set_constituency, only: %i[show edit update destroy]

  def index
    @constituencies = Constituency.all
  end

  def show
    @candidate = Candidate.new # This will be used in the "new" form for candidates
  end

  def new
    @constituency = Constituency.new
  end

  def create
    @constituency = Constituency.new(constituency_params)
    if @constituency.save
      redirect_to @constituency, notice: 'Constituency created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @constituency.update(constituency_params)
      redirect_to @constituency, notice: 'Constituency updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @constituency.destroy
    redirect_to constituencies_path, notice: 'Constituency deleted successfully.'
  end

  private

  def set_constituency
    @constituency = Constituency.find(params[:id])
  end

  def constituency_params
    params.require(:constituency).permit(:name, :region)
  end
end
