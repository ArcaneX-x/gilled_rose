# frozen_string_literal: true

RSpec.describe Types::AgedBrie do
  let(:item) { |ex| Item.new('Aged Brie', ex.metadata[:sellin] || 5, ex.metadata[:quality] || 10) }
  let(:aged_brie) { described_class.new(item) }

  describe '.call' do
    it 'creates an instance and calls update_quality' do
      expect(described_class).to receive(:new).with(item).and_call_original
      expect_any_instance_of(described_class).to receive(:update_quality)

      described_class.call(item)
    end
  end

  describe '#update_quality' do
    it 'calls check_max_quality and decrease_sell_in' do
      allow(aged_brie).to receive(:check_max_quality).with(item)
      allow(aged_brie).to receive(:decrease_sell_in).with(item)

      aged_brie.update_quality

      expect(aged_brie).to have_received(:check_max_quality).with(item).once
      expect(aged_brie).to have_received(:decrease_sell_in).with(item).once
    end

    it 'does not change the item name' do
      expect { aged_brie.update_quality }.not_to(change(item, :name))
    end

    it 'increases quality for Aged Brie' do
      expect { aged_brie.update_quality }.to change(item, :quality).by(1)
    end

    it 'does not increase quality above 50 for Aged Brie', quality: 50 do
      expect { aged_brie.update_quality }.not_to(change(item, :quality))
    end
  end
end
