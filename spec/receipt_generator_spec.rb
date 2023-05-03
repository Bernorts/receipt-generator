require_relative '../src/receipt_generator' 

describe ReceiptGenerator do
    context "For Input 1" do 

        it "should generate a receipt with correct amounts, taxes, and total" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/case_1/input_1.txt"
            output_file_path = "test_cases/case_1/output_1.txt"
            output_contents = File.read(output_file_path)
            expect { rg.generate_receipt input_file_path }.to output(output_contents).to_stdout
        end
        
    end 

    context "For Input 2" do 

        it "should generate a receipt with correct amounts, taxes, and total" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/case_2/input_2.txt"
            output_file_path = "test_cases/case_2/output_2.txt"
            output_contents = File.read(output_file_path)
            expect { rg.generate_receipt input_file_path }.to output(output_contents).to_stdout
        end
        
    end 

    context "For Input 3" do 

        it "should generate a receipt with correct amounts, taxes, and total" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/case_3/input_3.txt"
            output_file_path = "test_cases/case_3/output_3.txt"
            output_contents = File.read(output_file_path)
            expect { rg.generate_receipt input_file_path }.to output(output_contents).to_stdout
        end
        
    end 

    context "For exempt items" do 

        it "should not generate any basic taxes" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/general/exempt_items.txt"
            rg.generate_receipt input_file_path
            expect(rg.total_taxes).to eq 0.00
        end
        
    end 

    context "For non-exempt items" do 

        it "should generate basic taxes" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/general/non_exempt_items.txt"
            rg.generate_receipt input_file_path
            expect(rg.total_taxes).to be > 0.00
        end
        
    end 

    context "For imported items" do 

        it "should generate import taxes" do
            rg = ReceiptGenerator.new
            input_file_path = "test_cases/general/import_items.txt"
            rg.generate_receipt input_file_path
            expect(rg.total_taxes).to be > 0.00
        end
        
    end 
end