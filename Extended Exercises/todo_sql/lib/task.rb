require 'pg'

class Task
  attr_reader :name

  def initialize (name)
    @name = name
  end

  def self.all
    database = PG.connect({:dbname => 'todo', :user => 'postgres', :password => 'pickle'})
    results = database.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do|result|
      name = result['name']
      tasks.push(Task.new(name))
    end
    tasks
  end

  #
  def == (another_task)
    self.name == another_task.name
  end

  def save
    database = PG.connect({:dbname => 'todo', :user => 'postgres', :password => 'pickle'})
    database.exec("INSERT INTO tasks (name) VALUES ('#{@name}');")
  end
end
