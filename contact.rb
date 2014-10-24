class Contact
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    puts "\e[H\e[2J"
    puts "Contact succesffully added."
  end
end