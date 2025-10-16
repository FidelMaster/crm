class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { client: 0, agent: 1, admin: 2 }

  has_many :team_memberships
  has_many :teams, through: :team_memberships

  # Devuelve el nombre completo para la API
  def full_name
    self.name || self.email
  end
end
