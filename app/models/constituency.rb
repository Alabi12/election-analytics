class Constituency < ApplicationRecord
  has_many :parliamentary_candidates, -> { where(candidate_type: 'Parliamentary') }, class_name: 'Candidate'
  
  has_many :candidates, dependent: :destroy
  validates :name, :region, presence: true

  def total_votes
    # Sum votes for all candidates in this constituency
    candidates.sum(:votes_count)
  end
end
