# frozen_string_literal: true

class Product
  attr_reader :name, :price, :slot

  def initialize(name, price, slot)
    @name = name
    @price = price
    @slot = slot
  end
end
