require 'active_record'
require 'rspec'
require 'order'
require 'product'

# connect to DB
ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['test']
)

# clean up after each test
RSpec.configure do |config|
  config.after(:each) do
    Order.all.each {|order| order.destroy}
  end
end
