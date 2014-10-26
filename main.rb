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
	  puts "[4] Display contact (by ID)"
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
		when 4 then puts "Enter ID:"; display_contact(gets.chomp.to_i)
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
		this_contact = ""
		contact_to_mod = 0
		loop do	
			display_all_contacts
			puts "Which contact do you wish to modify? Enter user ID:"
			contact_to_mod = gets.chomp.to_i
			this_contact = you_have_selected(contact_to_mod)
			puts "\e[H\e[2J"
			puts "You have selected #{this_contact.first_name} #{this_contact.last_name}"
			puts
			puts "Confirm selection? (y/n)"
			y_or_no = gets.chomp
			break if y_or_no == "y"
		end		
		modify_contact_menu
		at_to_mod = gets.chomp.to_i
		puts "\e[H\e[2J"
		out = ["first_name", "last_name", "email", "note"]
		at_to_mod = out[at_to_mod.to_i - 1]
		puts "Enter new value:"
		new_val = gets.chomp
		this_contact.send("#{at_to_mod}=", new_val)
		puts "\e[H\e[2J"
		puts "Value succesfully changed."
		puts
		display_contact(contact_to_mod)	
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
		del_contact = ""
		loop do	
			display_all_contacts
			puts "Which contact do you wish to delete? Enter user ID:"
			contact_to_del = gets.chomp.to_i
			del_contact = you_have_selected(contact_to_del)
			puts "\e[H\e[2J"
			puts "You have selected #{del_contact.first_name} #{del_contact.last_name}"
			puts
			puts "Confirm selection? (y/n)"
			y_or_no = gets.chomp
			break if y_or_no == "y"
		end	
		@rolodex.contacts.delete(del_contact)
		puts "Contact removed successfully."
	end

	# USER_SELECTED = 4
	def display_contact(user_id)
		puts
		@rolodex.contacts.each do |contact|
			if contact.id == user_id
				puts "Contact Name: #{contact.first_name} #{contact.last_name}"
				puts "Email: #{contact.email}"
				puts "Notes: #{contact.note}"
				puts "User ID: #{contact.id}"
				puts
			end
		end
	end

	# USER_SELECTED = 6
	def display_by_attribute
		display_by_attr_menu
		sort_attr = gets.chomp.to_i
		case sort_attr
		when 1 
			@rolodex.contacts.sort {
				|contact1, contact2| contact1.first_name <=> contact2.first_name
				}.each{|contact|  display_contact(contact.id)}
		# when 2 then
		# when 3 then
		# when 4 then 
		# when 5 then
		end
	end

	def display_by_attr_menu
		puts "\e[H\e[2J"
		puts "Sort contacts by:"
		puts "[1] First Name"
		puts "[2] Last Name"
		puts "[3] Email"
		puts "[4] Note"
		puts "[5] User ID"
	end


	def self.run
		puts "\e[H\e[2J"
		crm = CRM.new("Our CRM")
		crm.main_menu
	end
end




CRM.run

