require 'active_record'
require './lib/order'
require './lib/product'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['development']
)


def welcome
  puts "\nWelcome to the Restraunt Register!"
  puts '=================================='
  ui_menu()
end


def ui_menu
  choice = nil

  until choice == 'x'
    puts "\nCOMMANDS"
    puts '--------'
    puts '"A" to Add an order' + "\n"
    puts '"L" to Look up an order by its ID #' + "\n"
    puts '"O" to list all Orders' + "\n" # TODO: "list Open orders?"
    puts '"M" to view the Menu' + "\n"
    # puts '"C" to Checkout an order (mark as paid)' + "\n"
    # puts '"D" to Delete an order' + "\n"
    puts '"X" to eXit.'

    choice = gets.strip.downcase

    case choice
      when 'a'
        create_order()
      when 'l'
        lookup()
      when 'o'
        list_orders()
      when 'm'
        product_list()
      when 'x'
        puts "\nGoodbye!"
      else
        puts "\nSorry, that wasn't a valid option."
    end
  end
end


def create_order
  puts "\nWhat's the customer's name (\"cancel\" to go back)?"
  cust_name = gets.strip

  return nil if cust_name == 'cancel'

  add_food_to_order(Order.new(customer_name: cust_name))
end


def add_food_to_order(order)
  loop do
    food = nil

    puts "\nAdd a food to the order by entering its ID #"
    puts '("cancel" to go back, "menu" to view menu, "done" to finish & save):'
    choice = gets.strip.downcase

    case choice
      when 'cancel'
        return nil
      when 'menu'
        product_list()
      when 'done'
        if order.products.length == 0
          puts "\nSorry, but I can't save an order with nothing in it."
          puts 'Did you mean "cancel"?' + "\n"
        else
          order.save
          puts "\nOrder #{order.id} for #{order.customer_name} saved. TOTAL: " + format_money(order.grand_total)
          return order
        end
      else
        food = Product.all.where(code: choice.to_i)
        if food[0]
          order.products << food
          puts "#{food[0].name} (" + format_money(food[0].price) + ') added!'
        else
          puts "\nSorry, that wasn't a valid option."
        end
    end
  end
end


def lookup
  order = nil
  choice = nil

  until choice == 'cancel'
    puts "\nEnter the ID of the order you want to view:"
    puts '("cancel" to go back, "list" for all orders)'
    choice = gets.strip.downcase

    if choice == 'list'
      list_orders()
    elsif choice != 'cancel'
      order = Order.all.where(id: choice.to_i)
      if order[0]
        product_list(order)
        break
      else
        puts "\nSorry, that wasn't a valid option."
      end
    end
  end

  order
end


def list_orders
  orders = Order.all

  if orders.length == 0
    puts "\nNo orders found."
    return false
  end

  puts "\nOrder List"
  puts '----------'
  orders.each do |order|
    puts "ID \##{order.id}: " + format_money(order.grand_total) + " for #{order.customer_name}"
  end
end


def product_list(order=[])
  order = (order.length > 0) ? order : nil
  products = (order == nil) ? Product.all : order[0].products
  title = (order == nil) ? 'Menu' : "Order #{order[0].id} for #{order[0].customer_name} (TOTAL: " + format_money(order[0].grand_total) + ')'
  horiz_divider = '+------+--------------+--------+'

  puts "\n#{title}"
  puts '-' * title.length
  puts horiz_divider
  puts '| Code | Item         | Price  |'
  puts horiz_divider

  products.each do |product|
    code   = product.code.to_s + table_cell_space(product.code, 6)
    name   = product.name + table_cell_space(product.name, 14)
    price  = format_money(product.price)
    price += table_cell_space(price, 8)

    puts "| #{code}| #{name}| #{price}|"
  end

  puts horiz_divider
end


def format_money(amount)
  '$' + sprintf('%.2f', (amount / 100.00).round(2).to_s)
end


# returns space to put at the end of menu content to fill its "cell"
def table_cell_space(content, cell_width)
  # NOTE: subtracts 1 for space at start of cell
  ' ' * (cell_width - content.to_s.length - 1)
end

welcome()
