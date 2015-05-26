require 'spec_helper'

describe Order do
  it 'has many products' do
    order  = Order.create(customer_name: 'Janet')
    burger = Product.all.where(code: 100)
    fries  = Product.all.where(code: 200)
    soda   = Product.all.where(code: 300)

    order.products << burger
    order.products << fries
    order.products << soda

    expect(order.products.to_a).to(eq [burger[0], fries[0], soda[0]])
  end
end
