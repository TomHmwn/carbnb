class AddCarTypeToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :car_type, :string
    add_column :cars, :fuel_type, :string
    add_column :cars, :transmission, :string
    add_column :cars, :drive_type, :string
    add_column :cars, :year, :integer
    add_column :cars, :standard_specs, :string
    add_column :cars, :kilometrage, :integer
    add_column :cars, :doors, :integer
  end
end
