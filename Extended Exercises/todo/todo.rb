# TODO: generalize input and error message handling, at least for cases when
# user has to provide a valid task number.

require './lib/task'

def main_menu
  loop do
    puts "\nCOMMANDS"
    puts '"a" to Add a task' + "\n"
    puts '"l" to List all of your tasks.' + "\n"
    puts '"r" to Rename a task.' + "\n"
    puts '"d" to Delete a task' + "\n"
    puts '"c" to Clear (delete) all tasks' + "\n"
    puts '"x" to eXit.'
    main_choice = gets.strip

    # TODO: use switch
    if main_choice == 'a'
      add_task
    elsif main_choice == 'l'
      list_tasks
    elsif main_choice == 'r'
      rename_task
    elsif main_choice == 'd'
      delete_task
    elsif main_choice == 'c'
      clear_tasks
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
  task = Task.new({:description => user_description})

  task.save
  puts "Task added.\n\n"
end


def delete_task
  puts "\nEnter the number of the task to delete:"
  user_choice = gets.strip
  task_index = user_choice.to_i - 1

  if task_index > 0 && Task.all[task_index]
    Task.delete task_index
    puts "\nTask number #{user_choice} deleted."
  else
    puts "\nThat's not a valid task number."
  end
end


# TODO: prompt "Are you sure you want to delete all tasks?"
def clear_tasks
  Task.clear
  puts "\nAll tasks deleted."
end


def rename_task
  puts "\nEnter the number of the task to rename:"
  user_choice = gets.strip
  task_index = user_choice.to_i - 1

  if task_index > 0 && Task.all[task_index]
    puts "\nEnter a new description:"
    new_descr = gets.strip
    Task.all[task_index].description = new_descr
    puts "\nTask number #{user_choice} renamed to \"#{new_descr}\""
  else
    puts "\nThat's not a valid task number."
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
