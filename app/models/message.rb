#Please use send_message and send_site_message to send message around the site
#Rewrite them to improve messaging logic
class Message < ActiveRecord::Base

  USER_MODEL = 'User'
  SITE_SENDER_ID = -1 #uses when sender of message is site administration
  SITE_SENDER_NAME = 'Site administration'

  before_save :build_sender_message #not message send to users, but message copies sends to recipients and sender
  before_save :reformat_sender_and_recipients

  has_many :message_copies, :dependent => :destroy

  attr_accessor :sender_id
  attr_accessor :recipients

  validates :subject, :body, :recipients, :sender_id, :presence => true

  #send message from sender to recipients.
  #You can specify recipients as array of user models or as array of ids
  #You can specify sender as user model or as user id
  #return true if everything is ok
  #examples:
  #sender as id, recipients as models:
  #Message.send_message(1, [User.first, User.last], 'test', 'test body')
  #sender as mode, recipients as ids:
  #Message.send_message(User.first, [1, 12], 'test', 'test body')
  def self.send_message(sender, recipients, subject, body)
    message = Message.new(:subject => subject, :body => body)
    message.sender_id = sender.is_a?(USER_MODEL.constantize) ? sender.id : sender
    if recipients.first.is_a?(USER_MODEL.constantize)
      message.recipients = recipients
    else
      recipients.each do |recipient_id|
        message.recipients << USER_MODEL.constantize.find_by_id(recipient_id)
      end
    end
    message.save
  end

  #send message from site to recipients.
  #examples:
  #send message from administration to all users:
  #Message.send_message([User.all], 'alert!!!', 'test body')
  def self.send_site_message(recipients, subject, body)
    Message.send_message( SITE_SENDER_ID , recipients, subject, body)
  end

  #set recipients by model ids string. For example message.to = '1, 12, 167'
  def to=(value)
    self.recipients.clear
    value.split(",").each do |id|
      id = id.gsub(' ', '')
      self.recipients += [USER_MODEL.constantize.find(id)]
    end
  end

  #return recipients ids as string '1, 12, 167'
  def to
    self.recipients.reject { |r| r == self.sender }.map { |r| r.id }.join(",")
  end

  def real_message_sender_id
    relation = Message.select("messages.*, message_copies.sender_id as real_sender_id").joins(:message_copies).where("message_copies.message_id = #{self.id || SITE_SENDER_ID} and message_copies.sender_id = message_copies.recipient_id")
    relation.count > 0 ? relation.first.try(:real_sender_id).try(:to_i) : nil
  end

  #return id of the sender
  def sender_id
    @sender_id.nil? ? @sender_id = real_message_sender_id : @sender_id
  end

  #return sender model or SITE_SENDER_ID
  def sender
    sender_id.nil? ? nil : sender_id == SITE_SENDER_ID ? SITE_SENDER_ID : USER_MODEL.constantize.find(@sender_id)
  end

  #set sender
  def sender=(model)
    @sender_id = model.id
  end

  #return array of recipients as model
  def recipients
    raise(TypeError, "@recipients: #{@recipients.inspect}") if @recipients.present? && (@recipients.class != Array || !@recipients.compact.all? { |r| r.is_a?(USER_MODEL.constantize) })
    @recipients.nil? ? @recipients = message_copies.map { |mc| mc.recipient } : @recipients
  end

  #return array of recipients as model, except sender(real recipients)
  def real_recipients
    self.recipients.reject { |r| r == self.sender }
  end

  #return sender name
  def sender_full_name
    self.sender_id == SITE_SENDER_ID ? SITE_SENDER_NAME : sender.full_name
  end

  private

  #creates message copy for each recipient
  def reformat_sender_and_recipients
    self.message_copies = []
    self.recipients.each do |model|
      copy = self.message_copies.build(:sender_id => sender_id, :recipient_id => model.id)
    end
  end

  #add sender to recipients of message copy
  def build_sender_message
    self.recipients << self.sender if self.sender && self.sender_id != SITE_SENDER_ID && !self.recipients.include?(self.sender)
  end


end
