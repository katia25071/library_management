class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :contact_address
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :user_type, null: false # 'library_user' or 'library_personnel'

      t.timestamps
    end
  end
end
