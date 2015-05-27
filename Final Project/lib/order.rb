class Order < ActiveRecord::Base
  @@tax_rate = 0.07
  has_and_belongs_to_many :products

  def self.tax_rate
    @@tax_rate
  end

  def self.lookup_id id
    where id: id
  end

  def subtotal

  end

  def tax

  end

  def grand_total

  end
end
