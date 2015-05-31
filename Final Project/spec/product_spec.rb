require 'spec_helper'

describe Product do
  it 'belongs to many orders' do
    burger     = Product.all.where(code: 100)
    tod_order  = Order.create(customer_name: 'Tod')
    jane_order = Order.create(customer_name: 'Jane')

    burger.orders << tod_order
    burger.orders << jane_order

    expect(burger.orders).to(eq [tod_order, jane_order])
    expect(burger.orders.first['customer_name']).to(eq 'Tod')
    expect(burger.orders.last['customer_name']).to(eq 'Jane')
  end

  it 'can lookup products by code' do
    burger = Product.lookup_code(100)
    tots   = Product.lookup_code(201)
    soda   = Product.lookup_code(300)

    expect(burger[0].name).to(eq 'Burger')
    expect(tots[0].name).to(eq 'Tater Tots')
    expect(soda[0].name).to(eq 'Soda')
  end
end
