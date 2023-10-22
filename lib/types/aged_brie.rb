# frozen_string_literal: true

module Types
  class AgedBrie
    include Types::Utils::Common

    attr_accessor :item

    MAX_QUALITY = 50
    INCREASE_ONCE = 1

    def initialize(item)
      @item = item
    end

    def self.call(item)
      new(item).update_quality
    end

    def update_quality
      check_max_quality(item)
      decrease_sell_in(item)
      increase_quality
    end

    private

    def increase_quality
      item.quality += INCREASE_ONCE if item.quality < MAX_QUALITY
    end
  end
end
