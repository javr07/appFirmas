class CreateSignatures < ActiveRecord::Migration[5.2]
  def change
    create_table :signatures do |t|
      t.string :clavehash
      t.references :document, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
