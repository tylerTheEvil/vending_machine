# frozen_string_literal: true

require 'yaml'
require_relative '../models/product'

class ProductsRepository
  def all_products
    initialize_products
  end

  private

  def initialize_products
    raw_data[:products].map do |p|
      Product.new(p[:name], p[:price], p[:slot])
    end
  end

  def raw_data
    YAML.safe_load(File.read('config/products.yml'), symbolize_names: true)
  end
end
