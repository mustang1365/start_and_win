#encoding: utf-8
class FrontEnd::OtherPagesController < FrontEnd::ApplicationController
  def about_us
  end

  #New feedback message
  def contract_form
    @message = ContactMessage.new
  end

  #Send feedback message
  def send_feedback
    @message = ContactMessage.new(params[:contact_message])
    if @message.valid?
      CommonMailer.send_feedback(@message).deliver
      redirect_to '/', :notice => "Письмо успешно отправлено.
                              #{"Ответ будет выслан на #{@message.user_email}" if @message.user_email? }"
    else
      render :action => :contract_form
    end
  end

  def rules
  end

end
