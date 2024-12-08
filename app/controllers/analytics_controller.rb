class AnalyticsController < ApplicationController
  def dashboard
    # Fetch total stats
    @total_candidates = Candidate.count
    @total_votes = Vote.sum(:vote_count)
    @candidates_by_type = Candidate.group(:candidate_type).count

    # Fetch detailed candidate data (grouped by constituency and type)
    @candidate_data = Candidate.all.map do |candidate|
      {
        name: candidate.name,
        image_url: candidate.image.attached? ? url_for(candidate.image) : "https://via.placeholder.com/150",
        candidate_type: candidate.candidate_type,
        vote_count: candidate.votes.sum(:vote_count),
        vote_percentage: @total_votes.positive? ? (candidate.votes.sum(:vote_count).to_f / @total_votes * 100).round(2) : 0,
        constituency_name: candidate.constituency.name
      }
    end

    # Group candidates by constituency and type (presidential vs parliamentary)
    @candidates_by_constituency = Constituency.includes(:candidates).map do |constituency|
      presidential_candidates = constituency.candidates.where(candidate_type: 'Presidential').map do |candidate|
        vote_count = candidate.votes.sum(:vote_count)
        {
          name: candidate.name,
          image_url: candidate.image.attached? ? url_for(candidate.image) : "https://via.placeholder.com/150",
          candidate_type: candidate.candidate_type,
          vote_count: vote_count,
          vote_percentage: @total_votes.positive? ? (vote_count.to_f / @total_votes * 100).round(2) : 0
        }
      end

      parliamentary_candidates = constituency.candidates.where(candidate_type: 'Parliamentary').map do |candidate|
        vote_count = candidate.votes.sum(:vote_count)
        {
          name: candidate.name,
          image_url: candidate.image.attached? ? url_for(candidate.image) : "https://via.placeholder.com/150",
          candidate_type: candidate.candidate_type,
          vote_count: vote_count,
          vote_percentage: @total_votes.positive? ? (vote_count.to_f / @total_votes * 100).round(2) : 0
        }
      end

      {
        name: constituency.name,
        presidential_candidates: presidential_candidates,
        parliamentary_candidates: parliamentary_candidates
      }
    end
  end
end
