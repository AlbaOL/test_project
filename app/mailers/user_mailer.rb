class UserMailer < ApplicationMailer
    default from: "aortegalorenzo@gmail.com"
    layout 'mailer'

    def nightly_activity_report(send_to)
        @activity = License.calculate_daily_activity
        mail(to: send_to, body: @activity, subject: "Bikes Anonymous Daily Report").deliver
    end
end
