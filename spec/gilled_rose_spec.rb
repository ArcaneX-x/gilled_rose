# frozen_string_literal: true

RSpec.describe GildedRose do
  let(:item) { |ex| Item.new(ex.metadata[:name] || 'Normal Item', 3, 5) }
  let(:gilded_rose) { described_class.new([item]) }

  describe '#update_quality' do
    it 'handles Regular Item using the correct handler' do
      expect(Types::RegularItem).to receive(:call).with(item)

      gilded_rose.update_quality
    end

    it 'handles item is not a regular', name: 'Aged Brie' do
      expect(Types::AgedBrie).to receive(:call).with(item)

      gilded_rose.update_quality
    end
  end
end
