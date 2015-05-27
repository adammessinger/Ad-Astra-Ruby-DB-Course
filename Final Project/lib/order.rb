class Order < ActiveRecord::Base
  has_and_belongs_to_many :products
  @@tax_rate = 0.07

  def self.tax_rate
    @@tax_rate
  end

  def self.lookup_id id
    where id: id
  end

  def subtotal
    sub_total = 0

    self.products.each { |product| sub_total += product.price }
    sub_total
  end

  def tax
    self.subtotal * @@tax_rate
  end

  def grand_total
    sub_total = self.subtotal

    sub_total + (sub_total * @@tax_rate)
  end
end
