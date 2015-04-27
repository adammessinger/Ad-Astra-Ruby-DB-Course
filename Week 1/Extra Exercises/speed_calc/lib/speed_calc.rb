def speed_calc distance_miles, time_hours
  speed = (distance_miles.to_f / time_hours.to_f).round
  "#{speed} MPH"
end
