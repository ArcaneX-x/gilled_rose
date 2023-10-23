# frozen_string_literal: true

shared_examples_for 'call is callable' do
  describe '.call' do
    it 'creates an instance and calls update_quality' do
      expect(described_class).to receive(:new).with(item).and_call_original
      expect_any_instance_of(described_class).to receive(:update_quality)

      described_class.call(item)
    end
  end
end
