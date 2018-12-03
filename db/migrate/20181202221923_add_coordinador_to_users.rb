class AddCoordinadorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :coordinador, :boolean, default: false
  end
end
