class License < ApplicationRecord
    validates :rider_name, presence: true
    validates :ba_email, presence: true
    validates :rider_license_id, presence: true, uniqueness: true
    validates :sex, presence: true
    validates :rider_birth_date, presence: true
    validates :expiration_date, presence: true

    # default_scope :order => "created_at DESC"
end
