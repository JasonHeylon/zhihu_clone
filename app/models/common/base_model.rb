module Common
  module BaseModel
    extend ActiveSupport::Concern
    include Mongoid::Timestamps

    included do
      scope :recent, -> { desc(:_id) }
      scope :exclude_ids, ->(ids) { where(:_id.nin => ids.map(&:to_i)) }
    end

  end
end
