# frozen_string_literal: true

RSpec.describe Types::BackstagePass do
  let(:item) do |ex|
    Item.new('Backstage passes to a TAFKAL80ETC concert',
             ex.metadata[:sellin] || 15, ex.metadata[:quality] || 20)
  end

  let(:backstage_pass) { described_class.new(item) }

  it_behaves_like 'call is callable'

  describe '#update_quality' do
    it_behaves_like 'update_quality callable' do
      let(:class_name) { backstage_pass }
    end

    it 'does not change the item name' do
      expect { backstage_pass.update_quality }.not_to(change(item, :name))
    end

    it 'increases quality by 1 for Backstage passes if sell_in > 10' do
      expect { backstage_pass.update_quality }.to change(item, :quality).by(1)
    end

    it 'increases quality by 2 for Backstage passes if sell_in <= 10 and > 5', sellin: 10 do
      expect { backstage_pass.update_quality }.to change(item, :quality).by(2)
    end

    it 'increases quality by 3 for Backstage passes if sell_in <= 5 and > 0', sellin: 5 do
      expect { backstage_pass.update_quality }.to change(item, :quality).by(3)
    end

    it 'sets quality to 0 for Backstage passes if sell_in <= 0', sellin: -1 do
      expect { backstage_pass.update_quality }.to change(item, :quality).to(0)
    end
  end
end
