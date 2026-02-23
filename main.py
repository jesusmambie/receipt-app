from lib.receipt_generator import ReceiptGenerator

input_lines = []
while True:
    try:
        line = input()
    except EOFError:
        break
    if not line.strip():
        break
    input_lines.append(line)

ReceiptGenerator(input_lines).get_receipt()
