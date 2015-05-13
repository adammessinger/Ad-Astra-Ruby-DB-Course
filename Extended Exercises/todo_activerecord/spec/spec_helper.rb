require 'active_record'
require 'dotenv'
require 'rspec'
require 'task'

# setup the environment
Dotenv.load!('./spec/.env.test')
unless ENV.has_key?('PG_USERNAME') && ENV.has_key?('PG_PASSWORD')
  puts 'Missing one or more of these environment variables: PG_USERNAME, PG_PASSWORD'
  exit
end

# connect to DB
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'].merge({
  :username => ENV['PG_USERNAME'],
  :password => ENV['PG_PASSWORD']
}))

# clean up after each test
RSpec.configure do |config|
  config.after(:each) do
    Task.all.each {|task| task.destroy}
  end
end
