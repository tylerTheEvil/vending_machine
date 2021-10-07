# frozen_string_literal: true

require_relative '../models/coin_stack'

class CoinStacksRepository
  def all_coins
    initialize_coins
  end

  def new_stack(denomition, count)
    CoinStack.new(denomition, count)
  end

  private

  def raw_data
    YAML.safe_load(File.read('config/coins.yml'), symbolize_names: true)
  end

  def initialize_coins
    raw_data[:coins].map do |coin|
      new_stack(coin[:denomition], coin[:count])
    end
  end
end
