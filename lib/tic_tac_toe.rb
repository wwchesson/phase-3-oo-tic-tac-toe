class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts "------------"
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(string)
        array_integer = "#{string}".to_i
        array_input = array_integer - 1
        array_input
    end
    
    def move(space, token = "X")
        board[space] = token 
    end

    def position_taken?(position)
        if board[position] == " "  
            false
        elsif board[position] == "X" || "O"
            true
        end
    end

    def valid_move?(position)
        position.between?(0, 8) && !position_taken?(position) ? true : false
    end

    def turn_count
        @board.filter{|position| position != " "}.count
    end

    def current_player
        turn_count.even? ? "X" : "O" 
    end

    def turn
        input = gets.chomp
        position = input_to_index(input)
        if valid_move?(position)
            token = current_player
            move(position, token)
            display_board
        else
            turn
        end
    end

    def won?  
        WIN_COMBINATIONS.any? do |combo|
            if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all?{|space| space != " "}
    end

    def draw?
        self.full? && !self.won? ? true : false
    end

    def over? 
        self.won? || self.draw? 
    end

    def winner
        combo = won?
        binding.pry
        if combo
            @board[combo[0]]
        else
            return nil
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}" : "Cat's Game!"
    end
end

