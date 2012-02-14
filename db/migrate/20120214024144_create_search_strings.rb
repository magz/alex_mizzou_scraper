class CreateSearchStrings < ActiveRecord::Migration
  def change
    create_table :search_strings do |t|
      t.string :first_name
      t.string :last_name
      t.integer :completed

      t.timestamps
    end
  end
end
