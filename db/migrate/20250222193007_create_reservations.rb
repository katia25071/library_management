class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.datetime :reservation_date, null: false
      t.datetime :expiration_date, null: false
      t.string :status, default: 'pending' # pending, approved, rejected

      t.timestamps
    end
  end
end
