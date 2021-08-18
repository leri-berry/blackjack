# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'bank'
require_relative 'interface'

class Game

  def initialize
    @interface = Interface.new
    @interface.greetings
    @bank = Bank.new
    @deck = Deck.new
  end


  def start_game
    new_game
  end

  private

  def new_game
    @interface.start_game
    create_player
    start_deal
    @bank.auto_bet(@player, @dealer)
    game_round
    play_again
  end

  def create_player
    @dealer = Dealer.new
    name = @interface.ask_name
    @player = Player.new(name)
  end

  def new_card
    @deck.new_card
  end

  def start_deal
    @interface.giving_cards
    2.times do
      @player.add_cards(new_card)
      @dealer.add_cards(new_card)
    end
    @interface.show_cards(@player, @dealer)
  end

  def game_round
    loop do
      player_move
      return open_action if 'open_card'

      dealer_move
      return auto_opening_cards if full?
    end
  end

  def player_move
    choice = @interface.choice
    case choice
    when 'pass'
      dealer_move
    when 'add_card'
      add_action
    else
      open_action
    end
  end

  def dealer_pass
    player_move
    @interface.choice
  end

  def dealer_move
    if @dealer.take_card?
      @interface.dealer_taking_card
      @dealer.add_cards(new_card)
      @interface.show_cards(@player, @dealer)
      player_move
    else
      @interface.taking_pass
      dealer_pass
    end
  end

  def add_action
    unless @player.full_hand?
      @player.add_cards(new_card)
      @interface.show_cards(@player, @dealer)
      dealer_move
    end
  end

  def draw(player, dealer, bank)
    bank.reset_bank
    player.bank += 10
    dealer.bank += 10
  end

  def winner(user, bank)
    user.bank += @bank.bank
    bank.reset_bank
  end

  def who_is_winner(player, dealer)
    if player.sum_cards > dealer.sum_cards && player.sum_cards <= 21
      puts "Вы победитель, #{player.name}"
      winner(@player, @bank)
      puts "Банк игрока #{@player.bank}"
    elsif dealer.sum_cards > player.sum_cards && dealer.sum_cards <= 21
      puts "#{player.name}, вы проиграли"
      winner(@dealer, @bank)
      puts "Банк дилера #{@dealer.bank}"
    else
      @interface.draw
      draw(@player, @dealer, @bank)
    end
  end

  def open_action
    @interface.open_cards(@player, @dealer)
    who_is_winner(@player, @dealer)
  end

  def auto_opening_cards
    @player.full_hand? && @dealer.full_hand?
    who_is_winner(@player, @dealer)
    @interface.show_cards(@player, @dealer)
  end

  def full?
    @player.full_hand? && @dealer.full_hand?
  end

  def play_again
    loop do
      @interface.ask_new_game
      choice = gets.chomp
      case choice
      when 'Yes'
        new_game
      when 'No'
        break
      end
    end
  end
end

Game.new.start_game