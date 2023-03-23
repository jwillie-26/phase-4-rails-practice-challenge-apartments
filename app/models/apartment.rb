class Apartment < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :tenants, through: :leases

    validates :number, presence: true
    validates :number, numericality: {greater_than_or_equal_to:1}
end