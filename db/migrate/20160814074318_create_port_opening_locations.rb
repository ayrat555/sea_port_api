class CreatePortOpeningLocations < ActiveRecord::Migration
  def change
    create_table :port_opening_locations do |t|
      t.integer :port_id, null: false
      t.date :first_date, null: false
      t.date :last_date, null: false
      t.integer :portable_id
      t.string  :portable_type

      t.timestamps null: false
    end

    add_index :port_opening_locations, [:portable_type, :portable_id]
  end
end
