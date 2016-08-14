class CreateShip < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name, null: false
      t.integer  :hold_capacity, null: false

      t.timestamps null: false
    end
  end
end
