def pig_latin(word)
  vowels = ['a', 'e', 'i', 'o', 'u']
  first_letter = word[0]

  if vowels.include? first_letter
    word + 'ay'
  else
    word[1..-1] + first_letter + 'ay'
  end
end
