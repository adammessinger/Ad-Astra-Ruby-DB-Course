require 'active_record'
require './lib/order'
require './lib/product'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('./db/database.yaml'))['development']
)

def welcome
  puts "\nWelcome to the Restraunt Register!"
  puts '=================================='
  ui_menu
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
        # add
      when 'l'
        # lookup
      when 'o'
        # list_orders
      when 'm'
        food_menu
      when 'x'
        puts "\nGoodbye!"
      else
        puts "\nSorry, that wasn't a valid option."
    end
  end
end

# TODO: fix inability to run menu command again until another command is used
def food_menu
  horiz_divider = '+------+--------------+--------+'

  puts "\n" + horiz_divider
  puts '| Code | Item         | Price  |'
  puts horiz_divider

  Product.all.each do |product|
    code   = product.code.to_s + table_cell_space(product.code, 6)
    name   = product.name + table_cell_space(product.name, 14)
    price  = '$' + (product.price / 100.00).to_s
    price += table_cell_space(price, 8)

    puts "| #{code}| #{name}| #{price}|"
  end

  puts horiz_divider
end

# returns space to put at the end of menu content to fill its "cell"
def table_cell_space(content, cell_width)
  # NOTE: subtracts 1 for space at start of cell
  ' ' * (cell_width - content.to_s.length - 1)
end

welcome
