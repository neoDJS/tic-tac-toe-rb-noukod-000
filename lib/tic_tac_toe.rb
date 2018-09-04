require 'pry'
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6],  # Middle row
  [1,4,7], # Top row
  [2,5,8],  # Middle row
  [0,4,8], # Top row
  [2,4,6]  # Middle row
  # ETC, an array for each win combination
]


def won?(board)
  WIN_COMBINATIONS.detect{|case_set| case_set.all?{|case_i| position_taken?(board, case_i) && board[case_i] == "X"} || case_set.all?{|case_i| position_taken?(board, case_i) && board[case_i] == "O"}}
end

def full?(board)
  board.all?{|case_i| case_i != " "}
end

def draw?(board)
  full?(board) && !WIN_COMBINATIONS.include?(won?(board))
end

def over?(board)
  WIN_COMBINATIONS.include?(won?(board)) || draw?(board)
end

def winner(board)
  winner_i = over?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  counter_taken = 0

  board.each do |casier|
    counter_taken += (casier == "X" || casier == "O") ? 1 : 0
  end
 return counter_taken
end


def current_player(board)
  player = turn_count(board)%2 == 0 ? "X" : "O"
end



def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
 #winner_user = ""
 #counter = 0
 #binding.pry
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  elsif WIN_COMBINATIONS.include?(won?(board))
    #winner_user = winner(board)
    puts "Congratulations #{winner(board)}!"
  end
end


def tab_line(l_num, tab)
    line = " "
	count = 0
	3.times{ line  += "#{tab[ l_num*3 + count ]}"
	         if count < 2
			          line += " | "
			     else
			          line += " "
			     end
	         count += 1 }
	return line
end


def display_board(board)
  sLine = ""
  count_l = 0

  3.times{
  	puts tab_line(count_l, board)
  	if count_l < 2
  		puts "-----------"
  	end
    count_l += 1
  }

end
