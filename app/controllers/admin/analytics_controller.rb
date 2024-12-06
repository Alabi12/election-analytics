class Admin::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    # Total candidates count
    @total_candidates = Candidate.count

    # Total vote count
    @total_votes = Vote.sum(:vote_count)

    # Breakdown of candidates by type and their vote counts
    @candidates_by_type = Candidate.group(:candidate_type).count

    # Candidate-wise votes and percentage calculations
    @candidate_data = Candidate.includes(:votes).map do |candidate|
      {
        name: candidate.name,
        candidate_type: candidate.candidate_type,
        vote_count: candidate.votes.sum(:vote_count),
        vote_percentage: calculate_percentage(candidate.votes.sum(:vote_count))
      }
    end
  end

  private

  # Ensure the user is an admin
  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied"
    end
  end

  # Calculate the percentage of total votes for a candidate
  def calculate_percentage(vote_count)
    return 0 if @total_votes.zero?
    ((vote_count.to_f / @total_votes) * 100).round(2)
  end
end
