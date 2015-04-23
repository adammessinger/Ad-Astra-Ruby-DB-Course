def luck_check(ticket_number)
  length = ticket_number.length
  part1_end = length/2
  part2_start = length.odd? ? part1_end + 1 : part1_end

  first_half = ticket_number[0...part1_end].split('')
  second_half = ticket_number[part2_start..-1].split('')

  sum1 = 0
  sum2 = 0
  first_half.each do |n|
    sum1 += n.to_i
  end
  second_half.each do |n|
    sum2 += n.to_i
  end

  sum1 == sum2
end
