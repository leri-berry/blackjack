# frozen_string_literal: true
class Interface

  def greetings
    puts '----------------------------------'
    puts 'Добро пожаловать в Блекджек'
    puts '----------------------------------'
  end

  def ask_name
    puts 'Введите имя'
    gets.chomp
  end

  def choice
    puts 'Выберите действие:'
    puts 'pass'
    puts 'add_card'
    puts 'open_card'
    gets.chomp
  end

  def show_cards(player, dealer)
    puts 'Карты игрока'
    player.cards.each { |card| puts "#{card.symbol} #{card.suit}"}
    puts "Сумма очков игрока: #{player.sum_cards}"
    puts '----------------------------------'
    puts 'Карты дилера'
    dealer.cards.each { |card| puts '***' }
    puts '----------------------------------'
  end

  def open_cards(player, dealer)
    puts 'Карты игрока'
    player.cards.each { |card| puts "#{card.symbol} #{card.suit}"}
    puts "Сумма очков игрока: #{player.sum_cards}"
    puts '----------------------------------'
    puts 'Карты дилера'
    dealer.cards.each { |card| puts "#{card.symbol} #{card.suit}"}
    puts "Сумма очков дилера: #{dealer.sum_cards}"
    puts '----------------------------------'
  end


  def taking_pass
    puts 'Дилер пропускает ход'
  end

  def dealer_takeing_card
    puts 'Дилер берет карту'
  end

  def draw
    puts 'Ничья'
  end

  def ask_new_game
    puts 'Хотите сыграть еще? Yes/No'
    choice = gets.chomp
  end

  def giving_cards
    puts 'Раздача по 2 карты'
  end

  def start_game
    puts 'Давайте начнем игру'
  end
end