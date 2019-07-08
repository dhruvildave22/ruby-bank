
class Account
  attr_accessor :name, :balance
  attr_reader :account_number, :password

  def initialize(name, balance, account_number, password)
    @name = name
    @balance = balance
    @account_number = account_number
    @password = password
  end
  

  def deposit(amount)
    @balance += amount
  end

  def withdrawal(amount)
    if amount > @balance
      puts "Account balance of #{@balance} insufficient for requested amount of #{amount}. Try again."
    else
      @balance -= amount
      puts "You withdrawal of #{amount} has been completed.  Your new balance is #{@balance}" 
    end 
  end 
end   


def main_menu

  puts "Welcome to Dhruvil Bank."
  puts "Please make a selection:"
  puts "-----------------------------"
  puts "1. Create an account"
  puts "2. View account information"
  puts "3. Exit System"

  option = gets.chomp.to_i


  if option == 1
    create_account
    main_menu
  elsif option == 2
    view_account
  elsif option == 3
    puts "Thank you for banking with us!"
    exit
  else

    @login_tries +=1
    if @login_tries < 3
      puts "Not a valid option.  Please try again." 
      main_menu
    else
      puts "Looks like you are having trouble.  Contact System Administrator for help." 
      exit
    end 
  end   
end

def create_account
  print "Enter your name: "
  user_name = gets.chomp.upcase
  print "Enter a password: "
  user_password = gets.chomp
  print "Confirm password: "
  confirm = gets.chomp
  if user_password != confirm
    puts "Passwords do not match"
    create_account
  else
    print "Please enter a starting balance: " 
    user_balance = gets.chomp.to_f

    user_account = @accounts.length 
    account = Account.new(user_name,user_balance,user_account, user_password) 
    @accounts.push(account)
    puts "Your account has been created: "
    puts "User: #{user_name}"
    puts "Starting Balance: #{user_balance}"
    puts "Account Number: #{user_account}"
  end   
end




def view_account

  @account_login +=1

  while @account_login < 4
    print "Please enter the name on the account: "
    name = gets.chomp.upcase
    print "Please enter the account number: "
    acc_num = gets.chomp.to_i
    print "Please enter your password: "
    password = gets.chomp

    if account_login(name, acc_num, password)
      @account_login = 0
      view_account_menu(name, acc_num, password)
    else
      puts "Invalid creditials, please try again. Attempt: #{@account_login}" 
      view_account
    end 
  end

  if @account_login >3
    puts "Looks like you are having trouble. Please contact the Administrator."
    @account_login = 0
    main_menu
  end 

end


def account_login(name, account_number, password)
  check = false
  @accounts.each do |account|
    
    if account.name == name && account.account_number == account_number && account.password == password
      check = true
    end 
  end   
  return check
end


def view_account_menu(name, acc_num, password)
  puts "Welcome to the Account Menu. Please "
  puts "make a selection: "
  puts "------------------------------------"
  puts "1. View Account Balance"
  puts "2. Make a Deposit"
  puts "3. Make a withdrawal"
  puts "4. Return to Main Menu"


  option = gets.chomp.to_i

  if option == 1
    view_balance(name, acc_num, password)
    view_account_menu(name, acc_num, password) 
  elsif option == 2
    make_deposit(name, acc_num, password)
    view_account_menu(name, acc_num, password) 
  elsif option == 3
    make_withdrawal(name, acc_num, password)
    view_account_menu(name, acc_num, password) 
  elsif option == 4
    main_menu
  else
    puts "Not a valid selection. Try again"
    view_account_menu(name, acc_num, password)       
  end 

end 

def view_balance(name, acc_num, password)
  
  @accounts.each do |account|
    
    if account.name == name && account.account_number == acc_num && account.password == password
      puts "Your current balance is #{account.balance}."
    end 
  end   

end 


def make_deposit(name, acc_num, password)
  puts "How much do you want to deposit?"
  deposit_amount = gets.chomp.to_f
 @accounts.each do |account|
    
    if account.name == name && account.account_number == acc_num && account.password == password
        prev_balance = account.balance
        account.deposit(deposit_amount)
        puts "Your deposit of #{deposit_amount} has been made. Your previous was #{prev_balance}. Your new balance is #{account.balance}."  

    end 
  end   
end 

def make_withdrawal(name, acc_num, password)
  puts "How much do you want to withdrawal?"
  withdrawal_amount = gets.chomp.to_f
  @accounts.each do |account|
    
    if account.name == name && account.account_number == acc_num && account.password == password
        prev_balance = account.balance
        account.withdrawal(withdrawal_amount)
    end   

  end 
end 


@accounts = []

@account_login = 0
@login_tries = 0

main_menu