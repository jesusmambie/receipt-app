require 'bigdecimal'
require_relative 'round_helper'

module TaxCalculator
    BASIC_TAX_RATE = BigDecimal('0.10')
    IMPORT_DUTY_RATE = BigDecimal('0.05')

    def self.get_tax(item)
        tax = 0
        tax += item.price * BASIC_TAX_RATE if item.taxable?
        tax += item.price * IMPORT_DUTY_RATE if item.imported?
        RoundHelper.round_to_nearest_0_05(tax)
    end
end
