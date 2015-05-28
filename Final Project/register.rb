require 'active_record'
require './lib/order'
require './lib/product'

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
        # food_menu
      when 'x'
        puts "\nGoodbye!"
        exit
      else
        puts "\nSorry, that wasn't a valid option."
    end
  end
end

welcome
