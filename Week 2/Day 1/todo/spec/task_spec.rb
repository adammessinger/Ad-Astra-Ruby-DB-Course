require 'rspec'
require 'task'

describe Task do
  it 'is initialized with a description' do
    test_task = Task.new('learn Ruby')

    expect(test_task).to(be_an_instance_of Task)
    expect(test_task.description).to(eq 'learn Ruby')
  end

  it 'is initialized with a created time' do
    test_task = Task.new('foo')

    expect(test_task.created).to(be_an_instance_of Time)
  end
end
