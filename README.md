# Hangman
A command line Hangman game where one player plays against the computer,  player thinks of a word, phrase, or sentence and the other(s) tries to guess it by suggesting letters or numbers within a certain number of guesses. 

Observations:

A Strings.txt file was there which helped us with around 9000 strings and I sorted the ones whose length was between 5 and 12 
Wrote the function to check whether the alpahbet we guess is in the array, by taking each_with_index and each loop to iterate through the array
I saved my vraiables which stores the no of correct elements, the no of guesses, the no of wrong guesses, the random word generated and converted them all into a object, I converted that object to a YAML file by .to_yaml and then saved it to a external YAML file by file.open("File.yam;"."w") do |file| file.write(object.to_yaml)
Now I made changes so that, every time the game sarts,. our code will ask and if agreed, will read the YAML file and store the contents to the current values

