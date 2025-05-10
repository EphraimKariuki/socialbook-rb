class UserMailer < ApplicationMailer
  default from: "ephraimkabuikariuki@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "http://socialbook.com/login"
    mail(to: @user.email, subject: "Welcome to SocialBook!")
  end
end
