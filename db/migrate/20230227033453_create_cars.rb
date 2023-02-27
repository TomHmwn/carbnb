class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :color
      t.string :model
      t.string :brand
      t.integer :price_per_day
      t.references :user, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
