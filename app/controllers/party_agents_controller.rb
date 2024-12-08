class PartyAgentsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is signed in
  before_action :authenticate_admin! # Ensure the logged-in user is an admin

  def index
    @party_agents = User.where(role: 'party_agent') # or however you track party agents
  end

  def new
    @party_agent = User.new
  end

  def create
    @party_agent = User.new(party_agent_params)
    @party_agent.role = 'party_agent'  # Set role to party_agent

    if @party_agent.save
      redirect_to party_agents_path, notice: 'Party Agent was successfully created.'
    else
      render :new
    end
  end

  def edit
    @party_agent = User.find(params[:id]) # Find the specific party agent
  end

  def update
    @party_agent = User.find(params[:id])
    if @party_agent.update(user_params)
      redirect_to party_agents_path, notice: 'Party Agent email updated successfully.'
    else
      render :edit
    end
  end
  

  private

  def authenticate_admin!
    # You can use this custom method to check if the user has the admin role
    redirect_to root_path, alert: 'Access denied' unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email) # Permit the email field to be updated
  end

  def party_agent_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
