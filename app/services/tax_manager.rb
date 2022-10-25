class TaxManager
  EXEMPTION_TAGS = %w[book food chocolates medicine pills].freeze
  BASIC_SALES_TAX = 0.10
  IMPORTED_GOOD_TAX = 0.05

  attr_accessor :calculated_product, :item_name

  def initialize
    @calculated_product = []
  end

  def calculate_product_tax(products = [])
    products.each do |product|
      product.merge!(calculate_basic_tax(product))

      @calculated_product.push(product)
    end

    @calculated_product
  end

  def exept_product?(product)
    !(EXEMPTION_TAGS & product.split).empty?
  end

  def imported_tax?(product)
    product.downcase.split.include?('imported')
  end

  def price_with_tax(product)
    ((product[:price] * product[:quantity]) + sales_taxes(product) + imported_taxes(product)).ceil(2)
  end

  private

  def calculate_basic_tax(product)
    calc_sales_tax = sales_taxes(product)

    calc_imported_tax = imported_taxes(product)

    price_with_tax = (product[:price] * product[:quantity]) + calc_sales_tax + calc_imported_tax

    total_taxes = calc_sales_tax + calc_imported_tax

    { sales_tax: total_taxes.ceil(2), price_with_tax: price_with_tax.ceil(2) }
  end

  def sales_taxes(product)
    exept_product?(product[:name]) ? 0 : (product[:price] * product[:quantity]) * BASIC_SALES_TAX
  end

  def imported_taxes(product)
    imported_tax?(product[:name]) ? (product[:price] * product[:quantity]) * IMPORTED_GOOD_TAX : 0
  end
end
