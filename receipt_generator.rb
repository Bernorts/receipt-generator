class ReceiptGenerator

    attr_accessor :total_amount, :total_taxes

    def get_price(item)
        delimiter = "at"
        item.split(/\b#{delimiter}\b/)[-1].to_f
    end

    def calculate_tax(price, rate)
        precision = 0.05
        ((price * rate) / precision).ceil * precision
    end

    def format_amount(amount)
        format('%.2f', amount)
    end

    def calculate_basic_tax(item, price)
        exempt_products = ['book', 'chocolate', 'pills']

        is_exempt = exempt_products.any? do |exempt_product|
            item.include?(exempt_product)
        end

        basic_rate = 0.1
        basic_tax = 0
    
        unless is_exempt
            basic_tax = calculate_tax(price, basic_rate)
            
        end

        basic_tax
    end

    def calculate_import_tax(item, price)
        import_rate = 0.05
        import_tax = 0
    
        if item.include?("imported")
            import_tax = calculate_tax(price, import_rate)
        end

        import_tax
    end

    def generate_receipt(input_file_path)

        # Read input interactively
        # puts "Enter amount of items:"
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
            item_price = get_price(item)
            item_taxes = 0
            item_total_taxes = 0
            item_taxes += calculate_basic_tax(item, item_price)
            item_taxes += calculate_import_tax(item, item_price)
            item_amount = item.split()[0].to_f
            item_total_taxes = item_amount * item_taxes
            @total_taxes += item_total_taxes
            item_total_cost = item_amount * (item_price + item_taxes)
            @total_amount += item_total_cost
            delimiter = "at"
            item_desc = "#{item.split(/\b#{delimiter}\b/)[0]}".rstrip
            print "#{item_desc}: #{format_amount(item_total_cost)}\n"
        end

        print "Sales Taxes: #{format_amount(@total_taxes)}\n"
        print "Total: #{format_amount(@total_amount)}"
    end
end