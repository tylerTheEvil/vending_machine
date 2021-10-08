# frozen_string_literal: true

require_relative '../models/coin_stack'

class CoinStacksRepository
  def all_coins
    initialize_coins
  end

  def new_stack(denomition, count)
    CoinStack.new(denomition, count.to_i)
  end

  def increment_coin_stack(denomition, stacks)
    stack = stacks.find { |s| s.denomition == denomition.to_i }
    stack.count += 1
  end

  def remove_coin_from_stacks(new_stack, stacks)
    stack = stacks.find { |s| s.denomition == new_stack.denomition }
    stack.count -= new_stack.count.to_i
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
