require 'rspec'
require_relative '../lib/tax_calculator'

RSpec.describe TaxCalculator do
    describe '.get_tax' do
        subject { described_class.get_tax(item) }

        let(:item) { double('Item', price: BigDecimal('100.00'), taxable?: taxable, imported?: imported) }

        context 'when item is taxable and imported' do
            let(:taxable) { true }
            let(:imported) { true }

            it 'calculates tax correctly' do
                expect(subject).to eq(BigDecimal('15.00')) # 10% + 5% of 100.00
            end
        end

        context 'when item is not taxable and not imported' do
            let(:taxable) { false }
            let(:imported) { false }

            it 'calculates tax as zero' do
                expect(subject).to eq(BigDecimal('0'))
            end
        end

        context 'when item is taxable but not imported' do
            let(:taxable) { true }
            let(:imported) { false }

            it 'calculates tax correctly' do
                expect(subject).to eq(BigDecimal('10.00')) # 10% of 100.00
            end
        end

        context 'when item is imported but not taxable' do
            let(:taxable) { false }
            let(:imported) { true }

            it 'calculates tax correctly' do
                expect(subject).to eq(BigDecimal('5.00')) # 5% of 100.00
            end
        end
    end
end
