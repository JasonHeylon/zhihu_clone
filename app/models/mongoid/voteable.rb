module Mongoid
  module Voteable
    extend ActiveSupport::Concern

    included do
      field :up_voted_user_ids, type: Array, default: []
      field :up_voted_count, type: Integer, default: 0
      field :down_voted_user_ids, type: Array, default: []
      field :down_voted_count, type: Integer, default: 0

      scope :high_up_voted_list, -> { desc(:up_voted_count) }
      scope :high_down_voted_list, -> { asc(:down_voted_count) }
    end



    def up_vote_by(user)
      return false if voted_by?(user)
      self.push(up_voted_user_ids: user.id)
      self.inc(up_voted_count: 1)
      self.save
    end
    def undo_up_vote_by(user)
      return false unless voted_by?(user, "up")
      self.pull(up_voted_user_ids: user.id)
      self.inc(up_voted_count: -1)
      # self.save
    end

    def down_vote_by(user)
      return false if voted_by?(user)
      self.push(down_voted_user_ids: user.id)
      self.inc(down_voted_count: 1)
      # self.save
    end
    def undo_down_vote_by(user)
      return false unless voted_by?(user, "down")
      self.pull(down_voted_user_ids: user.id)
      self.inc(down_voted_count: -1)
      # self.save
    end

    def voted_by?(user, opt = nil)
      return flase if user.blank?
      case opt
      when "up"
        up_voted_user_ids.include?(user.id)
      when "down"
        down_voted_user_ids.include?(user.id)
      else
        up_voted_user_ids.include?(user.id) || down_voted_user_ids.include?(user.id)
      end
    end




  end
end