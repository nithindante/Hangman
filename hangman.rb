require 'yaml'
my_file = File.open('strings.txt', 'r')
computer_choice = []

def generate_random_word(computer_choice, my_file)
  while line = my_file.gets
    computer_choice.push(line.chomp) if line.length > 5 && line.length <= 12
  end
  computer_choice.sample
end

random_word = generate_random_word(computer_choice, my_file)
no_of_guesses = 10
p "no of guesses is #{no_of_guesses}"

def input_from_user
  p 'Enter your choice'
  input_choice = gets.chomp.to_s
end

arr_randomword = random_word.split('')

arr = []
len = arr_randomword.length
for i in 0..len - 1 do
  arr.push('_')
end

wrong_choices = []

def guess_game(arr_randomword, input_choice, arr, wrong_choices, no_of_guesses)
  if arr_randomword.include?(input_choice.downcase)
    arr_randomword.each_with_index do |letter, index|
      next unless input_choice.downcase == letter

      arr[index] = letter.downcase
      p 'Your guess is correct,'
      no_of_guesses -= 1
      p arr
      print 'Wrong guess='
      p wrong_choices
    end
  elsif wrong_choices.include?(input_choice)
    no_of_guesses -= 1
    print 'Your guess is wrong,'
    p wrong_choices
    print 'The correctly guessed elements are'
    p arr
  else
    wrong_choices.push(input_choice.chomp)
    no_of_guesses -= 1
    print 'Your guess is wrong,'
    p wrong_choices
    print 'The correctly guessed elements are'
    p arr
  end
end

class GameStatus
  attr_accessor :elements_in_correct, :no_of_guesses, :wrong_guesses

  def initialize(elements_in_correct, no_of_guesses, wrong_guesses,random_array)
    @elements_in_correct = elements_in_correct
    @no_of_guesses = no_of_guesses
    @wrong_guesses = wrong_guesses
    @random_array = random_array
  end

  def to_yaml
    YAML.dump({
                elements_in_correct: @elements_in_correct,
                no_of_guesses: @no_of_guesses,
                wrong_guesses: @wrong_guesses,
                random_array: @random_array
              })
  end

#   def self.from_yaml(string)
#     data = YAML.load string
#     p data
#     new(data[:elements_in_correct], data[:no_of_guesses], data[:wrong_guesses],data[:random_array])
#   end
# end

def check_winner(arr, arr_randomword)
  return 1 if arr == arr_randomword
end
sum = 10



for i in 1..no_of_guesses
  if i ==1
    p 'Do you want to load the previous saved version (Y/N)'
    saved_version = gets.chomp.to_s
    if saved_version.downcase=="y"
       demo = YAML.load(File.read("file.yaml"))
        arr = demo[:elements_in_correct]
        sum = demo[:no_of_guesses]
        wrong_choices = demo[:wrong_guesses]
        arr_randomword = demo[:random_array]
    else
      p 'Do you want to save the game(Y) or continue playing(N)'
      choice = gets.chomp.to_s
      if choice == 'Y'
        demo = GameStatus.new arr, sum, wrong_choices,arr_randomword
        File.open("file.yaml", "w") do |file|
          file.write(demo.to_yaml)
        end
        print 'Save game'
        next
      else
        sum = sum-1
        input = input_from_user
        guess_game(arr_randomword, input, arr, wrong_choices,no_of_guesses)
        p "no of guess remaining is #{sum}"
          if check_winner(arr, arr_randomword) == 1
            p 'You guessed it right'
            break
          elsif no_of_guesses - i == 0
            p 'Sorry, you werent able to guess the correct word'
            break
          end
      end
    end
  else
      p 'Do you want to save the game(Y) or continue playing(N)'
      choice = gets.chomp.to_s
      if choice == 'Y'
        demo = GameStatus.new arr, sum, wrong_choices, arr_randomword
        File.open("file.yaml", "w") do |file|
          file.write(demo.to_yaml)
        end
        print 'Game Saved'
        next
      else
        sum = sum-1
        input = input_from_user
        guess_game(arr_randomword, input, arr, wrong_choices, no_of_guesses)
        p "no of guess remaining is #{sum}"
        if check_winner(arr, arr_randomword) == 1
          p 'You guessed it right'
          break
        elsif no_of_guesses - i == 0
          p 'Sorry, you werent able to guess the correct word'
          break
        end
      end
  end
end
