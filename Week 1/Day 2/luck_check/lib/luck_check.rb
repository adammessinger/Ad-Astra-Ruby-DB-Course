def luck_check(ticket_number)
  length = ticket_number.length
  part1_end = length/2
  part2_start = length.odd?() ? (part1_end + 1) : part1_end

  first_half = ticket_number[0...part1_end].split('')
  second_half = ticket_number[part2_start..-1].split('')

  luck_check_half_sum(first_half) == luck_check_half_sum(second_half)
end

def luck_check_half_sum(ticket_half)
  sum = 0
  ticket_half.each { |n| sum += n.to_i }
  sum
end
