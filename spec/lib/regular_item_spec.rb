# frozen_string_literal: true

RSpec.describe Types::RegularItem do
  let(:item) { |ex| Item.new('Regular Item', ex.metadata[:sellin] || 5, ex.metadata[:quality] || 10) }
  let(:regular_item) { described_class.new(item) }

  it_behaves_like 'call is callable'

  describe '#update_quality' do
    it_behaves_like 'update_quality callable' do
      let(:class_name) { regular_item }
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
