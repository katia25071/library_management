# Terminal command to generate the migration:
# rails generate migration AddStatusToFines status:string

# The generated migration file will look like:
class AddStatusToFines < ActiveRecord::Migration[7.0]
  def change
    add_column :fines, :status, :string, default: 'unpaid'

    # Ensure all existing fines are marked as unpaid
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE fines SET status = 'unpaid' WHERE status IS NULL
        SQL
      end
    end
  end
end
