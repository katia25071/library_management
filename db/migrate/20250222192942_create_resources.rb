class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.integer :publish_year, null: false
      t.string :language, null: false
      t.string :publisher
      t.text :description
      t.string :type # For STI: 'Book' or 'Journal'
      t.string :author # For books
      t.integer :volume # For journals
      t.integer :issue # For journals
      t.string :category, null: false
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
