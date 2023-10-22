# frozen_string_literal: true

class GildedRose
  attr_reader :items

  ITEM_HANDLERS = {
    'Aged Brie' => Types::AgedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => Types::BackstagePass,
    'Sulfuras, Hand of Ragnaros' => Types::Sulfuras,
    'Conjured Mana Cake' => Types::Conjured
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      handler = ITEM_HANDLERS.fetch(item.name, Types::RegularItem)
      handler.call(item)
    end
  end
end
