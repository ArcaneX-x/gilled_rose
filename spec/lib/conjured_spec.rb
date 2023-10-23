# frozen_string_literal: true

RSpec.describe Types::Conjured do
  let(:item) { |ex| Item.new('Conjured Mana Cake', ex.metadata[:sellin] || 3, ex.metadata[:quality] || 6) }
  let(:conjured_cake) { described_class.new(item) }

  it_behaves_like 'call is callable'

  describe '#update_quality' do
    it_behaves_like 'update_quality callable' do
      let(:class_name) { conjured_cake }
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
