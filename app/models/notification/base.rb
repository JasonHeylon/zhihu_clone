class Notification::Base
  include Mongoid::Document
  include Common::BaseModel

  store_in collection: "notifications"


  field :has_read, type: Boolean, default: false

  index user_id: 1
  index user_id: 1, has_read: 1

  belongs_to :user, inverse_of: :notifications
  belongs_to :answer

  scope :unread, -> { where(has_read: false) }


  after_create :push_to_client

  def push_to_client
    if self.user
      hash = self.notify_hash
      hash[:count] = self.user.notifications.unread.count
      FayeClient.send("/notifications_count/#{self.user.id}", hash)
    end
  end

  def notify_hash
    {}
  end

  def content_path
    ''
  end

  def read
    this.update(has_read: true)
  end

end
