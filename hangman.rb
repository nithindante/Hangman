my_file = File.open('google-10000-english-no-swears.txt', 'r')
computer_choice=[]

def generate_random_word(computer_choice,my_file)
  while line = my_file.gets 
    if line.length > 5 && line.length <= 12
      computer_choice.push(line.chomp)
    end
  end
    return computer_choice.sample
end

random_word = generate_random_word(computer_choice,my_file)
p random_word
no_of_guesses = 6
p "no of guesses is #{no_of_guesses}"
user_choice = []

def input_from_user()
    p 'Enter your choice'
    input_choice = gets.chomp.to_s
    #user_choice.push(input_choice)
end

arr_randomword = random_word.split('')

arr = []
len = arr_randomword.length
for i in 0..len-1 do
  arr.push('_')
end

wrong_choices=[]

def guess_game(arr_randomword, input_choice, arr, wrong_choices,no_of_guesses)
    #p "my input is #{input_choice}"
    unless arr_randomword.include?(input_choice)
        unless wrong_choices.include?(input_choice)
            wrong_choices.push(input_choice.chomp)
            no_of_guesses -= 1
            print "Your guess is wrong,"
            p wrong_choices
        else
            print "Your guess is wrong,"
            p wrong_choices
        end
    else
        arr_randomword.each_with_index do |letter, index|
            if input_choice.downcase == letter
                arr[index] = letter
                p "Your guess is correct,"
                no_of_guesses -= 1
                p arr
                print "Wrong guess="
                p wrong_choices
            end
        end
    end
end
 
for i in 1..no_of_guesses
    input = input_from_user()
    guess_game(arr_randomword,input,arr,wrong_choices,no_of_guesses)
    p "no of guess remaining is #{no_of_guesses-i}"

end
