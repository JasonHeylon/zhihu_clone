class Notification
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
      hash[:count] = unread.count
      FayeClient.send("/notifications_count/#{self.user.id}", hash)
    end
  end

  def notify_hash
    {}
  end

end