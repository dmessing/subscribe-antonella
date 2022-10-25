class CalculateSalesManager
  attr_accessor :sales_item, :calculated_sales
  attr_reader :sales_manager

  def initialize
    @sales_item = []
    @calculated_sales = []
    @sales_manager = SalesManager.new
  end

  def input(sales = [])
    @sales_item = sales
    display_input(sales)
  end

  def calculate_sales
    @calculated_sales = @sales_manager.calculate_sales(@sales_item)
  end

  def print_receipt
    puts '- OUTPUT:'
    @calculated_sales.each do |item|
      puts "#{item[:quantity]} #{item[:name]} #{@sales_manager.price_with_tax(item)}"
    end

    puts "Sales Taxes: #{@sales_manager.total_sales_tax.ceil(2)}"
    puts "Total: #{@sales_manager.total_sales}"

    @calculated_sales
  end

  private

  def display_input(sales)
    puts '-------------------------------------'
    puts '- INPUT'

    sales.each do | item |
      puts "#{item[:quantity]} #{item[:name]} #{item[:price]}"
    end
  end
end
