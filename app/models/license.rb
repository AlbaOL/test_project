class License < ApplicationRecord
    validates :rider_name, presence: true
    validates :ba_email, presence: true
    validates :rider_license_id, presence: true, uniqueness: true
    validates :sex, presence: true
    validates :rider_birth_date, presence: true
    validates :expiration_date, presence: true

    enum status: {recived: 0, reviewed: 1, certified: 2, rejected: 3}

    # default_scope :order => "created_at DESC"

    def nightly_activity_report(send_to, requester, license)
        @receiver = requester
        @activity = calculate_daily_activity
        mail(to: send_to, subject: "Bikes Anonymous Daily Report")
    end

    def self.calculate_daily_activity
        return '#Licenses received: ' + " #{received.count}" + ' #Licenses certified: '+ " #{certified.count}" + ' #Licenses rejected: ' + " #{rejected.count}"
    end

    def self.received
        where(status: 0)
    end

    def self.reviewed
        where(status: 1)
    end

    def self.certified
        where(status: 2)
    end

    def self.rejected
        where(status: 3)
    end
end
