require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'idとnameを持つこと' do
    category = Category.find(1)
    expect(category.name).to eq('---')
  end

  it 'idとnameを持つこと' do
    prefecture = Prefecture.find(1)
    expect(prefecture.name).to eq('---')
  end

  it 'idとnameを持つこと' do
    sales_status = SalesStatus.find(1)
    expect(sales_status.name).to eq('---')
  end

  it 'idとnameを持つこと' do
    delivery = ScheduledDelivery.find(1)
    expect(delivery.name).to eq('---')
  end

  it 'idとnameを持つこと' do
    fee = ShippingFee.find(1)
    expect(fee.name).to eq('---')
  end
end
