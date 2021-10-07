# frozen_string_literal: true

require 'spec_helper'
require 'vending_machine'

describe CoinStacksRepository do
  subject { described_class.new }

  describe '#all_coins' do
    let(:raw_coins) do
      { coins: [
        { denomition: 3, count: 2 }
      ] }
    end
    before do
      allow(subject).to receive(:raw_data).and_return(raw_coins)
    end

    it 'returns array with available coins from raw_data' do
      expect(subject.all_coins.count).to eq(1)
    end

    it 'returns coins with correct values' do
      expect(subject.all_coins.first.denomition).to eq(3)
      expect(subject.all_coins.first.count).to eq(2)
    end
  end

  describe '#new_stack' do
    it 'build new CoinStack object' do
      new_coin_stack = subject.new_stack(10, 5)
      expect(new_coin_stack.denomition).to eq(10)
      expect(new_coin_stack.count).to eq(5)
    end
  end
end
