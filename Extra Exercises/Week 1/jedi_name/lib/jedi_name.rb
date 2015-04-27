def jedi_name first_name, first_pet_name, birth_city
  jedi_first = get_name_segment(first_pet_name.reverse)
  jedi_first += get_name_segment(first_name.reverse)
  jedi_first.capitalize!

  jedi_last = get_name_segment(first_name)
  jedi_last += get_name_segment(first_pet_name)
  jedi_last.capitalize!

  planet = birth_city.split(/\W/).last.reverse.capitalize

  "#{jedi_first} #{jedi_last} of planet #{planet}"
end

def get_name_segment word
  unless word.length < 3
    word = /^.*?[aeiouy]+[a-z&&[^aeiouy]]+?/i.match(word).to_s
  end
  word
end
