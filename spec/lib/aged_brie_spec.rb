# frozen_string_literal: true

RSpec.describe Types::AgedBrie do
  let(:item) { |ex| Item.new('Aged Brie', ex.metadata[:sellin] || 5, ex.metadata[:quality] || 10) }
  let(:aged_brie) { described_class.new(item) }

  it_behaves_like 'call is callable'

  describe '#update_quality' do
    it_behaves_like 'update_quality callable' do
      let(:class_name) { aged_brie }
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
