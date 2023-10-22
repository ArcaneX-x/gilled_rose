# frozen_string_literal: true

RSpec.describe Types::Sulfuras do
  let(:item) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }

  describe '.call' do
    it 'does not modify the item' do
      expect { described_class.call(item) }.not_to(change { item })
    end
  end
end
