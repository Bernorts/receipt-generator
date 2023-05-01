# Receipt Generator

## Automation tests

Run the tests with: `rspec spec`

## Test custom cases

1. Create a file inside the `test_cases` directory with the input you want to test
2. Run the receipt generator with the following command: `ruby -r "./receipt_generator.rb" -e "ReceiptGenerator.new.generate_receipt 'test_cases/[input_file]'"`
