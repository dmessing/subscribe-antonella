require 'rails_helper'

RSpec.describe CalculateSalesManager do
  let(:service) { CalculateSalesManager.new }
  let(:input_1) { [ { quantity: 2, name: 'book', price: 12.49 },
                  { quantity: 1, name: 'music CD', price: 14.99 },
                  { quantity: 1, name: 'chocolates bar', price: 0.85 } ]
               }

  let(:input_2) {
    [
      { quantity: 1, name: 'imported box of chocolates', price: 10.00 },
      { quantity: 1, name: 'imported bottle of perfume', price: 47.50 }
    ]
  }

  let(:input_3) {
    [
      { quantity: 1, name: 'imported bottle of perfume', price: 27.99 },
      { quantity: 1, name: 'bottle of perfume', price: 18.99 },
      { quantity: 1, name: 'packet of headache pills', price: 9.75 },
      { quantity: 3, name: 'imported box of chocolates', price: 11.25 }
    ]
  }

  describe 'test input 1' do
    let(:calculated_sales_output) {
    [
      { quantity: 2, name: 'book', price: 12.49, sales_tax: 0, price_with_tax: 24.98 },
      { quantity: 1, name: 'music CD', price: 14.99, sales_tax: 1.5, price_with_tax: 16.49 },
      { quantity: 1, name: 'chocolates bar', price: 0.85, sales_tax: 0, price_with_tax: 0.85 }
    ] }

    context 'calculate sales taxes without imported products' do
      before do
        service.input(input_1)
        service.calculate_sales
        # service.print_receipt
      end

      it 'return print the calculated sales' do
        expect(service.print_receipt).to eq(calculated_sales_output)
      end
    end
  end

  describe 'test input 2' do
    let(:calculated_sales_output) {
    [
      { quantity: 1, name: 'imported box of chocolates', price: 10.0, sales_tax: 0.5, price_with_tax: 10.5 },
      { quantity: 1, name: 'imported bottle of perfume', price: 47.5, sales_tax: 7.13, price_with_tax: 54.63 }
    ] }

    context 'when calculated sales is present' do
      before do
        service.input(input_2)
        service.calculate_sales
        # service.print_receipt
      end

      it 'return print the calculated sales' do
        expect(service.print_receipt).to eq(calculated_sales_output)
      end
    end
  end

  describe 'test input 3' do
    let(:calculated_sales_output) {
    [
      { quantity: 1, name: 'imported bottle of perfume', price: 27.99, sales_tax: 4.2, price_with_tax: 32.19 },
      { quantity: 1, name: 'bottle of perfume', price: 18.99, sales_tax: 1.9, price_with_tax: 20.89 },
      { quantity: 1, name: 'packet of headache pills', price: 9.75, sales_tax: 0, price_with_tax: 9.75 },
      { quantity: 3, name: 'imported box of chocolates', price: 11.25, sales_tax: 1.69, price_with_tax: 35.44 }
    ] }

    context 'when calculated sales is present' do
      before do
        service.input(input_3)
        service.calculate_sales
        # service.print_receipt
      end

      it 'return print the calculated sales' do
        expect(service.print_receipt).to eq(calculated_sales_output)
      end
    end
  end
end
