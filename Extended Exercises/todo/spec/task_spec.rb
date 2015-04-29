require 'rspec'
require 'task'

describe Task do
  before do
    Task.clear
  end

  it 'is initialized with a description' do
    test_task = Task.new('learn Ruby')

    expect(test_task).to(be_an_instance_of Task)
    expect(test_task.description).to(eq 'learn Ruby')
  end

  it 'is initialized with a created time' do
    test_task = Task.new('foo')

    expect(test_task.created).to(be_an_instance_of Time)
  end

  describe '.all' do
    it 'is empty at first' do
      expect(Task.all).to(eq [])
    end
  end

  describe '#save' do
    it 'adds a task to the array of saved tasks' do
      test_task = Task.new('wash the lion')

      test_task.save
      expect(Task.all).to(eq [test_task])
    end
  end

  describe '.clear' do
    it 'deletes all the saved tasks' do
      Task.new('foo').save
      Task.clear
      expect(Task.all).to(eq [])
    end
  end
end
