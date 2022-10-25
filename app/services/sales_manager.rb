class SalesManager
  attr_accessor :calculated_sales_item, :tax_manager

  def initialize
    @calculated_sales_item = []
    @tax_manager = TaxManager.new
  end

  def calculate_sales(item = [])
    @calculated_sales_item.push(@tax_manager.calculate_product_tax(item)).flatten!
    @calculated_sales_item
  end

  def total_sales_tax
    @calculated_sales_item.map { |product| product[:sales_tax] }.inject(:+)
  end

  def total_sales
    @calculated_sales_item.map { |product| product[:price_with_tax] }.inject(:+)
  end

  def price_with_tax(price)
    @tax_manager.price_with_tax(price)
  end
end
