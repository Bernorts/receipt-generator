class Helpers

    def initialize
        @DESC_DELIMITER="at"
    end

    def get_desc(item)
        item.split(/\b#{@DESC_DELIMITER}\b/)[0].rstrip
    end

    def get_price(item)
        item.split(/\b#{@DESC_DELIMITER}\b/)[-1].to_f
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
end