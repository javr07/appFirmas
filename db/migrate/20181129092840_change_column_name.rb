class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :signatures, :hash, :claveHash
  end
end
