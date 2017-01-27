require_relative 'view'
require_relative 'player'
require_relative 'ai'
require_relative 'board'

class TicTacToe

  def initialize
    @view = View.new
    @player = Player.new
    @ai = Ai.new
    @board = Board.new
    @turn = 0
    @players = [@ai, @player]
  end

  def run
    player_symbol = @view.welcome_player
    player_symbol.upcase!
    if player_symbol == 'X' || player_symbol == 'O'
      @player.name = player_symbol
      @ai.set_name player_symbol
    else
      return @view.get_it_together
    end

    order_choice = @view.player_order
    if order_choice.downcase == 'yes'
      @players.reverse! 
    else
      @players
    end
    play_game

  end

  private

  def play_game
    until game_won?
      possible_moves = [[1,1], [1,2], [1,3], [2,1], [2,2], [2,3], [3,1], [3,2], [3,3]]
      moves_made = []
      player = @players[@turn % 2]

      @view.print_board @board.get_board, player.name


      if player.is_a? Player
        square = @view.choose_square
      else
        square = @ai.choose_square
      end

      return @view.get_it_together unless user_input_valid? square
      
      move = [square[0].to_i, square[1].to_i]
      moves_made << move
      move_location = possible_moves.index[move]
      possible_moves.delete_at(move_location)

      row = square[0].to_i - 1
      column = square[1].to_i - 1

      @board.update_square row, column, player.name

      @turn += 1
    end
    @view.congratulate_winner @board
  end

  def game_won?
    @board.check_for_winner
  end

  def user_input_valid? square
    square.each do |input|
      return false unless input_valid? input.to_i
    end
    true
  end

  def input_valid? input
    input.is_a?(Integer) && input > 0 && input < 4
  end
end
