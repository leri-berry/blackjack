class Dealer

  attr_accessor :cards, :scores, :bank

  TOTAL_SCORE = 21
  MAX_CARDS = 3
  ACE = 1

  def initialize
    @bank = 100
    @cards = []
  end

  def minus_cash(sum)
    @bank -= sum
  end

  def sum_cards
    sum = @cards.sum(&:value)
    ace_correction(sum)
  end

  def ace_correction(sum)
    @cards.each do |card|
      sum -= ACE if sum > TOTAL_SCORE && card.ace?
    end
    sum
  end

  def take_card?
    @cards.size < MAX_CARDS && sum_cards < 17
  end

  def full_hand?
    @cards.size == MAX_CARDS
  end

  def add_cards(card)
    @cards << card
  end
end