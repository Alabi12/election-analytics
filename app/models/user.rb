class User < ApplicationRecord
  # Other Devise modules can be included
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  ROLES = %w[admin agent user].freeze

  def party_agent?
    role == 'party_agent'
  end

  # Define the role? method to check if a user has a specific role
  def admin?
    role == 'admin'
  end

  # Class method to return all possible roles for the select input
  def self.roles
    ROLES
  end
end

