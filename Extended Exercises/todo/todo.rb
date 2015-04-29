require './lib/task'

def main_menu
  loop do
    puts "\nPress 'a' to add a task, 'd' to delete a task, or 'l' to list all of your tasks."
    puts "Press 'x' to exit."
    main_choice = gets.chomp

    if main_choice == 'a'
      add_task
    elsif main_choice == 'l'
      list_tasks
    elsif main_choice == 'd'
      delete_task
    elsif main_choice == 'x'
      puts 'Goodbye.'
      exit
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add_task
  puts "\nEnter a description of the new task:"
  user_description = gets.strip
  task = Task.new user_description

  task.save
  puts "Task added.\n\n"
end

# TODO: fix this deleting the last thing on the array if string is passed
# (because it always ends up passing -1 to delete_at)
def delete_task
  puts "\nEnter the number of the task to delete:"
  task_choice = gets.chomp.to_i - 1

  if Task.all[task_choice]
    Task.all.delete_at task_choice
  else
    puts "\n#{task_choice + 1} is not a valid task number."
  end
end

def list_tasks
  puts "\nHere are all of your tasks:"

  Task.all.each_with_index do |task, index|
    puts "#{index + 1}: #{task.description}, created #{task.created.strftime("%m/%d/%Y")}"
  end
  puts "\n"
end

main_menu
