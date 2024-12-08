class ConstituenciesController < ApplicationController
  before_action :set_constituency, only: [:show, :edit, :update, :destroy]

  # GET /constituencies
  def index
    @constituencies = Constituency.all
  end

  # GET /constituencies/:id
  def show
    @candidate = Candidate.new  # Used in the "new" form for candidates
  end

  # GET /constituencies/new
  def new
    @constituency = Constituency.new
  end

  # POST /constituencies
  def create
    @constituency = Constituency.new(constituency_params)
    
    if @constituency.save
      redirect_to @constituency, notice: 'Constituency created successfully.'
    else
      render :new
    end
  end

  # GET /constituencies/:id/edit
  def edit; end

  # PATCH/PUT /constituencies/:id
  def update
    if @constituency.update(constituency_params)
      redirect_to @constituency, notice: 'Constituency updated successfully.'
    else
      render :edit
    end
  end

  # DELETE /constituencies/:id
  def destroy
    @constituency.destroy
    redirect_to constituencies_path, notice: 'Constituency deleted successfully.'
  end

  private

  # Sets the constituency for the actions that need it (show, edit, update, destroy)
  def set_constituency
    @constituency = Constituency.find(params[:id])
  end

  # Strong parameters for constituency
  def constituency_params
    params.require(:constituency).permit(:name, :region)
  end
end
