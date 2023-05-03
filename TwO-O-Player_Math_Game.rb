class Question_maker
  OPERATORS = ['+', '-', '*', '/'].freeze
  # OPERATORS = ['+', '-'].freeze

  def self.game_generate
    num1 = rand(1..20)
    num2 = rand(1..20)
    operator = OPERATORS.sample

    calculate = "#{num1}#{operator}#{num2}"
    answer = case operator
      when '+'
        num1 + num2
      when '-'
        num1 - num2
      when '*'
        num1 * num2
      when '/'
        num1 / num2
    end


    if operator == "+"
      operator = "plus"
    elsif operator == "-"
      operator = "subtract"
    elsif operator == "/"
      operator = "divide"
    elsif operator == "*"
      operator = "multiply"
    end

    question = "What does #{num1} #{operator} #{num2} equal?"
    { question: question, answer: answer }
  end
end
# puts Question_maker.game_generate()

class Game 
  def initialize
    @player1_lives = 3
    @player2_lives = 3
    @current_player = 1
    @other_player = 2
  end

  def play
    loop do
      question = Question_maker.game_generate()
      puts "Player #{@current_player}: What does #{question[:question]}"
      user_answer = Kernel.gets.chomp.to_f.round(2)

      if user_answer == question[:answer]
        puts "Player #{@current_player}: YES! You are correct."
        change_player()
        puts "Player 1: #{@player1_lives}/3 vs Player 2: #{@player2_lives}/3"
        puts "----- NEW TURN -----"
      else
        puts "Player #{@current_player}: Seriously? No !"
        decrease_lives()
        break if @player1_lives == 0 || @player2_lives == 0
        change_player()
        puts "Player 1: #{@player1_lives}/3 vs Player 2: #{@player2_lives}/3"
        puts "----- NEW TURN -----"
      end

    end
    announce_winner()
  end  

  private

  def decrease_lives
    if @current_player == 1
      @player1_lives -= 1
    else
      @player2_lives -= 1
    end
  end

  def announce_winner
    if @current_player == 1
      puts "Player #{@other_player} wins with a score of #{@player2_lives}/3"
    else
      puts "Player #{@other_player} wins with a score of #{@player1_lives}/3"
    end
    puts "----- GAME OVER -----"
    puts "Good bye!"
  end

  def change_player
    if @current_player == 1 
      @current_player = 2
      @other_player = 1
    else
      @current_player = 1
      @other_player = 2
    end
  end
end

game = Game.new
game.play