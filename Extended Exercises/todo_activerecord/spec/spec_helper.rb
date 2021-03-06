require 'active_record'
require 'rspec'
require 'task'
require 'list'

# connect to DB
ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['test']
)

# clean up after each test
RSpec.configure do |config|
  config.after(:each) do
    Task.all.each {|task| task.destroy}
    List.all.each {|list| list.destroy}
  end
end
