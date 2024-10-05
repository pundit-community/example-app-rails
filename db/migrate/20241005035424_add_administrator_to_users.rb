class AddAdministratorToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :administrator, :boolean, default: false
  end
end
