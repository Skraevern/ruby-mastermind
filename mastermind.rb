class Game
    def initialize(code)
        @code = code
        @turns_left = 12
        @attempts = []
        display_board()
        input_code()
    end
    def display_board()
        @turns_left.times { puts " #  #  #  # " }
        @attempts.each { |arr| puts " #{arr[0]}  #{arr[1]}  #{arr[2]}  #{arr[3]} "}
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
        @attempts.push(num_array)
    end
end

class Code
    def initialize()
        @secret_code = []
        add_random_code()
    end
    def add_random_code()
        4.times { @secret_code.push(rand(1..8)) }
        puts "#{@secret_code}"
    end
end

code = Code.new()
game = Game.new(code)