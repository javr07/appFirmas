class CreateSignatures < ActiveRecord::Migration[5.2]
  def change
    create_table :signatures do |t|
      t.string :hash
      t.datetime :fecha

      t.timestamps
    end
  end
end
