class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :encoded_address
      t.string :key

      t.timestamps
    end
  end
end
