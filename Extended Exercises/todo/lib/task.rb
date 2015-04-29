# TODO: 'due' property, which user sets to the due date
class Task
  @@all_tasks = []

  def Task.all
    @@all_tasks
  end

  def Task.clear
    @@all_tasks = []
  end

  def initialize(description)
    @description = description
    @created = Time.new
  end

  def save
    @@all_tasks.push self
  end

  def description
    @description
  end

  def created
    @created
  end
end
