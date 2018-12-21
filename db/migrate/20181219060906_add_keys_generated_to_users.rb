class AddKeysGeneratedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :generatedKeys, :boolean, default: false
  end
end
