require 'rspec'
require 'pg'
require 'dotenv'
require 'task'

# setup the environment
Dotenv.load!('./spec/.env.test')
unless ENV.has_key?('PG_DATABASE') && ENV.has_key?('PG_USERNAME') && ENV.has_key?('PG_PASSWORD')
  puts 'Missing one or more of these environment variables:'
  puts 'PG_DATABASE, PG_USERNAME, PG_PASSWORD'
  exit
end

# NOTE: because first letter is capitalized, Ruby treats this as a constant
DB = PG.connect({:dbname => ENV['PG_DATABASE'], :user => ENV['PG_USERNAME'], :password => ENV['PG_PASSWORD']})


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *")
  end
end

describe Task do
  it 'is initialized with a name' do
    task = Task.new('learn SQL')
    expect(task).to(be_an_instance_of Task)
  end

  it 'tells you its name' do
    task = Task.new('learn SQL')
    expect(task.name).to(eq 'learn SQL')
  end

  it 'starts with no tasks' do
    expect(Task.all).to(eq [])
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new('learn SQL')
    task2 = Task.new('learn SQL')
    expect(task1).to(eq task2)
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL')
    task.save
    expect(Task.all).to(eq [task])
  end
end
