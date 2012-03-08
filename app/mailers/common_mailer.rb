class CommonMailer < SiteMailer

  def send_feedback(message)
    @message = message
    mail(:to => FEEDBACK_EMAIL,
         :subject => "New feedback from site: #{@message.subject}"
    )
  end
end
