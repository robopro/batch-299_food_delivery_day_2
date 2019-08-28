class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def run
    while @running
      @employee = @sessions_controller.login
      while @employee
        if @employee.manager?
          display_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route_manager_action(choice)
        else
          display_delivery_guy_menu
          choice = gets.chomp.to_i
          print `clear`
          route_delivery_guy_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customer"
    puts "4 - Add a customer"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def display_delivery_guy_menu
    puts "------------------------------"
    puts "-------- DELIVERY GUY --------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all my undelivered order"
    puts "2 - Mark an order as delivered"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 8 then @employee = nil
    when 9 then stop
    else
      puts "Try again..."
    end
  end

  def route_delivery_guy_action(choice)
    case choice
    when 1 then puts "TODO: List all my undelivered orders."
    when 2 then puts "TODO: Mark an order as delivered"
    when 8 then @employee = nil
    when 9 then stop
    else
      puts "Try again..."
    end
  end

  def stop
    @employee = nil
    @running = false
  end
end
