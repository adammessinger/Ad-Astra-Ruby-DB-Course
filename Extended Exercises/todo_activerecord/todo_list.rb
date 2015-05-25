require 'active_record'
require './lib/task'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['development']
)

def welcome
  puts "Welcome to the To Do list!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      mark_done
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add
  puts "What do you need to do?"
  task_name = gets.chomp
  task = Task.new({:name => task_name, :done=> false})
  task.save
  puts "'#{task_name}' has been added to your To Do list."
end

def list
  puts "Here is everything you need to do:"
  Task.not_done.each {|task| puts task.name}
end

def mark_done
  puts "Which of these tasks would you like to mark as done?"
  Task.all.each {|task| puts task.name}

  done_task_name = gets.chomp
  done_task = Task.where({:name => done_task_name}).first
  done_task.update({:done => true})
end

welcome
