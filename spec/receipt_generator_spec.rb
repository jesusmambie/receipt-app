require 'rspec'
require_relative '../lib/receipt_generator'

RSpec.describe ReceiptGenerator do
    subject { described_class.new(input) }

    let(:input) do
        [
            "1 book at 12.49",
            "1 music CD at 14.99",
            "1 chocolate bar at 0.85"
        ]
    end

    describe '#get_receipt' do
        let(:input_one) { ["2 book at 12.49", "1 music CD at 14.99", "1 chocolate bar at 0.85"] }
        let(:input_two) { ["1 imported box of chocolates at 10.00", "1 imported bottle of perfume at 47.50"] }
        let(:input_three) { ["1 imported bottle of perfume at 27.99", "1 bottle of perfume at 18.99", "1 packet of headache pills at 9.75", "3 imported boxes of chocolates at 11.25"] }

        let(:expected_output_one) { "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32\n" }
        let(:expected_output_two) { "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15\n" }
        let(:expected_output_three) { "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38\n" }

        it 'generates a receipt for a list of items', :aggregate_failures do
            expect { described_class.new(input_one).get_receipt }.to output(expected_output_one).to_stdout
            expect { described_class.new(input_two).get_receipt }.to output(expected_output_two).to_stdout
            expect { described_class.new(input_three).get_receipt }.to output(expected_output_three).to_stdout
        end
    end

    describe '#create_items' do
        it 'creates an array of Item objects from input lines', :aggregate_failures do
            items = subject.create_items

            expect(items.length).to eq(3)
            expect(items[0].name).to eq("book")
            expect(items[0].price).to eq(BigDecimal('12.49'))
            expect(items[0].quantity).to eq(1)
        end
    end

    describe '#input_parser' do
        let(:line) { "2 imported box of chocolates at 10.00" }

        it 'parses a string line into quantity, name, and price', :aggregate_failures do
            quantity, name, price = subject.input_parser(line)

            expect(quantity).to eq(2)
            expect(name).to eq("imported box of chocolates")
            expect(price).to eq(BigDecimal('10.00'))
        end
    end
end