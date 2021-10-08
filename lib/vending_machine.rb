# frozen_string_literal: true

require_relative 'repositories/products_repository'
require_relative 'repositories/coin_stacks_repository'
require_relative 'services/vending_calculator'

class VendingMachine
  attr_reader :products, :all_coins

  def initialize
    @products = products_repo.all_products
    @all_coins = coins_repo.all_coins
  end

  def start
    while products.sum(&:quantity).positive?
      number = 0
      slots = available_products.map(&:slot)
      number = select_product_input until slots.include?(number)

      product = products.find { |p| p.slot == number.to_i }
      process_product(product)
    end
  end

  private

  def process_product(product)
    puts "#{product.name} price: #{product.price}"
    amount = 0

    while amount < product.price
      puts "Remainder: #{(product.price - amount).round(2)}"
      coin_value = coins_input
      if valid_coin_value?(coin_value)
        amount += coin_value
        insert_new_coin(coin_value)
      end
    end

    puts "Amount: #{amount}"

    if amount > coins_value
      puts "Sorry, there is no available change.\nHere is your money back #{amount}"
    else
      get_change(amount, product.price)
      product.quantity -= 1
      puts 'Enjoi!'
    end
  end

  def get_change(amount, price)
    change = amount - price
    return unless change.positive?
    puts 'Here is your change: '
    puts calculator.call(change, all_coins)
  end

  def coins_value
    all_coins.map(&:value).sum
  end

  def select_product_input
    puts "\n"
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

  def insert_new_coin(coin_value)
    coins_repo.increment_coin_stack(coin_value, all_coins)
  end

  def available_products_string
    available_products.map do |p|
      "#{p.name}, price: #{p.price}, quantity: #{p.quantity}, number: #{p.slot}}"
    end.join(" \n")
  end

  def available_products
    products.select { |p| p.quantity.positive? }
  end

  def products_repo
    ProductsRepository.new
  end

  def coins_repo
    CoinStacksRepository.new
  end

  def calculator
    VendingCalculator.new
  end

  def valid_coin_value?(input_value)
    all_coins.map(&:denomition).include?(input_value.to_f.round(2))
  end
end
