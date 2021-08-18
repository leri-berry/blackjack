# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    Card::SUITS.each do |suit|
      Card::VALUES.each_key do |symbol|
        @deck << Card.new(suit, symbol)
      end
    end
    @deck.shuffle!
  end

  def new_card
    @deck.pop
  end
end
