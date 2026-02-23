# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Run the application** (reads from stdin; press Enter on a blank line to generate the receipt):
```bash
ruby main.rb
```

**Run all tests:**
```bash
rspec
```

**Run a single spec file:**
```bash
rspec spec/tax_calculator_spec.rb
```

**Install RSpec** (if not already installed — no Gemfile, no bundler):
```bash
gem install rspec
```

## Architecture

This is a pure Ruby CLI app with no dependencies beyond the standard library and RSpec for testing. There is no Gemfile.

**Data flow:** `main.rb` collects stdin lines → `ReceiptGenerator#get_receipt` parses them into `Item` objects → `Receipt#generate` iterates items, calls `TaxCalculator.get_tax` per item, and prints the formatted receipt.

**Key design decisions:**

- **Input parsing** (`ReceiptGenerator#input_parser`): Input lines follow the format `<quantity> <name> at <price>`. The parser splits on spaces, takes index `0` as quantity, `last` as price, and `[1..-3]` (everything between quantity and "at") as the name — so "at" is stripped by excluding the last two tokens.

- **Tax exemption** (`Item#taxable?`): Exemptions are keyword-based using word-boundary regex (`\b`). Only exact keywords trigger exemption: `"chocolate"`, `"chocolates"` (food), `"headache pills"` (medical), `"book"` (books). Anything else defaults to taxable.

- **Tax calculation** (`TaxCalculator`): Basic sales tax is 10%, import duty is 5%. These are independent and additive. Tax is calculated on the per-unit price, then rounded up to the nearest 0.05 via `RoundHelper`.

- **Rounding** (`RoundHelper#round_to_nearest_0_05`): Uses `((amount * 20).ceil) / 20` — always rounds up (ceiling), never down.

- **Precision**: `BigDecimal` is used throughout for all monetary values to avoid floating-point errors.

## Note on spec file naming

`spec/round_helper.rb` is a spec file but is missing the `_spec` suffix. RSpec won't auto-discover it — it must be run explicitly or renamed to `round_helper_spec.rb`.
