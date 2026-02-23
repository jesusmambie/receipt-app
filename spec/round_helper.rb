require 'rspec'
require_relative '../lib/round_helper'

RSpec.describe RoundHelper do
    describe '.round_to_nearest_0_05' do
        subject { described_class.round_to_nearest_0_05(amount) }

        context 'when amount is 1.23' do
            let(:amount) { BigDecimal('1.23') }

            it 'rounds to 1.25' do
                expect(subject).to eq(BigDecimal('1.25'))
            end
        end

        context 'when amount is 1.25' do
            let(:amount) { BigDecimal('1.25') }

            it 'does not change the amount (already rounded)' do
                expect(subject).to eq(BigDecimal('1.25'))
            end
        end
    end
end
