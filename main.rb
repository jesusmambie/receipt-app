require_relative 'lib/receipt_generator'

input = []
loop do
    line = gets
    break if line.strip.empty?
    input << line
end

ReceiptGenerator.new(input).get_receipt
