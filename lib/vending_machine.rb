# frozen_string_literal: true

require_relative 'repositories/products_repository'
require_relative 'services/vending_calculator'

class VendingMachine
  attr_reader :products

  def initialize
    @products = products_repo.all_products
  end

  def start
    number = 0
    slots = products.map(&:slot)
    number = select_product_input until slots.include?(number)

    product = products.find { |p| p.slot == number.to_i }
    puts "#{product.name} price: #{product.price}"
    amount = 0

    while amount < product.price
      puts "Remainder: #{(product.price - amount).round(2)}"
      amount += coins_input
    end

    puts "Amount: #{amount}"
    get_change(amount, product.price)
    puts 'Enjoi!'
  end

  private

  def get_change(amount, price)
    change = amount - price
    if change > 0
      puts 'Here is your change: '
      puts calculator.call(change)
    end
  end

  def select_product_input
    puts "Please select a product: \n#{available_products_string}"
    puts 'Number:'
    input_number
  end

  def input_number
    gets.to_i
  end

  def coins_input
    puts 'Insert coin and press Enter'
    input_number
  end

  def available_products_string
    products.map do |p|
      "#{p.name}, price: #{p.price}, number: #{p.slot}}"
    end.join(" \n")
  end

  def products_repo
    ProductsRepository.new
  end

  def calculator
    VendingCalculator.new
  end
end
