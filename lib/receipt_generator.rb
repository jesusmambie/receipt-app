require 'bigdecimal'
require_relative 'receipt'
require_relative 'item'

class ReceiptGenerator
    attr_reader :input

    def initialize(input)
        @input = input
    end

    def get_receipt
        items = create_items
        Receipt.new(items).generate
    end

    def create_items
        items = []
        input.each do |line|
            quantity, name, price = input_parser(line)
            items << Item.new(name, price, quantity)
        end
        items
    end

    def input_parser(line)
        item_parts = line.split(" ")

        quantity = item_parts[0].to_i
        name = item_parts[1..-3].join(" ")
        price = BigDecimal(item_parts.last)

        [quantity, name, price]
    end
end
