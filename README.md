# Sales Tax Calculator

This is a pure Ruby application that generates a receipt with sales tax and totals for a shopping list. It calculates basic sales tax (10%) and import duties (5%) based on specific item rules.

## Project Structure

The code is organized to follow Object-Oriented principles and separate concerns:

* `main.rb`: The entry point to run the application.
* `lib/`: Contains the application logic.
    * `item.rb`: Represents a product (Data).
    * `tax_calculator.rb`: Service that handles tax logic and rates.
    * `round_helper.rb`: Utility for specific financial rounding (nearest 0.05).
    * `receipt.rb`: Handles the transaction state and output formatting.
    * `receipt_generator.rb`: Manages input reading and orchestrates the flow.
* `spec/`: Contains the RSpec tests.

## Requirements

* **Ruby**: Ensure you have a recent version of Ruby installed.
* **RSpec**: Used for testing.

## Setup

1.  Open your terminal and navigate to the project folder.
2.  Install the testing gem (if you haven't already):
    ```bash
    gem install rspec
    ```

## How to Run

1.  Run the application using Ruby:
    ```bash
    ruby main.rb
    ```

2.  **Enter your input:** Paste the shopping list data into the terminal.
3.  **Finish input:** Press **Enter** on an empty line to generate the receipt.

**Example Input:**
```text
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

## Product Categorization (Simplification)

Due to the absence of a product database or external catalog service, item categorization is strictly limited to the keywords provided in the challenge's sample data.
* **Food:** Only items containing "chocolate" or "chocolates" are treated as food.
* **Medical:** Only items containing "headache pills" are treated as medical products.
* **Books:** Only items containing "book" are treated as books.

Any other item (e.g., "sandwich" or "aspirin") would default to the standard tax rate.
