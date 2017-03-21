class Hangman
  def initialize
    puts "Welcome to Hangman!\n\n"
    @word = select_word
    @word_length = @word.length
    @tries = 12
    @used_letters = ["a", "e", "i", "o", "u"]
    display_feedback
  end

  def select_word
    File.open("5desk.txt") do |file|
      words = file.readlines
      selected_words = words.select { |word| word.strip.length.between?(5, 12) }
      random_word = selected_words.sample.strip
    end
  end

  def display_feedback
    puts "Tries: #{@tries}"
    puts "Length of word: #{@word_length}"
    puts "Letters used: #{@used_letters.join}"
  end
end

new_game = Hangman.new
