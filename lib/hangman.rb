class Hangman
  attr_accessor :word, :word_length, :tries, :used_letters

  def initialize
    puts "Welcome to Hangman!"
    @word = select_word
    @word_length = @word.length
    @tries = 12
    @used_letters = ["a", "e", "i", "o", "u"]
    interface
  end

  def select_word
    File.open("5desk.txt") do |file|
      words = file.readlines
      selected_words = words.select { |word| word.strip.length.between?(5, 12) }
      random_word = selected_words.sample.strip
    end
  end

  def display_feedback
    print "\n\n"
    puts "Tries: #{@tries}"
    puts "Length of word: #{@word_length}"
    puts "Letters used: #{@used_letters.join}"
    print "\n\t"
    @word.split('').each do |letter|
      print "_" unless @used_letters.include?(letter.downcase)
      print letter if @used_letters.include?(letter.downcase)
      print " "
    end
    puts "\n\n"
  end

  def handle_user_input
    puts "Guess a letter:"
    print "> "
    input = gets.strip.downcase
    if input.length > 1
      if input == "exit"
        input
      elsif input == "save"
        save_game
      elsif input == "restore"
        restore_game
      else
        puts "Wrong input. Enter just one letter."
      end
    elsif input.to_i != 0 || input == "0"
      puts "Wrong input. You can't enter digits."
    elsif input =~ /\w/
      if @used_letters.include?(input)
        puts "You've already guessed this letter!"
      elsif @word.downcase.include?(input) == false
        @tries -= 1
        @used_letters << input unless @used_letters.include?(input)
      elsif @word.downcase.include?(input)
        @used_letters << input unless @used_letters.include?(input)
      end
    else
      puts "Wrong input."
    end
  end

  def won_or_lose
    if @tries == 0
      puts "You didn't guess the word."
      puts "The word was '#{@word}'"
      return "lose"
    elsif @word.downcase.split('') - @used_letters == []
      display_feedback
      puts "Congratulations!"
      return "won"
    end
  end

  def save_game
    File.open('saved_game', 'w') do |file|
      file.puts Marshal::dump(self)
    end
    puts "Your game is saved."
  end

  def restore_game
    File.open('saved_game', 'r') do |file|
      if file.eof?
        puts "You don't have a saved game."
      else
        restored_game = Marshal::load(file)
        self.word = restored_game.word
        self.word_length = restored_game.word_length
        self.tries = restored_game.tries
        self.used_letters = restored_game.used_letters
        puts "Your game is restored."
      end
    end
  end

  def interface
    begin
      display_feedback
      user_input = handle_user_input
      result = won_or_lose
    end until user_input == "exit" || result == "lose" || result == "won"
  end
end

# Start the game
new_game = Hangman.new
