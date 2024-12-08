class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    Rails.logger.debug("User role: #{resource.role}")
    if resource.admin?
      admin_dashboard_path
    elsif resource.role == 'party_agent'
      party_agent_dashboard_path
    else
      root_path
    end
  end 
  
    # Check if the user is signed in
  def user_signed_in?
    current_user.present?
  end
end
