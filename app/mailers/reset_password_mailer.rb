class ResetPasswordMailer < ActionMailer::Base
  default from: "from@example.com"

  def reset_password_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Your password reset request")
  end
end
