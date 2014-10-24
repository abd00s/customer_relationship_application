# Customer Relation Manager App #
# ============================= #

require_relative './contact.rb'

class CRM
	attr_reader :name 

	def initialize(name)
		@name = name
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
		puts "What would you like to do?"
		puts
		print_main_menu
		user_selected = gets.chomp.to_i
		puts "\e[H\e[2J"
		call_option(user_selected)
		return if user_selected == 7
		self.main_menu
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

	def add_new_contact
		print "Enter First Name: "
		first_name = gets.chomp
		print "Enter Last Name: "
		last_name = gets.chomp
		print "Enter Email Address: "
		email = gets.chomp
		print "Enter a Note: "
		note = gets.chomp
		contact = Contact.new(first_name, last_name, email, note)
	end
end

puts "\e[H\e[2J"
crm = CRM.new("Our CRM")
crm.main_menu
