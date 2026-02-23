from decimal import Decimal

from lib.tax_calculator import get_tax


class Receipt:
    def __init__(self, items):
        self.items = items
        self.total_sales_tax = Decimal('0')
        self.total_amount = Decimal('0')

    def generate(self):
        for item in self.items:
            tax = get_tax(item)
            total_price = f"{(item.price + tax) * item.quantity:.2f}"
            print(f"{item.quantity} {item.name}: {total_price}")
            self.total_sales_tax += tax * item.quantity
            self.total_amount += (item.price + tax) * item.quantity
        print(f"Sales Taxes: {self.total_sales_tax:.2f}")
        print(f"Total: {self.total_amount:.2f}")
