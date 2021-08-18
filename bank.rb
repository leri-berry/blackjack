# frozen_string_literal: true

class Bank

  attr_accessor :bank
  BET = 10

  def initialize
    @bank = 0
  end

  def auto_bet(player, dealer)
    player.minus_cash(BET)
    dealer.minus_cash(BET)
    @bank = BET * 2
    puts "Game bank -- #{self.bank}"
  end

  def reset_bank
    @bank = 0
  end

end
