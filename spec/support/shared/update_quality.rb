# frozen_string_literal: true

shared_examples_for 'update_quality callable' do
  it 'calls check_max_quality and decrease_sell_in' do
    allow(class_name).to receive(:check_max_quality).with(item)
    allow(class_name).to receive(:decrease_sell_in).with(item)

    class_name.update_quality

    expect(class_name).to have_received(:check_max_quality).with(item).once
    expect(class_name).to have_received(:decrease_sell_in).with(item).once
  end
end
