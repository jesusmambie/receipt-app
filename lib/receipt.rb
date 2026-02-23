require 'bigdecimal'
require_relative 'tax_calculator'

class Receipt
    attr_reader :items, :total_sales_tax, :total_amount

    def initialize(items)
        @items = items
        @total_sales_tax = BigDecimal('0')
        @total_amount = BigDecimal('0')
    end

    def generate
        items.each do |item|
            tax = TaxCalculator.get_tax(item)
            total_price = format('%.2f', (item.price + tax) * item.quantity)

            puts "#{item.quantity} #{item.name}: #{total_price}"

            @total_sales_tax += tax * item.quantity
            @total_amount += (item.price + tax) * item.quantity
        end
        puts "Sales Taxes: #{format('%.2f', total_sales_tax)}"
        puts "Total: #{format('%.2f', total_amount)}"
    end
end
