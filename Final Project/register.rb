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
    puts '"O" to list all Orders' + "\n"
    puts '"M" to view the Menu' + "\n"
    # puts '"C" to Checkout an order (mark as paid)' + "\n"
    # puts '"D" to Delete an order' + "\n"
    puts '"X" to eXit.'

    choice = gets.strip.downcase

    case choice
      when 'a'
        create_order()
      when 'l'
        # lookup
      when 'o'
        # list_orders
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
  product_list()
  puts "\nWhat's the customer's name (\"cancel\" to go back)?"
  cust_name = gets.strip

  if cust_name == 'cancel'
    return false
  end

  add_food_to_order(Order.new(customer_name: cust_name))
end


def add_food_to_order(order)
  loop do
    puts 'Add a food to the order by entering its ID #'
    puts '("cancel" to go back, "menu" to view menu, "done" to finish & save):'
    choice = gets.strip.downcase

    case choice
      when 'cancel'
        return false
      when 'menu'
        product_list()
      when 'done'
        order.save
        puts "Order #{order.id} for #{order.customer_name}. TOTAL: " + format_money(order.grand_total)
        return order
      else
        if food = Product.all.where(code: choice.to_i)
          order.products << food
          puts "#{food.name} (" + format_money(food.price) + ') added!'
        else
          puts "\nSorry, that wasn't a valid option."
        end
    end
  end
end


def product_list
  # TODO: fix inability to run menu command again until another command is used
  horiz_divider = '+------+--------------+--------+'

  puts "\nMenu"
  puts '----'
  puts horiz_divider
  puts '| Code | Item         | Price  |'
  puts horiz_divider

  Product.all.each do |product|
    code   = product.code.to_s + table_cell_space(product.code, 6)
    name   = product.name + table_cell_space(product.name, 14)
    price  = format_money(product.price)
    price += table_cell_space(price, 8)

    puts "| #{code}| #{name}| #{price}|"
  end

  puts horiz_divider
end


def format_money(amount)
  '$' + (amount / 100.00).to_s
end


# returns space to put at the end of menu content to fill its "cell"
def table_cell_space(content, cell_width)
  # NOTE: subtracts 1 for space at start of cell
  ' ' * (cell_width - content.to_s.length - 1)
end

welcome()
