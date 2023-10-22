# frozen_string_literal: true

module Types
  class BackstagePass
    include Types::Utils::Common

    MAX_QUALITY = 50
    DAYS_TO_DOUBLE_QUALITY = 10
    DAYS_TO_TRIPLE_QUALITY = 5
    INCREASE_ONCE = 1

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
      increase_quality
      handle_special_cases
    end

    private

    def increase_quality
      item.quality += INCREASE_ONCE if item.quality < MAX_QUALITY
    end

    def handle_special_cases
      increase_quality if item.sell_in < DAYS_TO_DOUBLE_QUALITY
      increase_quality if item.sell_in < DAYS_TO_TRIPLE_QUALITY
      item.quality = 0 if item.sell_in.negative?
    end
  end
end
