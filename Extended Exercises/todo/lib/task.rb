# TODO: 'due' property, which user sets to the due date
class Task
  def initialize(description)
    @description = description
    @created = Time.new
  end

  def description
    @description
  end

  def created
    @created
  end
end
