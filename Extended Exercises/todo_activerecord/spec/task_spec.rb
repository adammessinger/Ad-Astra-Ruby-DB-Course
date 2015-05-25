require 'spec_helper'

describe Task do
  it 'belongs to a list' do
    list = List.create({:name => 'list'})
    task = Task.create({:name => 'task', :list_id => list.id})

    expect(task.list).to(eq list)
  end

  it 'can return the not done tasks' do
    list = List.create({:name => 'Not done test list'})
    not_done_tasks = (1..5).to_a.map { |number|
      list.tasks.new({:name => "task #{number}", :done => false})
    }
    done_task = list.tasks.new({:name => "done task", :done => true})
    list.save

    expect(Task.not_done).to(eq not_done_tasks)
  end
end
