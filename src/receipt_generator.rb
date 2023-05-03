require_relative './helpers'

class ReceiptGenerator

    attr_accessor :total_amount, :total_taxes

    def initialize
        @helpers = Helpers.new
    end

    def calculate_amounts(item)
        item_price = @helpers.get_price(item)
        item_taxes =  @helpers.calculate_basic_tax(item, item_price) + @helpers.calculate_import_tax(item, item_price)
        item_amount = item.split()[0].to_f
        item_total_taxes = item_amount * item_taxes
        item_total_cost = item_amount * (item_price + item_taxes)
        return {"item_taxes" => item_total_taxes, "item_cost" => item_total_cost}
    end

    def generate_receipt(input_file_path)

        # Read input interactively
        # puts "Enter number of items:"
        # items_num = gets.chomp.to_i

        # for i in 1..items_num do
        #     new_item = gets.chomp
        #     items.push(new_item)
        # end
        
        # Read input from file
        items = IO.readlines(input_file_path)

        @total_taxes = 0
        @total_amount = 0

        items.each do |item|
            item_amounts = calculate_amounts(item)
            @total_taxes += item_amounts['item_taxes']
            @total_amount += item_amounts['item_cost']

            item_desc = @helpers.get_desc(item)
            print "#{item_desc}: #{@helpers.format_amount(item_amounts['item_cost'])}\n"
        end

        print "Sales Taxes: #{@helpers.format_amount(@total_taxes)}\n"
        print "Total: #{@helpers.format_amount(@total_amount)}"
    end
end