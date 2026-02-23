import math
from decimal import Decimal

def round_to_nearest_005(amount):
    return Decimal(math.ceil(amount * 20)) / Decimal('20')
