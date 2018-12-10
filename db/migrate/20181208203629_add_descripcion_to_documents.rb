class AddDescripcionToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :descripcion, :text
  end
end
