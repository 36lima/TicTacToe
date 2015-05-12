require 'pry'

PLAYER_WIN = 1
COMPUTER_WIN = 2
TIE_GAME = -1
PLAYER_TURN = 2
COMPUTER_TURN = 3
NO_WINNER_YET = nil

def initialize_board
  b = {}
  (1..9).each {|position| b[position] = ' '}
  b
end

def draw_board(board)
  puts " #{board[1]} | #{board[2]} | #{board[3]}    Reference:   1 | 2 | 3"
  puts "---+---+---            ---+---+---"
  puts " #{board[4]} | #{board[5]} | #{board[6]}                 4 | 5 | 6 "
  puts "---+---+---            ---+---+---"
  puts " #{board[7]} | #{board[8]} | #{board[9]}                 7 | 8 | 9"
end

def player_chooses_square(board, player_mark)
  begin
    good_selection = FALSE
    puts "Please pick a square to make your move [1 - 9]:"
    position = gets[0].to_i
    if board.keys.include?(position) && board[position] == ' '
      board[position] = player_mark
      good_selection = TRUE
    else
      puts "Error: Either the position was not valid or that spot is already taken!"
    end
  end until good_selection
end

def find_empty_square(board)
  board.select {|k,v| board[k] == ' '}.keys.sample
end

def computer_chooses_square(board, computer_mark)
  board[find_empty_square(board)] = computer_mark
  return nil
end

def choose_marks
  begin
    puts "Do you want to be X or O?"
    player_mark =gets[0].upcase
  end until player_mark.match(/X|O/)
  player_mark == 'X' ? computer_mark = 'O' : computer_mark = 'X'
  [player_mark, computer_mark]
end

def check_win_or_tie(board, player_mark, computer_mark)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  winning_lines.each do |line|
    if (board[line[0]] == player_mark) && (board[line[1]] == player_mark) && (board[line[2]] == player_mark)
      return PLAYER_WIN
    elsif (board[line[0]] == computer_mark) && (board[line[1]] == computer_mark) && (board[line[2]] == computer_mark)
      return COMPUTER_WIN
    end
  end
  if !find_empty_square(board)
    return TIE_GAME
  end
  return NO_WINNER_YET
end


# Main Program
begin 
  system("clear screen")
  new_game = 1
  board = initialize_board
  player_mark, computer_mark = choose_marks
  draw_board(board)
  begin 
    # if new_game == 1
    #   draw_board(board)
    #   player_chooses_square(board, player_mark)
    #   draw_board(board)
    #   computer_chooses_square(board, computer_mark)
    #   system("clear screen")
    #   draw_board(board)
    #   puts "Computer chose a square."
    # end
    game_state = check_win_or_tie(board, player_mark, computer_mark)
    case game_state
    when NO_WINNER_YET
        player_chooses_square(board,player_mark)
        system("clear screen")
        draw_board(board)
        computer_chooses_square(board, computer_mark)
        system("clear screen")
        draw_board(board)
    when PLAYER_WIN
      puts "YOU WON!!!"
      break
    when COMPUTER_WIN
      puts "Sorry, the computer won :("
      break
    when TIE_GAME
      puts "Cats and Dogs Won. It was a tie."
      break
    else
      puts "Uh-oh, we should never, ever, ever get here. Something went horribly wrong."
    end
  end until (game_state != NO_WINNER_YET) 

  puts "Play again? [Y|N]:"
  new_game = 1
end until gets[0].downcase != 'y' 





