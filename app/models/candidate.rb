class Candidate < ApplicationRecord
  belongs_to :constituency, optional: true
  validates :name, :party, :candidate_type, presence: true
  validates :candidate_type, inclusion: { in: %w[Presidential Parliamentary] }
  has_one_attached :image
  has_many :votes

  scope :presidential, -> { where(candidate_type: 'Presidential') }
  scope :parliamentary, -> { where(candidate_type: 'Parliamentary') }
  validates :votes_count, numericality: { only_integer: true, allow_nil: true }
end
