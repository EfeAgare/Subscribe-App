require_relative "../app/tax.rb"

RSpec.describe Tax do
  subject(:subject) { described_class.new }

  context '#import_duty' do
    let(:price) { 20.44 }

    it 'returns the price of 5%' do
      expected_price = price * 0.05
      expect(subject.import_duty(price)).to eq(expected_price)
    end
  end

  context '#sales' do
    let(:price) { 20.44 }

    it 'returns the price of 10%' do
      expected_price = price * 0.1
      expect(subject.sales(price)).to eq(expected_price)
    end
  end

  context '#round_up_tax rounding to the nearest x' do
    let(:price) { 20.44 }

    it 'returns the price to the nearest 0.05' do
      expected_price = (price * 20).ceil / 20.0
      expect(subject.round_up_tax(price)).to eq(expected_price)
    end
  end
end
