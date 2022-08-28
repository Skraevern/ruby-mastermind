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
            puts "#{@code.secret_code}" 
        else
            ##puts ""
            puts "#{@code.secret_code}"
        end
        puts "#{@code.duplicate_numbers}"
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
            puts "Guess code 4 numbers. Num 1 through 8. q to quit."
            input = gets.chomp
            if input == "q" 
                @correct_code = true
                break
            end
            input = input.delete(' ').to_i
            input_array = input.to_s.split("")
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
        duplicate_numbers_temp = @code.duplicate_numbers
        
        if code_to_check == @code.secret_code
            display_board()
            @correct_num = 4
            @correct_place = 4
            @correct_code = true
        else
            @code.secret_code.each { |code_num| code_to_check.each { |check_num| 
                if code_num == check_num
                    # check number of duplicates [[num, times], [num, times]] to get correct correct_num
                    duplicate_numbers_temp.each_with_index { |arr| 
                        if arr[0] == code_num 
                            if arr[1] > 0
                                @correct_num = @correct_num + 1
                                arr[1] = arr[1] - 1
                            end
                        end
                    }
                end    
            }}
            @code.secret_code.each_with_index { |code_num, i | 
                if @code.secret_code[i] == code_to_check[i]
                    @correct_place = @correct_place + 1
                end
            }
        end

    end
    def display_winner()
        display_board()
        if @correct_place == 4
            puts "Wins"
        else
            puts "Quit"
        end
    end
end

class Code
    attr_accessor :secret_code, :duplicate_numbers
    def initialize()
        @secret_code = []
        @duplicate_numbers = [] #[[num, times], [num, times]]
        add_random_code()
    end
    def add_random_code()
        4.times { @secret_code.push(rand(1..8)) }
        puts "#{@secret_code}"
        @duplicate_numbers = @secret_code.group_by{|i| i}.map{|k,v| [k, v.count] }
        puts "#{@duplicate_numbers}"
    end
end
def clear()
    print "\e[2J\e[H"
end
clear()
code = Code.new()
game = Game.new(code)