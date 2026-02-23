require 'bigdecimal'

module RoundHelper
    def self.round_to_nearest_0_05(amount)
        ((amount * 20).ceil) / BigDecimal('20')
    end
end
