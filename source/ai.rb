class Ai
  attr_accessor :wins
  attr_reader :name

  def initialize
    @wins = 0
  end

  def set_name player_name
    @name = player_name == 'X' ? 'O' : 'X'
  end

  def choose_square
    
    row =
    column = 
  end
end
