class Product < ActiveRecord::Base
  has_and_belongs_to_many(:orders)

  def self.lookup_code(code)
    where(code: code)
  end
end
