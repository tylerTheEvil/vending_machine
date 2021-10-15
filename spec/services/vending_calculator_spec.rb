# frozen_string_literal: true

require 'spec_helper'
require 'vending_machine'

describe VendingCalculator do
  subject { described_class.new }

  describe 'calculate_change_coins' do
    context 'with full stack of coins' do
      let(:coins) do
        [
          CoinStack.new(10, 100),
          CoinStack.new(5, 100),
          CoinStack.new(2, 100),
          CoinStack.new(1, 100)
        ]
      end

      it 'returns 2 coins 10 and 5 as change of 15' do
        result = subject.calculate_change_coins(coins, 15)
        expect(result.count).to eq(2)
        expect(result[0].denomition).to eq(10)
        expect(result[0].count).to eq(1)
        expect(result[1].denomition).to eq(5)
        expect(result[1].count).to eq(1)
      end

      it 'returns 1 coins 1 as change of 1' do
        result = subject.calculate_change_coins(coins, 1)
        expect(result.count).to eq(1)
        expect(result[0].denomition).to eq(1)
        expect(result[0].count).to eq(1)
      end
    end

    context 'with not full stack of coins' do
      let(:coins) do
        [
          CoinStack.new(10, 1),
          CoinStack.new(5, 1),
          CoinStack.new(2, 100),
          CoinStack.new(1, 100)
        ]
      end

      it 'returns 2 coins 10 and 5 as change of 20' do
        result = subject.calculate_change_coins(coins, 20)

        expect(result.count).to eq(4)
        expect(result.map(&:denomition)).to match_array([10, 5, 2, 1])
        expect(result.map(&:count)).to match_array([1, 1, 2, 1])
      end
    end

    context 'with a stack of only 1s' do
      let(:coins) do
        [
          CoinStack.new(10, 0),
          CoinStack.new(5, 0),
          CoinStack.new(2, 0),
          CoinStack.new(1, 100)
        ]
      end

      it 'returns 2 coins 10 and 5 as change of 20' do
        result = subject.calculate_change_coins(coins, 20)

        expect(result.count).to eq(1)
        expect(result.map(&:denomition).uniq).to match_array([1])
        expect(result.map(&:count)).to eq([20])
      end
    end

    context 'with small amount of different coins' do
      let(:coins) do
        [
          CoinStack.new(50, 1),
          CoinStack.new(20, 2),
          CoinStack.new(15, 1),
          CoinStack.new(10, 1),
          CoinStack.new(1, 8)
        ]
      end

      it 'returns 2 coins 10 and 5 as change of 98' do
        result = subject.calculate_change_coins(coins, 98)

        expect(result.count).to eq(3)
        expect(result.map(&:denomition)).to match_array([50, 20, 1])
        expect(result.map(&:count)).to eq([1, 2, 8])
      end
    end

    context 'no change needed' do
      let(:coins) do
        [
          CoinStack.new(5.0, 5),
          CoinStack.new(3.0, 5),
          CoinStack.new(2.0, 5),
          CoinStack.new(1.0, 5),
          CoinStack.new(0.5, 5),
          CoinStack.new(0.25, 5)
        ]
      end

      it 'returns empty result' do
        result = subject.calculate_change_coins(coins, 0)

        expect(result.count).to eq(0)
      end
    end

    context 'correct amount of coins' do
      context 'change 9 with all coins available' do
        let(:coins) do
          [
            CoinStack.new(5.0, 5),
            CoinStack.new(3.0, 5),
            CoinStack.new(2.0, 5),
            CoinStack.new(1.0, 5),
            CoinStack.new(0.5, 5),
            CoinStack.new(0.25, 5)
          ]
        end

        it 'returns 3 coins' do
          result = subject.calculate_change_coins(coins, 9)
          expect(result.count).to eq(3)
        end

        it 'returns 5, 3, 1 coins' do
          result = subject.calculate_change_coins(coins, 9)
          expect(result.map(&:denomition)).to match_array([5, 3, 1])
        end
      end
    end
  end
end
