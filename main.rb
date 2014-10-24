# Customer Relation Manager App #
# ============================= #

def print_main_menu
  puts "[1] Add a new contact"
  puts "[2] Modify an existing contact"
  puts "[3] Delete a contact"
  puts "[4] Display contact"
  puts "[5] Display all the contacts"
  puts "[6] Display an attribute"
  puts "[7] Exit"
  puts
  puts "Enter a number: "
end

def main_menu
  puts "What would you like to do?"
  puts
  print_main_menu
  user_selected = gets.chomp.to_i
  puts "\e[H\e[2J"
  call_option(user_selected)
end

def call_option(user_selected)
	case user_selected
	when 1 then add__new_contact
	when 2 then modify_contact
	when 3 then delete_contact
	when 4 then display_contact
	when 5 then display_all_contacts
	when 6 then display_by_attribute
	when 7 then puts "Thank you for using Rolodex!"; return
	else puts "Invalid entry, try again"; puts; main_menu
	end
end

puts "\e[H\e[2J"
main_menu
