# frozen_string_literal: true

module Types
  class Conjured
    include Types::Utils::Common

    MIN_QUALITY = 0
    DECREASE_TWICE = 2

    attr_accessor :item

    def initialize(item)
      @item = item
    end

    def self.call(item)
      new(item).update_quality
    end

    def update_quality
      check_max_quality(item)
      decrease_sell_in(item)
      decrease_quality
    end

    private

    def decrease_quality
      return if item.quality == MIN_QUALITY

      item.quality -= DECREASE_TWICE
    end
  end
end
