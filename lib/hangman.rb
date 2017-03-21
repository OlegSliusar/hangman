class Hangman
  def initialize
    puts "Welcome to Hangman!"
    puts select_word
  end

  def select_word
    File.open("5desk.txt") do |file|
      words = file.readlines
      selected_words = words.select { |word| word.length.between?(5, 12) }
      random_word = selected_words.sample.strip
    end
  end
end

new_game = Hangman.new
