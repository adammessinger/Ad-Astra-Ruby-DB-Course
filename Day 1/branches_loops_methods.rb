def eat_cookies(milk_is_sour = false)
  if milk_is_sour
    'Time to go to the store.'
  else
    'Yum!'
  end
end


def eat_cookies_unless(milk_is_sour = false)
  unless milk_is_sour
    'Yum!'
  else
    'Time to go to the store.'
  end
end


def eat_cookies_elsif(milk_is_sour = false, car_has_gas = true)
  if milk_is_sour && car_has_gas
    'Time to go to the store.'
  elsif milk_is_sour && !car_has_gas
    'Time to gas up the car.'
  else
    'Yum!'
  end
end


def upcase_names(names)
  names.map { |name| name.upcase }
end


def print_fave_cookies
  fave_cookies_by_person_fname = {
    'Adam' => 'chocolate chip',
    'Liz'  => 'Double Stuff Oreos',
    'Mila' => 'salmon cat treats'
  }

  fave_cookies_by_person_fname.each do |name, cookie|
    puts "#{name}'s favorite cookie is #{cookie}."
  end
end