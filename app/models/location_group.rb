class LocationGroup < ApplicationRecord
    has_many :locations
    has_many :tickets, through: :locations
    # Additional validations or methods can be added here
    validates :name, presence: true
    validates :description, presence: true

end
