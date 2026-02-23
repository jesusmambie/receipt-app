from decimal import Decimal

from lib.item import Item
from lib.receipt import Receipt


class ReceiptGenerator:
    def __init__(self, input_lines):
        self.input = input_lines

    def get_receipt(self):
        items = self.create_items()
        Receipt(items).generate()

    def create_items(self):
        items = []
        for line in self.input:
            quantity, name, price = self.input_parser(line)
            items.append(Item(name, price, quantity))
        return items

    def input_parser(self, line):
        item_parts = line.split()
        quantity = int(item_parts[0])
        name = ' '.join(item_parts[1:-2])
        price = Decimal(item_parts[-1])
        return quantity, name, price
