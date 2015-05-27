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

  it 'can calculate the subtotal before tax' do
    order   = Order.create(customer_name: 'Tommy Total')
    cburger = Product.all.where(code: 101)
    tots    = Product.all.where(code: 201)
    soda    = Product.all.where(code: 300)

    order.products << cburger
    order.products << tots
    order.products << soda

    expect(order.subtotal)
      .to(eq cburger[0].price + tots[0].price + soda[0].price)
  end

  it 'can calculate the total sales tax' do
    order   = Order.create(customer_name: 'Tanya Tax')
    cburger = Product.all.where(code: 101)
    tots    = Product.all.where(code: 201)
    soda    = Product.all.where(code: 300)
    tax     = 0

    order.products << cburger
    order.products << tots
    order.products << soda

    tax = (cburger[0].price + tots[0].price + soda[0].price) * Order.tax_rate

    expect(order.tax).to(eq tax)
  end

  it 'can calculate the grand total' do
    order   = Order.create(customer_name: 'Tanya Tax')
    cburger = Product.all.where(code: 101)
    tots    = Product.all.where(code: 201)
    soda    = Product.all.where(code: 300)

    order.products << cburger
    order.products << tots
    order.products << soda

    expect(order.grand_total).to(eq order.subtotal + order.tax)
  end
end
