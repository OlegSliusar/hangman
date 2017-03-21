class Hangman
  def initialize
    puts "Welcome to Hangman!\n\n"
    @word = select_word
    puts "the word is #{@word}\n\n"
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
    puts "Enter your guess:"
    print "> "
    input = gets.strip.downcase
    if input.length > 1
      return input if input == "exit"
      puts "Wrong input. Enter just one letter."
    elsif input.to_i != 0 || input == "0"
      puts "Wrong input. You can't enter digits."
    elsif input =~ /\w/
      if @word.downcase.include?(input) == false
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
