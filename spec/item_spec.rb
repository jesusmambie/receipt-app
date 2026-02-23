require 'rspec'
require 'bigdecimal'
require_relative '../lib/item'

RSpec.describe Item do
    subject { described_class.new(name, BigDecimal('10.00'), 1) }

    describe '#taxable?' do
        context 'when item is not taxable (is book, food or medical product)' do
            let(:name) { 'book' }

            it 'returns false' do
                expect(subject.taxable?).to be false
            end
        end

        context 'when item is taxable (is not book, food or medical product)' do
            let(:name) { 'music CD' }

            it 'returns true' do
                expect(subject.taxable?).to be true
            end
        end
    end
            
    describe '#imported?' do
        context 'when item is not imported (does not have "imported" prefix)' do
            let(:name) { 'book' }

            it 'returns false' do
                expect(subject.imported?).to be false
            end
        end

        context 'when item is imported (has "imported" prefix)' do
            let(:name) { 'imported book' }

            it 'returns true' do
                expect(subject.imported?).to be true
            end
        end
    end
end
