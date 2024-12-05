class Vote < ApplicationRecord
  belongs_to :candidate
  validates :vote_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
