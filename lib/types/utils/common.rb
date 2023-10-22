# frozen_string_literal: true

module Types
  module Utils
    module Common
      MAX_QUALITY = 50

      def check_max_quality(item)
        item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
      end

      def decrease_sell_in(item)
        item.sell_in -= 1
      end
    end
  end
end
