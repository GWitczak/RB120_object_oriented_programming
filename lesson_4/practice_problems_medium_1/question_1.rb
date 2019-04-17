# Ben asked Alyssa to code review the following code.
# Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the @ before balance 
# when you refer to the balance instance variable in the body of the positive_balance? method."
# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"
# Who is right, Ben or Alyssa, and why?

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben is right because he used attr_reader on line 8 to add getter method for balance instance variable
# So on line 15 balance method is called and returns value of balance instance variable