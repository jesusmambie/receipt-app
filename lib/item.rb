class Item
    attr_reader :name, :price, :quantity

    FOODS = ['chocolate', 'chocolates']
    MEDICALS = ['headache pills']
    BOOKS = ['book']

    def initialize(name, price, quantity)
        @name = name
        @price = price
        @quantity = quantity
    end

    def imported?
        name.downcase.include?("imported")
    end

    def taxable?
        lower_case_name = name.downcase
        exempt = FOODS + MEDICALS + BOOKS
        !exempt.any? { |w| lower_case_name.match?("\\b#{Regexp.escape(w)}\\b") }
    end
end
