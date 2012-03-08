class ResetPasswordMailer < SiteMailer
  default from: SiteMailer::DEFAULT_FROM

  def reset_password_email(user)
    @user = user
    #TODO WTF? Remove localhost!!
    @url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Your password reset request")
  end
end
