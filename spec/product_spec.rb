require_relative "../app/product.rb"

RSpec.describe Product do
  let(:item_list) { ["2 book at 12.49", "1 music CD at 14.99", "1 cholocate bar at 0.85"] }
  subject(:subject) { described_class.new(item_list) }

  context "#calculate_price" do
    before do
      subject.calculate_price
    end

    it "returns the product item quantity" do
      expect(subject.quantity).not_to be_nil
    end

    it "returns the total tax" do
      expect(subject.total_tax).not_to be_nil
    end


    it "returns total_tax_array as an array" do
      expect(subject.total_tax_array).to be_an_instance_of(Array)
    end

    it "returns the sum_total_product_tax" do
      expected_sum = 1.50
      expect(subject.sum_total_tax_array).to eq(expected_sum)
    end

    it "returns  the sum_total_product_price" do
      expected_sum = 42.32
      expect(subject.sum_total_product_price_array).to eq(expected_sum)
    end

    it "returns the product and their prices" do
      expected_sum = ["2 book: 24.98", "1 music CD: 16.49", "1 cholocate bar: 0.85"]
      expect(subject.display_items).to eq(expected_sum)
    end
  end

  context "#execute" do
    before do
      subject.execute
    end

    it "returns the receipt of the product" do
      expected_sum = ["2 book: 24.98", "1 music CD: 16.49", "1 cholocate bar: 0.85", "Sales Taxes: 1.50", "Total: 42.32"]
      expect(subject.display_items).to eq(expected_sum)
    end
  end
end