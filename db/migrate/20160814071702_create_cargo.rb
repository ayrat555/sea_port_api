class CreateCargo < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :name, null: false
      t.integer :volume, null: false

      t.timestamps null: false
    end
  end
end
