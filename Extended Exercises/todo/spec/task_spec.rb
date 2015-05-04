require 'rspec'
require 'task'

describe Task do
  before do
    Task.clear
  end

  it 'is initialized with a hash of attributes' do
    test_task = Task.new({:description => 'learn Ruby'})

    expect(test_task).to(be_an_instance_of Task)
    expect(test_task.description).to(eq 'learn Ruby')
  end

  it 'is initialized with a created time' do
    test_task = Task.new({:description => 'foo'})

    expect(test_task.created).to(be_an_instance_of Time)
  end

  it "can change a task's description after it is created" do
    test_task = Task.new({:description => 'foo'})

    test_task.description = 'bar'
    expect(test_task.description).to(eq 'bar')
  end

  describe '.all' do
    it 'is empty at first' do
      expect(Task.all).to(eq [])
    end
  end

  describe '.clear' do
    it 'deletes all the saved tasks' do
      Task.new({:description => 'foo'}).save
      Task.clear
      expect(Task.all).to(eq [])
    end
  end

  describe '.delete' do
    it 'deletes the task at the passed array index' do
      Task.new({:description => 'qux'}).save
      Task.delete(0)
      expect(Task.all).to(eq [])
    end
  end

  describe '#save' do
    it 'adds a task to the array of saved tasks' do
      test_task = Task.new({:description => 'wash the lion'})

      test_task.save
      expect(Task.all).to(eq [test_task])
    end
  end
end
