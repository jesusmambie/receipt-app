require 'open3'

APP_PATH = File.expand_path('../../main.rb', __FILE__)

RSpec.describe 'receipt application' do
  def run_app(input)
    stdout, _stderr, _status = Open3.capture3('ruby', APP_PATH, stdin_data: input)
    stdout
  end

  context 'with basic taxable and exempt items' do
    it 'applies sales tax only to taxable items' do
      input = "1 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85\n\n"
      expected = "1 book: 12.49\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 29.83\n"
      expect(run_app(input)).to eq(expected)
    end
  end

  context 'with imported items' do
    it 'applies import duty on top of sales tax' do
      input = "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50\n\n"
      expected = "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15\n"
      expect(run_app(input)).to eq(expected)
    end
  end

  context 'with a mix of imported, domestic, taxable, and exempt items' do
    it 'applies the correct combination of taxes per item' do
      input = "1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25\n\n"
      expected = "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38\n"
      expect(run_app(input)).to eq(expected)
    end
  end
end
