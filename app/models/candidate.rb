class Candidate < ApplicationRecord
  belongs_to :constituency
  validates :name, :party, presence: true
end
