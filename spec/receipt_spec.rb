require 'rspec'
require_relative '../lib/receipt'

RSpec.describe Receipt do
    subject { described_class.new(input) }

    let(:input) do
        [
            double('Item', name: 'book', price: BigDecimal('12.49'), quantity: 1, total_price: BigDecimal('12.49'), taxable?: false, imported?: false),
            double('Item', name: 'music CD', price: BigDecimal('14.99'), quantity: 1, total_price: BigDecimal('16.49'), taxable?: true, imported?: false),
            double('Item', name: 'chocolate bar', price: BigDecimal('0.85'), quantity: 1, total_price: BigDecimal('0.85'), taxable?: false, imported?: false)
        ]
    end

    describe '#generate' do
        it 'generates receipt without errors' do
            expect { subject.generate }.not_to raise_error
        end
    end
end
