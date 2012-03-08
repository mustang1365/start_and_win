#Used for feedback form(Contact Us in menu).
#Acts as standard ActiveRecord model(gem )
class ContactMessage
  include ActiveAttr::Model

  attribute :subject
  attribute :body
  attribute :user_email

  validates :subject, :body, :presence => true
  validates_format_of :user_email,
                      :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      :if  => Proc.new{|message| message.user_email.present?}  #validate user_email only when user input this email.

end