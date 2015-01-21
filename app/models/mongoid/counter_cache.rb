module Mongoid

  module CounterCache
    extend ActiveSupport::Concern

    module ClassMethods
      def counter_cache(opt)
        counter_name = "#{opt[:inverse_of]}_count"

        set_callback(:create, :after) do |document|
          relation = document.send(opt[:name])
          if relation && relation.class.fields.keys.include?(counter_name)
            relation.inc(counter_name.to_sym => 1)
          end
        end

        set_callback(:destroy, :after) do |document|
          relation = document.send(opt[:name])
          if relation && relation.class.fields.keys.include?(counter_name)
            relation.inc(counter_name.to_sym => -1)
          end
        end

      end

    end

  end

end