class DashboardsController < ApplicationController
# app/controllers/dashboards_controller.rb
before_action :ensure_admin, only: [:admin_dashboard]
before_action :ensure_party_agent, only: [:party_agent_dashboard]


def party_agent_dashboard
  @constituencies = Constituency.includes(:candidates).all
  @votes = Vote.new
end

private

def ensure_admin
  redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
end

def ensure_party_agent
  redirect_to root_path, alert: 'Access denied!' unless current_user.party_agent?
  end
end
