class Constituency < ApplicationRecord
  has_many :parliamentary_candidates, -> { where(candidate_type: 'Parliamentary') }, class_name: 'Candidate'
  has_many :candidates, dependent: :destroy
  validates :name, :region, presence: true
end
