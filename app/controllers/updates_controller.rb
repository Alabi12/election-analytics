class UpdatesController < ApplicationController
  def live
    @summary = {
      constituencies: constituency_summary,
      candidates: candidate_summary,
      vote_counts: votes_count_summary
    }
  end

  private

  def constituency_summary
    Constituency.all.map do |constituency|
      {
        name: constituency.name,
        total_candidates: constituency.candidates.count,
        total_votes: constituency.total_votes # Assuming 'total_votes' is properly calculated in your model
      }
    end
  end

  def candidate_summary
    Candidate.all.map do |candidate|
      {
        name: candidate.name,
        constituency: candidate.constituency.name,
        vote_count: candidate.votes_count # Correct reference to 'votes_count'
      }
    end
  end

  def votes_count_summary
    # Get the raw query before calling sum
    query = Vote.group(:candidate_id).select(:candidate_id, 'SUM(vote_count) AS total_votes')
    sql = query.to_sql  # This will now work as query is an ActiveRecord relation
    puts "SQL Query: #{sql}" # Debug the query
    
    # Execute the query and map results
    query.map do |result|
      candidate = Candidate.find(result.candidate_id)
      {
        candidate_name: candidate.name,
        total_votes: result.total_votes
      }
    end
  end       
end
