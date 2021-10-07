# frozen_string_literal: true

class CoinStack
  attr_reader :denomition, :count

  def initialize(denomition, count)
    @denomition = denomition
    @count = count
  end

  def to_s
    "Denomition: #{denomition}, Count: #{count.to_i}"
  end
end
