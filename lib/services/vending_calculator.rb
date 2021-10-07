# frozen_string_literal: true

require_relative '../repositories/coin_stacks_repository'

class VendingCalculator
  def call(change)
    all_coins = coin_stacks_repo.all_coins
    calculate_change_coins(all_coins, change)
  end

  def calculate_change_coins(coins, change)
    return empty_result if change == 0

    coins.each_with_index do |coin, index|
      remainder = change % coin.denomition
      next unless remainder < change

      quantity = [coin.count, ((change - remainder) / coin.denomition)].min
      next unless quantity.positive? # to exclude empty coins from result

      matches = []
      matches << coin_stacks_repo.new_stack(coin.denomition, quantity)

      amount = quantity * coin.denomition
      left_change = change - amount
      return matches if left_change.zero?

      next_calculation = calculate_change_coins(coins[index + 1..-1], left_change)
      if next_calculation
        matches += next_calculation
        return matches
      end
    end
  end

  private

  def coin_stacks_repo
    CoinStacksRepository.new
  end

  def empty_result
    []
  end
end
