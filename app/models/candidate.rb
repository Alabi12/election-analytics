class Candidate < ApplicationRecord
  belongs_to :constituency, optional: true
  validates :name, :party, :candidate_type, presence: true
  validates :candidate_type, inclusion: { in: %w[Presidential Parliamentary] }
  has_one_attached :image

  scope :presidential, -> { where(candidate_type: 'Presidential') }
  scope :parliamentary, -> { where(candidate_type: 'Parliamentary') }
end
