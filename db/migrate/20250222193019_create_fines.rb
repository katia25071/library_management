class CreateFines < ActiveRecord::Migration[7.0]
  def change
    create_table :fines do |t|
      t.references :loan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
