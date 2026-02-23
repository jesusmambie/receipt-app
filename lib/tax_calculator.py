from decimal import Decimal

from lib.round_helper import round_to_nearest_005

BASIC_TAX_RATE = Decimal('0.10')
IMPORT_DUTY_RATE = Decimal('0.05')


def get_tax(item):
    tax = Decimal('0')
    if item.taxable():
        tax += item.price * BASIC_TAX_RATE
    if item.imported():
        tax += item.price * IMPORT_DUTY_RATE
    return round_to_nearest_005(tax)
