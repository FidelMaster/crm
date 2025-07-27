class Team < ApplicationRecord
  belongs_to :boss, class_name: 'User'
  has_many :team_memberships
  has_many :members, through: :team_memberships, source: :user
  has_many :tickets
  has_many :service_types
end
