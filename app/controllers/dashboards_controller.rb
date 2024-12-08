class DashboardsController < ApplicationController
# app/controllers/dashboards_controller.rb
before_action :ensure_admin, only: [:admin_dashboard]
before_action :ensure_party_agent, only: [:party_agent_dashboard]


def party_agent_dashboard
  @constituencies = Constituency.includes(:candidates).all
  @votes = Vote.new
end

def admin_dashboard
  # Total counts
  @total_candidates = Candidate.count
  @total_votes = Vote.sum(:vote_count)

  # Candidates grouped by type (assuming a `candidate_type` column exists)
  @candidates_by_type = Candidate.group(:candidate_type).count

  # Candidate data for the table
  total_votes_count = Vote.sum(:vote_count).to_f
  @candidate_data = Candidate
                      .joins(:votes)
                      .select("candidates.name, candidates.candidate_type, SUM(votes.vote_count) AS vote_count")
                      .group("candidates.id")
                      .map do |candidate|
                        {
                          name: candidate.name,
                          candidate_type: candidate.candidate_type,
                          vote_count: candidate.vote_count.to_i,
                          vote_percentage: ((candidate.vote_count.to_f / total_votes_count) * 100).round(2)
                        }
                      end

  # Constituency votes for the chart
  @votes_by_constituency = Constituency
                             .joins(candidates: :votes)
                             .group("constituencies.name")
                             .pluck("constituencies.name, SUM(votes.vote_count)")
                             .map { |name, votes| { name: name, votes: votes } }
end


private

def ensure_admin
  redirect_to root_path, alert: 'Access denied!' unless user_signed_in? && current_user.admin?
end

def ensure_party_agent
  redirect_to root_path, alert: 'Access denied!' unless current_user.party_agent?
  end
end
