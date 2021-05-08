# namespace :daily_mail do
#   desc "登録者全員にメールを送る"
#   task send_mail: :environment do
#     DailyMailer.send_daily_mail_users
#   end
# end

namespace :daily_mail do
  desc "登録者全員にメールを送る"
  task send_mail: :environment do
    logger = Logger.new 'log/daily_mail.log'

    User.find_each do |user|
      begin
        DailyMailer.daily_mail(user).deliver_now

      rescue => e
        logger.error "user_id: #{user.id}でエラーが発生"
        logger.error e
        logger.error e.backtrace.join("\n")
        next
      end
    end
  end
end