# Customer Relation Manager App #
# ============================= #

require_relative './contact.rb'
require_relative './rolodex.rb'

class CRM
	attr_reader :name 

	def initialize(name)				                 # Initiate a rolodex to store all contacts
		@name = name
		@rolodex = Rolodex.new
	end

	def print_main_menu									# Display main menu to user
	  puts "[1] Add a new contact"
	  puts "[2] Modify an existing contact"
	  puts "[3] Delete a contact"
	  puts "[4] Display contact (by ID)"
	  puts "[5] Display all the contacts"
	  puts "[6] Display by attribute"
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
			if user_selected == 7 						# Terminate loop when 7 [exit] is selected
				puts "Thank you for using Rolodex!"
				break 
			end 
			call_option(user_selected)					# Invoke the call method with the user input [1-7] as the argument 
		end
	end

	def call_option(user_selected)						# Invoke the respective methods based on user input
		case user_selected
		when 1 then add_new_contact
		when 2 then modify_contact
		when 3 then delete_contact
		when 4 then puts "Enter ID:"; display_contact(gets.chomp.to_i) # Needs an argument because display_contact expects one to be passed
		when 5 then display_all_contacts
		when 6 then display_by_attribute
		when 7 then puts "Thank you for using Rolodex!"; return
		else puts "Invalid entry, try again"; puts; main_menu 		# Message if user does not select 1-7
		end
	end

	# USER_SELECTED = 1

	def add_new_contact
		print "Enter First Name: "
		first_name = gets.chomp.capitalize
		print "Enter Last Name: "
		last_name = gets.chomp.capitalize
		print "Enter Email Address: "
		email = gets.chomp
		print "Enter a Note: "
		note = gets.chomp 														# Create an instance of Contact using user input as arguments
		@rolodex.add_contact(Contact.new(first_name, last_name, email, note))   # Store Contact in @contacts array in @rolodex
	end

	# USER_SELECTED = 2

	def modify_contact
		this_contact = ""		# There must be a different way to do this; don't know how yet
		contact_to_mod = 0		# Defining this_contact and contact_to_mod outside the below loop, to be able to access here |
		loop do																												#|
			display_all_contacts		# Show user all contacts so the know what id to enter								#|
			puts "Which contact do you wish to modify? Enter user ID:"														#|
			contact_to_mod = gets.chomp.to_i																				#|
			this_contact = you_have_selected(contact_to_mod)	# Holds Contact												#|
			puts "\e[H\e[2J"																								#|
			puts "You have selected #{this_contact.first_name} #{this_contact.last_name}"									#|
			puts																											#|
			puts "Confirm selection? (y/n)"																					#|
			y_or_no = gets.chomp																							#|
			break if y_or_no == "y"																							#|
		end																													#|
		modify_contact_menu				#Prints options																		#|
		at_to_mod = gets.chomp.to_i																							#|
		puts "\e[H\e[2J"																									#|
		out = ["first_name", "last_name", "email", "note"]		# Two lines; translate numeric input						#|
		at_to_mod = out[at_to_mod.to_i - 1]						# into strings with same name as variables					#|
		puts "Enter new value:"								    # holding our contact attributes							#|
		new_val = gets.chomp																								#|
		this_contact.send("#{at_to_mod}=", new_val)		# some magic! read a lot, now forgot!			#<===================|
		puts "\e[H\e[2J"																									#|
		puts "Value succesfully changed."																					#|
		puts																												#|
		display_contact(contact_to_mod)		# display contact after modification						#<===================|
	end 

	# USER_SELECTED = 3

	def delete_contact
		del_contact = ""  # Same scope issue; want to use variable outside below loop
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
		@rolodex.contacts.delete(del_contact)			# Contact instance removed from the @contacts array in @rolodex
		puts "\e[H\e[2J"
		puts "Contact removed successfully."
		puts
	end

	def you_have_selected(id)								                    # Returns instance of contact matching user selection; used for deletion and modification
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

	# USER_SELECTED = 4

	def display_contact(user_id)
		puts
		@rolodex.contacts.each do |contact|				# Iterate over @contacts array and display details
			if contact.id == user_id
				puts "Contact Name: #{contact.first_name} #{contact.last_name}"
				puts "Email: #{contact.email}"
				puts "Notes: #{contact.note}"
				puts "User ID: #{contact.id}"
				puts
			end
		end
	end

	# USER_SELECTED = 5

	def display_all_contacts													# Iterate over @contacts array in @rolodex 
		@rolodex.contacts.each do |contact|
			puts "Contact Name: #{contact.first_name} #{contact.last_name}"
			puts "Email: #{contact.email}"
			puts "Notes: #{contact.note}"
			puts "User ID: #{contact.id}"
			puts
		end
	end

	# USER_SELECTED = 6

	def display_by_attribute
		display_by_attr_menu							# Prints the menu of possible sort parameters
		sort_attr = gets.chomp.to_i
		case sort_attr
		when 1 
			@rolodex.contacts.sort {   												# First sort @contacts array based on user selection
				|contact1, contact2| contact1.first_name <=> contact2.first_name    # Specify that sort should be done on first_name [1] parameter 
				}.each{|contact|  display_contact(contact.id)}						# Iterate on sorted array and print results
		when 2 
					@rolodex.contacts.sort {
				|contact1, contact2| contact1.last_name <=> contact2.last_name
				}.each{|contact|  display_contact(contact.id)}
		when 3 
					@rolodex.contacts.sort {
				|contact1, contact2| contact1.email <=> contact2.email
				}.each{|contact|  display_contact(contact.id)}
		when 4  
 					@rolodex.contacts.sort {
				|contact1, contact2| contact1.note <=> contact2.note
				}.each{|contact|  display_contact(contact.id)}
 		when 5 
		 					@rolodex.contacts.sort {
				|contact1, contact2| contact1.id <=> contact2.id
				}.each{|contact|  display_contact(contact.id)}
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


	def self.run   							# Class method to get our system running
		puts "\e[H\e[2J"
		crm = CRM.new("Our CRM")			# Instantiate a new CRM called Our Crm
		crm.main_menu   					# Invoke main_menu method which starts the sequence.
	end
end




CRM.run 									# Calling our class method [self.run]

