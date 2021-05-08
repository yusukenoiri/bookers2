class NotificationMailer < ApplicationMailer
  default from: 'no-replay@gmail.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'welcome to my family!')
    # mailメソッドで件名と宛先を指定, mail(to: 宛先, subject: '件名')
  end
end