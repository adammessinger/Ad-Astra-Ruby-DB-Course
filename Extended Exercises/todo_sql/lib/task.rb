require 'pg'

class Task
  attr_reader :name

  def initialize (name)
    @name = name
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      tasks.push(Task.new(name))
    end
    tasks
  end

  # re-define == for this class to mean "has the same name"
  def == (another_task)
    another_task.instance_of?(self.class) && self.name == another_task.name
  end

  def save
    DB.exec("INSERT INTO tasks (name) VALUES ('#{@name}');")
  end
end
