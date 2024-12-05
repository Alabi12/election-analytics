class Constituency < ApplicationRecord
  has_many :candidates, dependent: :destroy
  validates :name, :region, presence: true
end
