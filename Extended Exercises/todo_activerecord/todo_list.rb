require 'active_record'
require './lib/task'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['development']
)

def welcome
  puts "\nWelcome to the To Do list!"
  puts '--------------------------'
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "\nPress 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.strip
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      mark_done
    when 'e'
      puts "\nGoodbye!"
    else
      puts "\nSorry, that wasn't a valid option."
    end
  end
end

def add
  puts "\nWhat do you need to do?"
  task_name = gets.strip
  task = Task.new({:name => task_name, :done=> false})
  task.save
  puts "\n'#{task_name}' has been added to your To Do list."
end

def list
  puts "\nHere is everything you need to do:"
  puts '----------------------------------'
  Task.not_done.each {|task| puts task.name}
end

def mark_done
  puts "\nWhich of these tasks would you like to mark as done?"
  puts '----------------------------------------------------'
  Task.not_done.each {|task| puts task.name}
  puts "\n"
  done_task_name = gets.strip
  done_task = Task.where({:name => done_task_name}).first
  if done_task
    done_task.update({:done => true})
  else
    puts "\n'#{done_task_name}' is not a valid option."
  end
end

welcome
