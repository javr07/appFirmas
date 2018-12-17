class Droptable < ActiveRecord::Migration[5.2]
  def change
    drop_table :documents_users
  end
end
