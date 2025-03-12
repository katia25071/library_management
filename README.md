# README

Command Pattern - Simple Guide

What is the Command Pattern?
The Command Pattern is a design pattern that converts a request or action into a standalone object. This object contains all the information needed to perform the action.
Key Elements
1.	Command: An object that encapsulates an action and its parameters
2.	Invoker: Asks the command to carry out the request
3.	Receiver: Knows how to perform the operations

How We Implemented It
In our library management system, we implemented the Command Pattern with:
# Base Command class
class Command
  # Class method to create and execute a command
  def self.execute(*args)
    new(*args).execute
  end

  # Must be implemented by subclasses
  def execute
    raise NotImplementedError
  end

  # Helper methods for consistent results
  def success(data = {})
    { success: true }.merge(data)
  end

  def failure(errors = [])
    { success: false, errors: Array(errors) }
  end
end

Each specific action is a separate command class: 
Example: create loan action 
module Loans
  class CreateCommand < Command
    def initialize(params)
      @params = params
    end

    def execute
      loan = Loan.new(@params)
      if loan.save
        success(loan: loan)
      else
        failure(loan.errors.full_messages)
      end
    end
  end
end


How It's Used?
In controllers (invokers), we use commands like this:
def create
  result = Loans::CreateCommand.execute(loan_params)
  if result[:success]
    redirect_to result[:loan], notice: "Loan created!"
  else
    redirect_back alert: "Error: #{result[:errors].join(', ')}"
  end
end

Benefits
1.	Separation of Concerns: Controllers handle HTTP, commands handle business logic
2.	Single Responsibility: Each command does one thing well
3.	Easy Testing: Test business logic without HTTP context
4.	Reusability: Use commands from controllers, jobs, console, etc.
5.	Extensibility: Add new commands without changing existing code

Practical Applications
•	Creating and processing loans
•	Approving reservations
•	Processing payments
•	Searching resources
•	User authentication
This pattern keeps your controllers thin and your business logic organized and testable.

How to open the project:
1. Change the ruby version at .ruby-version file (if you are not using version 3.3.6)
2. Run commands in terminal : 
   -bundle install
   -rails db:migrate
   -rails server
3. Open browser to view the wen app created with command pattern
4. Users: 
   -Library user: admin@library.com/password123
   -Library_personnel: arta.dervishi@example.com/password123


Worked by: 
Katia Haveri
Marsela Horeshka
Kejsi Bushi
