def jedi_name(first_name, first_pet_name, birth_city)
  first_name.strip!
  first_pet_name.strip!
  birth_city.strip!

  jedi_first = build_jedi_first_name(first_name, first_pet_name)
  jedi_last = build_jedi_last_name(first_name, first_pet_name)
  planet = birth_city.split(/\W/).last.reverse.capitalize

  "#{jedi_first} #{jedi_last} of planet #{planet}"
end

def build_jedi_first_name(first_name, first_pet_name)
  j_first = get_name_segment(first_pet_name.reverse)
  j_first += get_name_segment(first_name.reverse)
  j_first.capitalize
end

def build_jedi_last_name(first_name, first_pet_name)
  j_last = get_name_segment(first_name)
  j_last += get_name_segment(first_pet_name)
  j_last.capitalize
end

def get_name_segment(word)
  word.length < 3 ? word : /^.*?[aeiouy]+[a-z&&[^aeiouy]]+?/i.match(word).to_s
end
