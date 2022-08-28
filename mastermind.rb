class Game
    def initialize(code)
        @code = code
        @turns_left = 12
        @attempts = []
        @correct_code = false
        @correct_num = 0
        @correct_place = 0
        display_board()
        play()

    end
    def display_board()
        clear()
        if @correct_code
            puts "#{@code}" 
        else
            ##puts ""
            puts "#{@code}"
        end
        @turns_left.times { puts " #  #  #  # " }
        @attempts.each { |arr| puts " #{arr[0]}  #{arr[1]}  #{arr[2]}  #{arr[3]}  Correct num #{@correct_num}   Correct place #{@correct_place}"}
    end
    def play()
        while !@correct_code
            display_board()
            input_code()
            check_right_code()
        end
        display_winner()
    end

    def input_code()
        correct_input = false
        num_array = []        
        while !correct_input
            input_array = []
            num_array = []
            puts "Guess code. Num 1 through 8"
            guess = gets.chomp.delete(' ').to_i
            input_array = guess.to_s.split("")
            input_array.each { |num| num_array.push(num.to_i) }
            if input_array.length == 4
                correct_input = num_array.all? { |num| num.between?(1,8) }
            end
        end
        @turns_left = @turns_left - 1
        @attempts.insert(0, num_array)
    end

    def check_right_code
        @correct_num = 0
        @correct_place = 0
        code_to_check = @attempts[0]
        
        if code_to_check == @code
            display_board()
            @correct_num = 4
            @correct_place = 4
            @correct_code = true
        else
            @code.each { |code_num| code_to_check.each { |check_num| 
                if code_num == check_num
                    @correct_num = @correct_num + 1
                end    
            }}
            @code.each_with_index { |code_num, i | 
                if @code[i] == code_to_check[i]
                    @correct_place = @correct_place + 1
                end
            }
        end

    end
    def display_winner()
        display_board()
        puts "Wins"
    end
end

class Code
    attr_accessor :secret_code
    def initialize()
        @secret_code = []
        add_random_code()
    end
    def add_random_code()
        4.times { @secret_code.push(rand(1..8)) }
        puts "#{@secret_code}"
    end
end
def clear()
    print "\e[2J\e[H"
end
clear()
code = Code.new()
game = Game.new(code.secret_code)