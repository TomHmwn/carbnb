class RemoveEmailAddressFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email_address, :string
  end
end
