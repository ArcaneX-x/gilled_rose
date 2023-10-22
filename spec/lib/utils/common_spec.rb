# frozen_string_literal: true

RSpec.describe Types::Utils::Common do
  let(:dummy) { Class.new { include Types::Utils::Common }.new }
  let(:item) { |ex| Item.new('Regular item', 2, ex.metadata[:quality] || 30) }

  describe '#check_max_quality' do
    it 'sets quality to 50 if initial quality is higher', quality: 60 do
      expect(dummy.check_max_quality(item)).to eq 50
    end

    it 'does not change quality if it is already within the limit' do
      expect { dummy.check_max_quality(item) }.not_to change(item, :quality)
    end
  end

  describe '#decrease_sell_in' do
    it 'decreases sell_in by 1' do
      expect { dummy.decrease_sell_in(item) }.to change(item, :sell_in).by(-1)
    end
  end
end
