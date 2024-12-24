# Simple List Manager in Ruby

# Initialize the lists
lists = {}

def show_main_menu
  puts "\nList Manager:"
  puts "1. Create a new list"
  puts "2. View existing lists"
  puts "3. Select a list to manage"
  puts "4. Delete a list"
  puts "5. Exit"
  print "Choose an option: "
end

def show_list_menu(list_name)
  puts "\nManaging List: #{list_name}"
  puts "1. Add a new task"
  puts "2. View tasks"
  puts "3. Mark a task as completed"
  puts "4. Delete a task"
  puts "5. Go back to main menu"
  print "Choose an option: "
end

def manage_list(lists, list_name)
  loop do
    show_list_menu(list_name)
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter the task: "
      task = gets.chomp
      lists[list_name] << { name: task, completed: false }
      puts "Task added successfully!"

    when 2
      puts "\nYour Tasks in '#{list_name}':"
      if lists[list_name].empty?
        puts "No tasks found."
      else
        lists[list_name].each_with_index do |task, index|
          status = task[:completed] ? "[X]" : "[ ]"
          puts "#{index + 1}. #{status} #{task[:name]}"
        end
      end

    when 3
      print "Enter the task number to mark as completed: "
      task_number = gets.chomp.to_i
      if task_number.between?(1, lists[list_name].length)
        lists[list_name][task_number - 1][:completed] = true
        puts "Task marked as completed!"
      else
        puts "Invalid task number."
      end

    when 4
      print "Enter the task number to delete: "
      task_number = gets.chomp.to_i
      if task_number.between?(1, lists[list_name].length)
        lists[list_name].delete_at(task_number - 1)
        puts "Task deleted successfully!"
      else
        puts "Invalid task number."
      end

    when 5
      puts "Returning to main menu..."
      break

    else
      puts "Invalid choice. Please try again."
    end
  end
end

# Main program loop
loop do
  show_main_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Enter the name of the new list: "
    list_name = gets.chomp
    if lists.key?(list_name)
      puts "A list with this name already exists."
    else
      lists[list_name] = []
      puts "List '#{list_name}' created successfully!"
    end

  when 2
    puts "\nExisting Lists:"
    if lists.empty?
      puts "No lists found."
    else
      lists.keys.each_with_index do |list_name, index|
        puts "#{index + 1}. #{list_name}"
      end
    end

  when 3
    print "Enter the name of the list to manage: "
    list_name = gets.chomp
    if lists.key?(list_name)
      manage_list(lists, list_name)
    else
      puts "List '#{list_name}' does not exist."
    end

  when 4
    print "Enter the name of the list to delete: "
    list_name = gets.chomp
    if lists.key?(list_name)
      lists.delete(list_name)
      puts "List '#{list_name}' deleted successfully!"
    else
      puts "List '#{list_name}' does not exist."
    end

  when 5
    puts "Exiting List Manager. Goodbye!"
    break

  else
    puts "Invalid choice. Please try again."
  end
end
