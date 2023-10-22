# frozen_string_literal: true

RSpec.describe Types::RegularItem do
  let(:item) { |ex| Item.new('Regular Item', ex.metadata[:sellin] || 5, ex.metadata[:quality] || 10) }
  let(:regular_item) { described_class.new(item) }

  describe '.call' do
    it 'creates an instance and calls update_quality' do
      expect(described_class).to receive(:new).with(item).and_call_original
      expect_any_instance_of(described_class).to receive(:update_quality)

      described_class.call(item)
    end
  end

  describe '#update_quality' do
    it 'calls check_max_quality and decrease_sell_in' do
      allow(regular_item).to receive(:check_max_quality).with(item)
      allow(regular_item).to receive(:decrease_sell_in).with(item)

      regular_item.update_quality

      expect(regular_item).to have_received(:check_max_quality).with(item).once
      expect(regular_item).to have_received(:decrease_sell_in).with(item).once
    end

    it 'does not change the item name' do
      expect { regular_item.update_quality }.not_to(change(item, :name))
    end

    it 'does not decrease quality below MIN_QUALITY', quality: 0 do
      expect { regular_item.update_quality }.not_to(change(item, :quality))
    end

    it 'double decrease quality if sellin negative', sellin: -1 do
      expect { regular_item.update_quality }.to change(item, :quality).by(-2)
    end
  end
end
