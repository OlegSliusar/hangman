require_relative 'lib/hangman.rb'

def interface
  begin
    display_feedback
    user_input = handle_user_input
    result = won_or_lose
  end until user_input == "exit" || result == "lose" || result == "won"
end

# Start the game
new_game = Hangman.new
