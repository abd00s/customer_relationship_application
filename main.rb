# Customer Relation Manager App #
# ============================= #

require_relative './contact.rb'
require_relative './rolodex.rb'

class CRM
	attr_reader :name 

	def initialize(name)
		@name = name
		@rolodex = Rolodex.new
	end

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
		loop do
			puts "What would you like to do?"
			puts
			print_main_menu
			user_selected = gets.chomp.to_i
			puts "\e[H\e[2J"
			if user_selected == 7 
				puts "Thank you for using Rolodex!"
				break 
			end 
			call_option(user_selected)
		end
	end

	def call_option(user_selected)
		case user_selected
		when 1 then add_new_contact
		when 2 then modify_contact
		when 3 then delete_contact
		when 4 then display_contact
		when 5 then display_all_contacts
		when 6 then display_by_attribute
		when 7 then puts "Thank you for using Rolodex!"; return
		else puts "Invalid entry, try again"; puts; main_menu
		end
	end

	# USER_SELECTED = 1

	def add_new_contact
		print "Enter First Name: "
		first_name = gets.chomp
		print "Enter Last Name: "
		last_name = gets.chomp
		print "Enter Email Address: "
		email = gets.chomp
		print "Enter a Note: "
		note = gets.chomp 
		@rolodex.add_contact(Contact.new(first_name, last_name, email, note))
	end

	# USER_SELECTED = 5

	def display_all_contacts	
		@rolodex.contacts.each do |contact|
			puts "Contact Name: #{contact.first_name} #{contact.last_name}"
			puts "Email: #{contact.email}"
			puts "Notes: #{contact.note}"
			puts "User ID: #{contact.id}"
			puts
		end
	end

	# USER_SELECTED = 2

	def modify_contact
		loop do	
			display_all_contacts
			puts "Which contact do you wish to modify? Enter user ID:"
			contact_to_mod = gets.chomp.to_i
			this_contact = you_have_selected(contact_to_mod)
			puts "\e[H\e[2J"
			puts "You have selected #{this_contact.first_name} #{this_contact.last_name}"
			puts "Confirm selection? (y/n)"
			y_or_no = gets.chomp
			break if y_or_no == "y"
		end		
		modify_contact_menu
		at_to_mod = gets.chomp.to_i
		puts "\e[H\e[2J"
		puts "you have selected #{at_to_mod}"
	end 

	def you_have_selected(id)
		@rolodex.contacts.each {|contact| return contact if contact.id == id}

	end


	def modify_contact_menu
		puts "\e[H\e[2J"
		puts "What attribute do you wish to modify?"
		puts "[1] First Name"
		puts "[2] Last Name"
		puts "[3] E-mail"
		puts "[4] Note"
	end

	# USER_SELECTED = 3
	def delete_contact

	end

	# USER_SELECTED = 4
	def display_contact
		
	end

	# USER_SELECTED = 6
	def display_contact_by_attr

	end

	# def selector
	# 	puts "Identify by First Name [1], Last Name [2] or User ID [3] "
	# 	puts "Enter number choice:"
	# 	number = gets.chomp.to_i
	# 	if number == 1
	# 		puts "Which user?"
	# 		inp = gets.chomp
	# 		@rolodex.contacts.each do |contact|
	# 			if inp == contact.first_name
	# 				return contact
	# 			end
	# 		end
	# 	elsif number == 2
	# 		puts "were searching by ln"
	# 	elsif number == 3
	# 		puts "were searching by id"
	# 	else
	# 		puts "Invalid Input"
	# 	end
	# end

	def self.run
		puts "\e[H\e[2J"
		crm = CRM.new("Our CRM")
		crm.main_menu
	end
end




CRM.run

