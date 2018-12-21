class CreateSignatures < ActiveRecord::Migration[5.2]
  def change
    create_table :signatures do |t|
      t.string :clavehash
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
