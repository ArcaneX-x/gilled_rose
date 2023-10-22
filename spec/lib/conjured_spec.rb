# frozen_string_literal: true

RSpec.describe Types::Conjured do
  let(:item) { |ex| Item.new('Conjured Mana Cake', ex.metadata[:sellin] || 3, ex.metadata[:quality] || 6) }
  let(:conjured_cake) { described_class.new(item) }

  describe '.call' do
    it 'creates an instance and calls update_quality' do
      expect(described_class).to receive(:new).with(item).and_call_original
      expect_any_instance_of(described_class).to receive(:update_quality)

      described_class.call(item)
    end
  end

  describe '#update_quality' do
    it 'calls check_max_quality and decrease_sell_in' do
      allow(conjured_cake).to receive(:check_max_quality).with(item)
      allow(conjured_cake).to receive(:decrease_sell_in).with(item)

      conjured_cake.update_quality

      expect(conjured_cake).to have_received(:check_max_quality).with(item).once
      expect(conjured_cake).to have_received(:decrease_sell_in).with(item).once
    end

    it 'does not change the item name' do
      expect { conjured_cake.update_quality }.not_to(change(item, :name))
    end

    it 'decreases quality twice as fast for Conjured Mana Cake' do
      expect { conjured_cake.update_quality }.to change(item, :quality).by(-2)
    end

    it 'does not decrease quality below 0 for Conjured Mana Cake', quality: 0 do
      expect { conjured_cake.update_quality }.not_to(change(item, :quality))
    end
  end
end
