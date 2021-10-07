# frozen_string_literal: true

require 'spec_helper'
require 'vending_machine'

describe ProductsRepository do
  subject { described_class.new }

  describe '#all_products' do
    let(:raw_products) do
      { products: [
        { name: 'Nuka cola', price: 2.00, slot: 1 }
      ] }
    end
    before do
      allow(subject).to receive(:raw_data).and_return(raw_products)
    end

    it 'returns array with available products' do
      expect(subject.all_products.count).to eq(1)
    end

    it 'products have correct values' do
      expect(subject.all_products.first.name).to eq('Nuka cola')
      expect(subject.all_products.first.price).to eq(2.00)
      expect(subject.all_products.first.slot).to eq(1)
    end
  end
end
