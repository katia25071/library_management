class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.datetime :loan_date, null: false
      t.datetime :due_date, null: false
      t.datetime :return_date
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
