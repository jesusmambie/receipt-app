# Receipt Application Code Quality Patterns

## Project Architecture
- **Type**: Pure Ruby CLI, no Gemfile/bundler, only stdlib + RSpec
- **Data flow**: `main.rb` → `ReceiptGenerator#get_receipt` → `Receipt#generate` → `TaxCalculator.get_tax`
- **Input format**: `<quantity> <name> at <price>` (parsed by `ReceiptGenerator#input_parser`)
- **Tax rates**: Basic 10%, Import 5% (independent, additive)
- **Rounding**: Ceiling to 0.05 via `((amount * 20).ceil) / 20`
- **Monetary type**: BigDecimal exclusively

## Known Issues & Conventions

### Critical
- **spec/round_helper.rb** lacks `_spec` suffix → RSpec won't auto-discover it
  - Fix: Rename to `spec/round_helper_spec.rb`

### Test Coverage Gaps
- `TaxCalculator` tests miss rounding edge cases (prices like 10.23 → tax 1.023 → rounds to 1.05)
- `Receipt#generate` only tested for "doesn't raise error", not output accuracy or accumulation
- `ReceiptGenerator#input_parser` has no error handling tests

### Code Quality Notes
- Item exemption checking concatenates `FOODS + MEDICALS + BOOKS` every call; candidate for `EXEMPT_KEYWORDS` constant
- `Receipt#generate` calculates `(item.price + tax) * item.quantity` twice (duplication)
- Method naming mixes `get_*` (non-idiomatic) with predicate `?` convention

## Test Pattern Observations
- Integration tests in `receipt_generator_spec.rb` use real input strings with expected output validation (good)
- Unit tests use `double()` mocking effectively
- RSpec conventions followed: `describe`, `context`, `let`, `:aggregate_failures`
- All 12 current tests pass

## Exemption Keywords
- **Foods**: 'chocolate', 'chocolates'
- **Medical**: 'headache pills'
- **Books**: 'book'
- Checked via word-boundary regex: `\b#{Regexp.escape(keyword)}\b`
- Correctly handles "imported book" (imported doesn't affect exemption logic)
