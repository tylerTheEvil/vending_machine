# frozen_string_literal: true

class CoinStack
  attr_accessor :count
  attr_reader :denomition

  def initialize(denomition, count)
    @denomition = denomition
    @count = count
  end

  def to_s
    "Denomition: #{denomition}, Count: #{count.to_i}"
  end

  def value
    denomition * count.to_i
  end
end
