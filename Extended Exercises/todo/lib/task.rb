# TODO: 'due' property, which user sets to the due date
class Task
  @@all_tasks = []

  attr_accessor :description
  attr_reader :created

  def Task.all
    @@all_tasks
  end

  def Task.clear
    @@all_tasks = []
  end

  def initialize(attributes)
    @description = attributes[:description]
    @created = Time.new
  end

  def save
    @@all_tasks.push self
  end
end
