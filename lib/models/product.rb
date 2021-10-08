# frozen_string_literal: true

class Product
  attr_accessor :quantity
  attr_reader :name, :price, :slot

  def initialize(name, price, quantity, slot)
    @name = name
    @price = price
    @quantity = quantity
    @slot = slot
  end
end
