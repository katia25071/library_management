# Command Pattern - Simple Guide

## What is the Command Pattern?
The **Command Pattern** is a design pattern that encapsulates a request or action into a standalone object. This object contains all the information needed to perform the action.

### Key Elements:
1. **Command**: An object that encapsulates an action and its parameters.
2. **Invoker**: Requests the command to carry out the action.
3. **Receiver**: Knows how to perform the operations.

---

## How We Implemented It
In our **Library Management System**, we implemented the **Command Pattern** using:

### Base Command Class:
```ruby
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
```

### Example: Create Loan Action
Each specific action is a separate command class. Example:
```ruby
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
```

### How It's Used?
In controllers (**invokers**), we use commands like this:
```ruby
def create
  result = Loans::CreateCommand.execute(loan_params)
  if result[:success]
    redirect_to result[:loan], notice: "Loan created!"
  else
    redirect_back alert: "Error: #{result[:errors].join(', ')}"
  end
end
```

---

## Benefits of Using the Command Pattern
1. **Separation of Concerns**: Controllers handle HTTP logic, while commands handle business logic.
2. **Single Responsibility Principle**: Each command is responsible for a single task.
3. **Easy Testing**: Business logic can be tested independently from controllers.
4. **Reusability**: Commands can be used in controllers, background jobs, or the console.
5. **Extensibility**: New commands can be added without modifying existing code.

### Practical Applications:
- Creating and processing loans.
- Approving reservations.
- Processing payments.
- Searching resources.
- User authentication.

This pattern keeps controllers **thin** and business logic **organized** and **testable**.

---

## How to Run the Project
1. Ensure your **Ruby version** matches the one in the `.ruby-version` file (or install **Ruby 3.3.6** if needed).
2. Run the following commands in your terminal:
   ```sh
   bundle install
   rails db:migrate
   rails server
   ```
3. Open your browser to access the web application.

### User Credentials:
- **Library User**: `admin@library.com / password123`
- **Library Personnel**: `arta.dervishi@example.com / password123`

---

## Developed By:
- **Katia Haveri**
- **Marsela Horeshka**
- **Kejsi Bushi**

