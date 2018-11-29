class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :nombre
      t.string :ruta

      t.timestamps
    end
  end
end
