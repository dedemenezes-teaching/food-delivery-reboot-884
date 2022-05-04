class SessionView
  def ask_for(item)
    puts "#{item.capitalize}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials...Try again"
  end

  def logged_in_successfully
    puts "YOU ARE LOGGED IN"
  end
end
