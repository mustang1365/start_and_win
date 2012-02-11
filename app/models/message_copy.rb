class MessageCopy < ActiveRecord::Base
  belongs_to :message

  belongs_to :recipient, :class_name => Message::USER_MODEL, :foreign_key => :recipient_id
  belongs_to :sender, :class_name => Message::USER_MODEL, :foreign_key => :sender_id

  delegate :body, :subject, :recipients, :sender_full_name, :to => :message

  scope :inbox, lambda { |user| where("recipient_id = :user_id AND sender_id != :user_id AND deleted = :deleted",
                                      :user_id => user.id, :deleted => false) }
  scope :sent, lambda { |user| where("recipient_id = :user_id AND sender_id = :user_id AND deleted = :deleted",
                                     :user_id => user.id, :deleted => false) }
  scope :trash, lambda { |user| where("(recipient_id = :user_id AND sender_id != :user_id AND deleted = :deleted) OR
                                     (recipient_id = :user_id AND sender_id = :user_id AND deleted = :deleted)",
                                      :user_id => user.id, :deleted => true) }
  scope :unread, where(:read_at => nil)
  #return array of recipients as model, except sender(real recipients)
  def all_recipients_without_sender
    Message::USER_MODEL.constantize.joins("INNER JOIN message_copies ON #{Message::USER_MODEL.underscore.pluralize}.id = message_copies.recipient_id and message_copies.sender_id != message_copies.recipient_id and message_copies.message_id = #{self.message_id}")
  end

  #return true if message was send by me
  def mine?
    self.recipient == self.sender?
  end

  #return true if message was read
  def read?
    !read_at.nil?
  end

  #mark message as read. Only recipient of message can mark it read
  def mark_as_read(reader)
    if self.read_at.nil? && reader == self.recipient
      self.read_at = Time.now
      self.save!
    end
  end

  #mark message as unread. Only recipient of message can mark it read
  def mark_as_unread(reader)
    if !self.read_at.nil? && reader == self.recipient
      self.read_at = nil
      self.save!
    end
  end

  #mark message as deleted. Only recipient of message can mark it read
  def mark_as_deleted(user)
    if self.sender == user || self.recipient == user
      self.deleted = true
      self.save!
    end
  end
end
