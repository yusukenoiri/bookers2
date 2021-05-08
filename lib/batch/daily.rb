class Batch::Daily
  def mail
    DailyMailer.daily_mail.deliver_now
  end
end
  #   users = User.all
  #   users.each do |user|
  #   mail(to: user.email, subject: 'Daily email notification')

  # end

  # def daily_mail(user)
  #   require "date"
  #   @time_now = DateTime.now
  #   @user = user
  #   mail to: @user.email, subject: 'Daily Mail'
  # end

  # def self.send_daily_mail_users
  #   users = User.all
  #   users.each do |user|
  #     DailyMailer.daily_mail(user).deliver_now
  #   end
  #   p "登録者全員にメールを送る"
  # end