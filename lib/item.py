import re


class Item:
    FOODS = ['chocolate', 'chocolates']
    MEDICALS = ['headache pills']
    BOOKS = ['book']

    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

    def imported(self):
        return 'imported' in self.name.lower()

    def taxable(self):
        lower_case_name = self.name.lower()
        exempt = self.FOODS + self.MEDICALS + self.BOOKS
        return not any(re.search(r'\b' + re.escape(w) + r'\b', lower_case_name) for w in exempt)
